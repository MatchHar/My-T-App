# Public release checklist

This repository is public product documentation. It intentionally does not
contain the private My T application source code.

## Before changing repository visibility

- [ ] Confirm the App Store version and
      [feature-availability notice](docs/FEATURE_AVAILABILITY.md) are current.
- [ ] Confirm every screenshot contains demonstration data only.
- [ ] Scan files and Git history for credentials, signing material, private
      infrastructure, VINs, coordinates, logs, and personal account data.
- [ ] Verify English, Simplified Chinese, and Traditional Chinese navigation.
- [ ] Verify TeslaMate, TeslaMateAPI, My T Parking Monitor, App Store, privacy,
      security, support, and license links.
- [ ] Confirm the Parking Monitor repository remains clearly marked optional
      and does not claim support in an unreleased App Store build.
- [ ] Confirm no app source, provisioning profile, certificate, archive,
      internal build file, or private server configuration is tracked.
- [ ] Confirm the repository-local pre-commit boundary is enabled with
      `git config core.hooksPath .githooks`.
- [ ] Configure branch protection, secret scanning, Dependabot alerts, and
      private vulnerability reporting where GitHub makes them available.
- [ ] Confirm GitHub Actions billing/spending limits permit required checks.

## Immediately after publication

- [ ] Open the repository in a signed-out browser.
- [ ] Check all three README pages and setup guides.
- [ ] Verify the App Store and upstream project links from a signed-out browser.
- [ ] Confirm issues do not solicit secrets, raw logs, database exports, VINs,
      or exact vehicle coordinates.
- [ ] Keep `docs/FEATURE_AVAILABILITY.md` synchronized with every public My T
      release.
