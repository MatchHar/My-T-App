# Public App Store version synchronization

The daily workflow reads Apple's public lookup for My T only. It never reads
private App Store Connect review state and does not upload or publish an App.
Unchanged responses do not produce daily timestamp commits; unexpected apps,
malformed versions and backwards versions fail without changing the record.

Changes go to a version-and-base-specific `automation/app-store-version-*`
branch, containing only `docs/app-store-release.json`. The workflow creates or
reuses its pull request, explicitly dispatches the read-only documentation
workflow on that branch, and requests squash auto-merge. The existing required
`links`, `public-boundary`, `language-parity` and `secrets` checks and strict
up-to-date protection remain authoritative. There is no direct push to main,
force push, review-approval step or administrator bypass.

Explicit dispatch matters: events produced with `GITHUB_TOKEN` do not normally
run push workflows, and token-created PR workflows may require approval.
`workflow_dispatch` is supported by GitHub for this case.

Repository configuration must allow Actions to create pull requests and allow
auto-merge. The default workflow token permission may remain read-only; this
one job requests only contents, pull-request and Actions write access. The
workflow never changes repository settings and needs no PAT, stored GitHub
App key or new secret. If the required settings are disabled, its failing
step makes the missing permission visible rather than bypassing protection.

To verify a changed record, dispatch `Sync public App Store version` on main,
inspect the generated JSON-only PR, its head-SHA documentation checks and its
protected merge. Dispatch again to verify the no-change path. Public release
JSON is the automated current record; dated feature/review snapshots in prose
remain historical snapshots until deliberately updated.

References: [GITHUB_TOKEN events](https://docs.github.com/en/actions/concepts/security/github_token),
[workflow triggers](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow),
[repository Actions settings](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository).
