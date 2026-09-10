#!/usr/bin/env bash
# Only a public Apple record may be proposed. Main is never pushed directly.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
record=docs/app-store-release.json
repo=${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}
test "$repo" = "MatchHar/My-T-App" || { echo "Unexpected repository" >&2; exit 1; }
test "$(git branch --show-current)" = main || { echo "Sync must start from main" >&2; exit 1; }

if git diff --quiet -- "$record"; then
  echo "Apple public version is unchanged; no pull request needed."
  exit 0
fi
# Reject a dirty checkout, untracked product work or pre-staged changes.
test "$(git diff --name-only)" = "$record" || { echo "Unexpected changed files" >&2; exit 1; }
git diff --cached --quiet || { echo "Unexpected staged changes" >&2; exit 1; }
test -z "$(git ls-files --others --exclude-standard)" || { echo "Unexpected untracked files" >&2; exit 1; }
version=$(python3 -c 'import json,sys; sys.path.insert(0,"scripts"); from sync_app_store_release import version_parts; v=json.load(open(sys.argv[1]))["version"]; version_parts(v); print(v)' "$record")
base=$(git rev-parse HEAD)
branch="automation/app-store-version-${version}-${base:0:12}"

# No force-push and no reused branch with unrelated content. A rerun reuses
# the already-pushed exact version proposal instead of generating daily PRs.
if git ls-remote --exit-code --heads origin "refs/heads/$branch" >/dev/null 2>&1; then
  git fetch --no-tags origin "$branch"
  candidate=$(git rev-parse FETCH_HEAD)
  test "$(git rev-parse "$candidate^")" = "$base" || { echo "Unexpected proposal parent" >&2; exit 1; }
  test "$(git diff --name-only "$base" "$candidate")" = "$record" || { echo "Unexpected proposal files" >&2; exit 1; }
  git show "$candidate:$record" | python3 -c 'import json,sys; sys.path.insert(0,"scripts"); from sync_app_store_release import STABLE_KEYS; remote=json.load(sys.stdin); local=json.load(open(sys.argv[1])); assert all(remote.get(k)==local.get(k) for k in STABLE_KEYS), "Proposal differs from Apple lookup"' "$record"
else
  git switch -c "$branch"
  git config user.name "github-actions[bot]"
  git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
  git add -- "$record"
  git commit -m "docs: sync public App Store version $version"
  candidate=$(git rev-parse HEAD)
  test "$(git diff --name-only "$base" "$candidate")" = "$record"
  git push origin "HEAD:refs/heads/$branch"
fi

number=$(gh pr list --repo "$repo" --base main --head "$branch" --state open --json number --jq '.[0].number // empty')
if [ -z "$number" ]; then
  gh pr create --repo "$repo" --base main --head "$branch" \
    --title "docs: sync public App Store version $version" \
    --body "Apple's public lookup reports My T $version. This automated proposal changes only the public release record. The documentation workflow is dispatched on the candidate commit, and the existing required checks must pass before squash merge. No App upload, review or server deployment is performed."
  number=$(gh pr list --repo "$repo" --base main --head "$branch" --state open --json number --jq '.[0].number // empty')
fi
test -n "$number" || { echo "Could not resolve the release-record PR" >&2; exit 1; }
test "$(gh pr view "$number" --repo "$repo" --json headRefOid --jq .headRefOid)" = "$candidate" || { echo "PR head changed" >&2; exit 1; }

# Explicit dispatch is supported even when the previous event used GITHUB_TOKEN.
# docs.yml is read-only and checks the branch head; normal protection still gates merge.
gh workflow run docs.yml --repo "$repo" --ref "$branch"
gh pr merge "$number" --repo "$repo" --auto --squash --match-head-commit "$candidate"
printf 'Public version %s proposed in PR #%s; required checks gate automatic merge.\n' "$version" "$number"
if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  printf 'Public version **%s** proposed in [PR #%s](https://github.com/%s/pull/%s). Required documentation checks must pass before merge.\n' "$version" "$number" "$repo" "$number" >> "$GITHUB_STEP_SUMMARY"
fi
