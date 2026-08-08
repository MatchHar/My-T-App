# Support

## Before opening an issue

1. Confirm TeslaMate is collecting the expected vehicle.
2. Confirm TeslaMateAPI is healthy locally.
3. Confirm the iPhone has the required LAN/VPN/HTTPS route.
4. Run My T **Test Connection** and note which stage fails.
5. Review [the setup guide](docs/SETUP.md) and
   [compatibility notes](docs/COMPATIBILITY.md).

## Safe diagnostic information

You may provide:

- My T version and build number.
- iOS version and iPhone model.
- TeslaMate and TeslaMateAPI versions.
- Network type: LAN, VPN/Tailscale, HTTPS proxy, or Cloudflare.
- Authentication type, without the credential.
- HTTP status such as 401, 403, 404, or timeout.
- Redacted reproduction steps.

Do not provide:

- Passwords, API tokens, Cloudflare Client Secret, cookies, or QR codes.
- Tesla account information.
- VIN, number plate, precise location, home/work address, or route history.
- Public server hostname or IP unless intentionally public and non-sensitive.
- `.env`, Docker secrets, database dumps, or raw logs.

## Where to ask

- Product/setup bug: use the repository issue template.
- Security problem: follow [SECURITY.md](SECURITY.md); do not create a public
  issue.
- App Store/privacy/support request:
  [official My T support](https://my-tesla.app/support/).
- TeslaMate or TeslaMateAPI upstream problem: use the respective upstream
  project after confirming the issue is not specific to My T.

Support is provided on a reasonable-effort basis. This independent project
cannot provide official support for Tesla, TeslaMate, TeslaMateAPI, Cloudflare,
Tailscale, or other third-party services.
