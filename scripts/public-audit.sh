#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

fail() {
  printf 'PUBLIC AUDIT FAILED: %s\n' "$*" >&2
  exit 1
}

if find . -type f \( \
  -name '*.env' -o -name '.env*' -o -name '*.pem' -o -name '*.key' \
  -o -name '*.p12' -o -name '*.mobileprovision' -o -name '*.dump' \
  -o -name '*.sql' -o -name '*.log' \
  \) -not -path './.git/*' | grep -q .; then
  find . -type f \( \
    -name '*.env' -o -name '.env*' -o -name '*.pem' -o -name '*.key' \
    -o -name '*.p12' -o -name '*.mobileprovision' -o -name '*.dump' \
    -o -name '*.sql' -o -name '*.log' \
    \) -not -path './.git/*'
  fail "prohibited private file type found"
fi

if grep -RInE \
  'BEGIN (RSA|OPENSSH|EC) PRIVATE KEY|Authorization:[[:space:]]*Bearer[[:space:]]+[A-Za-z0-9_-]{20,}|CF-Access-Client-Secret:[[:space:]]*[^<[:space:]]{12,}|API_TOKEN=[A-Za-z0-9_-]{20,}' \
  --exclude-dir=.git --exclude='public-audit.sh' .; then
  fail "possible credential found"
fi

while IFS= read -r markdown; do
  while IFS= read -r target; do
    case "$target" in
      http://*|https://*|mailto:*|\#*|"") continue ;;
    esac
    target="${target%%#*}"
    [[ -e "$(dirname "$markdown")/$target" ]] \
      || fail "broken local link in $markdown: $target"
  done < <(sed -nE 's/.*\]\(([^)]+)\).*/\1/p; s/.*src="([^"]+)".*/\1/p' "$markdown")
done < <(find . -type f -name '*.md' -not -path './.git/*')

printf 'Public repository audit passed.\n'
