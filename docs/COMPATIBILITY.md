# Compatibility

[English](COMPATIBILITY.md) · [简体中文](COMPATIBILITY.zh-Hans.md) · [繁體中文](COMPATIBILITY.zh-Hant.md)

Last verified: **2026-08-23**

| Component | Verified state | Notes |
| --- | --- | --- |
| My T | [Current public App Store release](https://apps.apple.com/app/id6780299502), iPhone, iOS 18+ | The [generated release record](app-store-release.json) follows Apple automatically. Development capabilities remain pre-release until Apple publishes them. iPad is not a documented target. |
| TeslaMateAPI | `1.25.0` | Main TeslaMate data interface |
| TeslaMate | `4.2.0` in the signed HostBox stable catalog | Vehicle data reaches My T through TeslaMateAPI. The complete My T path was validated before 4.2.0 entered the signed catalog. |
| My T Companion | [HostBox signed stable catalog](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [upstream latest release](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox deploys only the catalog-pinned release and archive digest. Compatibility is also negotiated through `/api/v1/capabilities`, not a version string alone. |
| Authentication | None only on a trusted LAN/VPN; Basic; Bearer; Cloudflare Access | Public HTTP without authentication is unsupported |
| Network | LAN, Tailscale/VPN, HTTPS reverse proxy, Cloudflare Tunnel | API root URL required |

The permanent links above discover both the signed deployment recommendation
and GitHub's current upstream release without copying a version number into
this document. A newer upstream release is not an automatic deployment
recommendation: HostBox waits for catalog signing after end-to-end validation.
My T also enables an enhancement only when the server reports its capability.

This is a dated validation record, not a promise that every older or future
upstream version is compatible. TeslaMate and TeslaMateAPI are independent
projects and can change without a My T release.

Before upgrading server components:

1. Back up PostgreSQL and configuration.
2. Record currently running image references and digests.
3. Read upstream breaking-change notes.
4. Change one component at a time.
5. Verify TeslaMate collection and TeslaMateAPI health.
6. Run My T **Test Connection**.
7. Check overview, one drive, one charge, and current vehicle status.
8. If installed, verify `/api/v1/capabilities` through the normal My T URL.

Report compatibility results without credentials, VINs, locations, or raw
production data.
