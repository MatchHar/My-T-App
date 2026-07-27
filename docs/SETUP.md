# My T setup guide

[简体中文](SETUP.zh-Hans.md) · [繁體中文](SETUP.zh-Hant.md)

This guide covers the My T-specific connection steps. Use the upstream
[TeslaMate Docker guide](https://docs.teslamate.org/docs/installation/docker/)
and [TeslaMateAPI repository](https://github.com/tobiasehlert/teslamateapi) as
the source of truth for their own installation files.

## 1. Choose the topology first

| Scenario | Recommended access | My T URL example |
| --- | --- | --- |
| Home server, same trusted Wi-Fi | Private LAN | `http://192.168.1.10:8080` |
| Home server while away | Tailscale/WireGuard VPN | `http://100.x.x.x:8080` |
| VPS | HTTPS reverse proxy + authentication | `https://api.example.com` |
| VPS without inbound ports | Cloudflare Tunnel + Access | `https://api.example.com` |

An HTTP URL is acceptable only inside a trusted LAN or private VPN. Never
publish an unauthenticated HTTP API to the Internet.

## 2. Deploy and verify TeslaMate

Follow the official TeslaMate instructions. Before adding any API:

- TeslaMate is healthy and collecting the expected vehicle.
- The TeslaMate web interface is reachable where intended.
- PostgreSQL and MQTT are not exposed to the Internet.
- Encryption and database secrets are unique and backed up.
- A database backup and restore procedure has been tested.

My T never asks for the Tesla account password. Tesla account authorization is
handled by TeslaMate.

## 3. Add TeslaMateAPI

Follow the upstream TeslaMateAPI Docker instructions and connect it to the same
PostgreSQL and MQTT services as TeslaMate. For My T:

- Set a random `API_TOKEN` of at least 32 characters.
- Keep `ENABLE_COMMANDS=false`; My T viewing features do not require server
  command endpoints.
- Keep PostgreSQL and MQTT on the private Docker network.
- On a VPS, bind the API only to localhost, for example
  `127.0.0.1:8080:8080`, then place it behind a secure access layer.
- On a trusted LAN, a LAN-bound port may be used, but router port forwarding
  must remain disabled.
- Record the exact image digest before upgrades and test My T after every
  upstream change. Do not automate unreviewed `latest` updates.

Generate a token without placing a real secret in documentation:

```sh
openssl rand -hex 32
```

Store it only in the server `.env` and My T. Never paste it into an issue,
screenshot, shell transcript, or public repository.

### Local verification

TeslaMateAPI currently exposes its version in the `API-Version` response
header. A HEAD request may return a non-200 status on some versions, so inspect
the header without treating the status alone as the health result:

```sh
curl -sS -D - -o /dev/null http://127.0.0.1:8080/api/ping
curl -sS http://127.0.0.1:8080/api/healthz
```

As of 2026-07-27, My T has been verified against TeslaMateAPI `1.25.0`.

## 4. Secure remote access

Choose one:

1. **Tailscale/WireGuard:** preferred when only your own devices need access.
2. **HTTPS reverse proxy:** Caddy, Nginx, or Traefik with TLS and Basic or
   Bearer authentication.
3. **Cloudflare Tunnel + Access:** no public inbound API port; use a Service
   Token policy for the app.

Security boundaries:

- Do not expose ports 3000, 4000, 5432, 1883, 8080, or 8083 directly to the
  public Internet.
- Do not use a query-string token. Tokens in URLs can leak through logs and
  browser history.
- Do not enable every TeslaMateAPI command group.
- Do not disable API authentication merely because an upstream example does.
- Protect backups as carefully as the live database.

## 5. Connect My T

In My T open **Settings → Server Connections → TeslaMate Server**.

Enter the API root URL:

- Correct: `https://api.example.com`
- Correct on LAN: `http://192.168.1.10:8080`
- Incorrect: `http://192.168.1.10:4000` (TeslaMate web interface)
- Incorrect: `https://api.example.com/api/v1/cars` (endpoint, not root URL)

Choose the matching authentication:

| Server protection | My T selection |
| --- | --- |
| Trusted LAN/VPN with no API authentication | None |
| Reverse-proxy username/password | Basic Auth |
| TeslaMateAPI `API_TOKEN` | Bearer Token |
| Cloudflare Access | Cloudflare Service Token, plus API auth if configured |

Run **Test Connection**. My T checks server reachability, authentication, API
compatibility, and vehicle discovery separately. Do not save a connection that
only passes the first network step.

## 6. Optional TeslaMate web URL

My T may probe the TeslaMate web interface to display its installed version.
This is optional and does not provide normal vehicle data. If a remote web
hostname is exposed, protect it with the same VPN or Access boundary. Failure
to show the TeslaMate version does not mean the vehicle API connection failed.

## 7. Optional My T Parking Monitor

Install [My T Parking Monitor](https://github.com/MatchHar/My-T-Parking-Monitor)
only after the normal TeslaMateAPI connection works.

It adds genuine long-term parking state history and reliable current-drive
trajectory data. It:

- reads the existing TeslaMate PostgreSQL database in read-only mode;
- does not create a second vehicle-history database;
- uses the same My T base URL and authentication;
- keeps port 8083 bound to localhost;
- requires its three routes to share the normal TeslaMateAPI base URL.

If My T connects directly to `LAN-IP:8080` without a unified reverse proxy, the
optional component cannot be discovered. Basic My T features remain available.

## 8. Troubleshooting

| Symptom | Check |
| --- | --- |
| Timeout | Wi-Fi/VPN route, firewall, DNS, container state |
| TLS error | Valid certificate, hostname match, complete certificate chain |
| HTTP 401 | Basic/Bearer credentials and header selection |
| HTTP 403 | Cloudflare Access policy and Service Token |
| HTTP 404 | API root URL, reverse-proxy path routing, wrong port 4000 |
| No vehicles | TeslaMate login/collection, database access, API logs |
| Version unavailable | Optional TeslaMate web endpoint; normal API may still work |
| Parking Monitor unavailable | `/api/v1/capabilities` must route on the same base URL |

When requesting support, provide only redacted versions, HTTP status, proxy
type, and reproduction steps. Never provide credentials, VINs, coordinates,
`.env`, raw logs, or database exports.
