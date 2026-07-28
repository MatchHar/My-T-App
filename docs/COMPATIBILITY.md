# Compatibility

Last verified: **2026-07-27**

| Component | Verified state | Notes |
| --- | --- | --- |
| My T | iPhone, iOS 18+ | iPad is not a documented target |
| TeslaMateAPI | `1.25.0` | Main TeslaMate data interface |
| TeslaMate | `4.0.1` on the validation server | Vehicle data still reaches My T through TeslaMateAPI |
| My T Parking Monitor | public release `1.5.0` | Optional progressive enhancement; push remains off until paired by a compatible My T build |
| Authentication | None on trusted LAN/VPN; Basic; Bearer; Cloudflare Access | Public HTTP without authentication is unsupported |
| Network | LAN, Tailscale/VPN, HTTPS reverse proxy, Cloudflare Tunnel | API root URL required |

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
