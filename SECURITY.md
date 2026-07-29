# Security policy

## Scope

Security reports may cover My T's documented server connection behavior,
credential handling, public documentation, or the optional My T Companion.
The App source code is private and is not part of this repository.

## Reporting

Do not open a public issue for a possible vulnerability. Use this repository's
[private vulnerability reporting](https://github.com/MatchHar/My-T-App/security/advisories/new)
without including a working production secret or unredacted vehicle data.

Include:

- affected My T/My T Companion version;
- iOS and server component versions;
- network/authentication type;
- minimal redacted reproduction steps;
- impact and safe proof of concept.

Never include:

- a production password, token, cookie, private key, or `.env`;
- VIN, plate, GPS coordinates, route history, or database exports;
- a live server address that is not deliberately disposable.

## Deployment baseline

- No unauthenticated public API.
- No public PostgreSQL, MQTT, Grafana, TeslaMate web, TeslaMateAPI, or My T
  Companion container ports.
- HTTPS or a private VPN for remote access.
- Unique secrets stored outside Compose source.
- Commands disabled unless the user separately understands and authorizes
  them.
- Tested backup and restore.
