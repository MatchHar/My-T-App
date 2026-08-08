# Contributing

This repository accepts documentation corrections, translation improvements,
setup clarifications, and reproducible bug reports. It does not accept or
publish the private My T application source code.

Before opening an issue or pull request:

1. Remove server addresses, tokens, cookies, VINs, precise vehicle locations,
   database exports, screenshots containing personal data, and production logs.
2. State the My T, TeslaMate, TeslaMateAPI, and optional My T Companion
   versions where relevant.
3. Separate observed behavior from expected behavior and include minimal,
   redacted reproduction steps.
4. Use GitHub private vulnerability reporting for security issues; do not
   disclose them in a public issue.

After cloning, enable the repository safety hook once:

```sh
git config core.hooksPath .githooks
```

Before every pull request, run `scripts/verify-public-boundary.sh`. The same
check runs in GitHub Actions, but the local hook helps prevent sensitive file
types or private project paths from entering a commit.

Translations should preserve the same technical meaning in English,
Simplified Chinese, and Traditional Chinese. Product claims must match the
public App Store release described in `docs/FEATURE_AVAILABILITY.md`.
