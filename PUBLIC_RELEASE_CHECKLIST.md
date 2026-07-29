# Public repository maintenance record

This repository is already public product documentation. It intentionally does
not contain the private My T application source code.

## Verified publication baseline

- Repository visibility is public.
- App source, Xcode projects, provisioning profiles, certificates, archives,
  internal build files, and private server configuration are excluded.
- Secret scanning, push protection, Dependabot security updates, and private
  vulnerability reporting are enabled.
- English, Simplified Chinese, and Traditional Chinese product/setup
  navigation is present.
- TeslaMate, TeslaMateAPI, My T Companion, App Store, privacy, security,
  support, and license destinations are documented.
- My T Companion is clearly optional, and feature availability distinguishes
  the public App Store build from TestFlight/pre-release builds.
- The repository-local pre-commit boundary is enabled with
  `git config core.hooksPath .githooks`.

## Required for every documentation release

- [ ] Confirm App Store and TestFlight versions in
      [feature availability](docs/FEATURE_AVAILABILITY.md).
- [ ] Confirm recommended TeslaMate, TeslaMateAPI, and My T Companion versions
      in [compatibility](docs/COMPATIBILITY.md).
- [ ] Verify screenshots contain demonstration data only.
- [ ] Run the public-boundary check and inspect the complete staged diff.
- [ ] Verify external links from a signed-out browser.
- [ ] Confirm issues do not request secrets, raw logs, database exports, VINs,
      server addresses, or exact vehicle coordinates.
- [ ] Confirm GitHub Actions completed successfully.
