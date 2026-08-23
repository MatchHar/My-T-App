# Documentation changelog

[English](CHANGELOG.md) · [简体中文](CHANGELOG.zh-Hans.md) · [繁體中文](CHANGELOG.zh-Hant.md)

## Unreleased

- Expanded the English, Simplified Chinese, and Taiwan Traditional Chinese
  privacy documents to the same complete nine-section data-handling scope.
- Completed three-language end-to-end compatibility validation on August 23,
  2026 for TeslaMate 4.2.0, TeslaMateAPI 1.25.0, and the signed HostBox
  Companion 1.10.29 catalog target.
- Added CI checks that prevent language-policy drift, mutable TeslaMateAPI
  `latest` instructions, and fixed Companion release-tag links.
- Replaced “always install upstream latest” wording with dynamic links to both
  the signed HostBox recommendation and upstream latest release. Newer upstream
  tags remain informational until end-to-end validation.

- Replaced hard-coded My T App Store version text with an Apple-backed badge,
  a generated release record, and a daily synchronization workflow.
- Reverified Companion compatibility against both the signed catalog and the
  permanent latest-release link on August 23, 2026; the signed stable release
  at verification time was 1.10.29, while compatibility remains capability-based.
- Added complete Simplified Chinese and Traditional Chinese privacy, support,
  and security documents with locale-correct links.
- Documented locked-and-unoccupied notifications, device-local imported sound
  handling, `.mytconnection` sharing, and unregister retry behavior.
- Restored the required `links` CI check with local Markdown validation and
  signed-out checks of the public App Store, Companion, website, privacy, and
  support endpoints.

## Historical documentation updates

- Updated public product status and all three language entry pages for the My T
  4.01.1 App Review submission.
- Replaced hard-coded “current Companion version” text with GitHub's permanent
  `/releases/latest` link and a dynamic release badge. Compatibility continues
  to be negotiated by capabilities, avoiding stale documentation after routine
  Companion releases.
- Expanded the trilingual feature notice to cover observed vehicle opening,
  security, climate and charging activity plus departure, progress and arrival
  updates for destination trips.
- Corrected the recommended Companion release from 1.10.2 to the verified
  then-current stable **1.10.7**, added its navigation-session capabilities, and
  linked directly to the matching GitHub Release.
- Made the relationship bidirectional: My-T-App links to the exact Companion
  release while Companion links back to My-T-App availability and setup docs.
- Synchronized the App Store 3.32 English, Simplified Chinese, and Traditional
  Chinese release description and public product/support/privacy links.
- Replaced the previous four-image gallery with the 18 localized 3.32 App Store
  screenshots: overview/notification, enhanced parking, charging/Lock Screen,
  destination navigation, drive replay, and battery trends.
- Updated feature availability and compatibility without prematurely claiming
  release: 3.32 was submitted on August 1, 2026 and is waiting for Apple review.
- Expanded the English, Simplified Chinese, and Traditional Chinese product
  introduction with event-by-event long-term parking behavior: plug, charging,
  lock, openings, Sentry, climate, preconditioning, battery heating, and
  truthful missing-data handling.
- Updated the recommended My T Companion release to 1.10.0 and documented its
  long-term bounded parking storage and backup/restore lifecycle.

- Updated My T Companion guidance to 1.9.3 and documented repeated-pairing MQTT
  stability, finite parking-event retention, navigation Live Activity privacy,
  and Push Relay 1.1.0 registration cleanup/health behavior.
- Corrected TeslaMate/Tessie source wording, setup route counts, public
  security-reporting instructions, and the issue template's server scope.
- Added an automated public-repository boundary check.
- Clarified feature availability: App Store remains My T 3.10; TestFlight /
  pre-release My T 3.20+ supports Companion 1.9.2; replaced outdated 1.5.0
  notification-only wording and “future events” language with current 1.9.2
  capabilities.
- Updated the documented and verified My T Companion release to 1.9.2,
  including retained genuine plug/charging, security/opening, climate, and
  charge-port parking events.
- Updated My T Companion compatibility to 1.6.1 and documented optional
  charging Live Activities using genuine TeslaMate MQTT readings.
- Updated My T Companion compatibility to the published 1.5.1 security
  maintenance release.
- Documented the privacy boundary for optional native software-update
  notifications and the minimal data handled by the delivery relay.
- Clarified that the 1.5.0 notification service remains inactive until a
  compatible My T build completes secure pairing.
- Created the public, source-free My T product documentation repository.
- Added English, Simplified Chinese, and Traditional Chinese product pages.
- Added secure TeslaMate/TeslaMateAPI setup guides and troubleshooting.
- Documented the optional My T Companion relationship.
- Added privacy, security, support, compatibility, and issue-reporting rules.
- Added a dated feature-availability notice so unpublished My T Companion
  screens are not confused with the current App Store build.
- Clarified that TeslaMate is the primary collector, TeslaMateAPI is the normal
  JSON bridge, and My T Companion is an optional read-only enhancement.
- Added direct App Store, TeslaMate, TeslaMateAPI, and My T Companion links
  across the product and setup documentation.
- Added a public-release checklist for repository settings, signed-out link
  verification, and source-code/privacy boundaries.

App release notes remain available through the App Store.
