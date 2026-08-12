# Compatibility

Last verified: **2026-08-12**

| Component | Verified state | Notes |
| --- | --- | --- |
| My T | Public App Store **3.10**, iPhone, iOS 18+ | Verified against Apple’s public listing. Newer development capabilities remain pre-release until that listing changes. iPad is not a documented target. |
| TeslaMateAPI | `1.25.0` | Main TeslaMate data interface |
| TeslaMate | `4.0.1` on the validation server | Vehicle data reaches My T through TeslaMateAPI |
| My T Companion | [latest stable release](https://github.com/MatchHar/My-T-Companion/releases/latest), verified as **1.10.16** | Compatibility is negotiated through `/api/v1/capabilities`, not an exact version string. Use the latest stable release for long-term parking history, verified trajectories, destination-trip sessions, Live Activities and software notifications. |
| Authentication | None only on a trusted LAN/VPN; Basic; Bearer; Cloudflare Access | Public HTTP without authentication is unsupported |
| Network | LAN, Tailscale/VPN, HTTPS reverse proxy, Cloudflare Tunnel | API root URL required |

The permanent Companion link above always resolves to GitHub's current stable
release, so routine Companion releases do not require a documentation edit.
Compatibility remains capability-based: My T enables an enhancement only when
the server reports the required capability.

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
