# Privacy

Last updated: 2026-07-27

The public privacy policy is available at
[my-t-privacy-policy.pages.dev](https://my-t-privacy-policy.pages.dev/).
This file explains the self-hosted data path in practical terms.

## Vehicle data

For a self-hosted TeslaMate connection, My T reads vehicle information from
the server URL configured by the user. Vehicle history remains in the user's
TeslaMate PostgreSQL database. My T does not route that history through a
developer-operated vehicle database.

For a Tessie connection, data access is governed by the user's Tessie account
and Tessie's service terms.

## Credentials

Server URLs and authentication credentials are stored using iOS security
facilities, including Keychain for secrets. My T does not ask for a Tesla
account password.

If the user explicitly enables iCloud configuration sync, connection
configuration and credential copies may sync through the user's private iCloud
account so their devices can restore the setup. Vehicle drives, charges, GPS
history, and TeslaMate database contents are not copied into that configuration
backup.

## Optional Parking Monitor

My T Parking Monitor runs on the user's TeslaMate host. It reads the existing
PostgreSQL database in read-only mode and returns requested data directly to My
T through the user's own secured endpoint. It does not operate a second vehicle
history store.

## Public support

Never submit credentials, server addresses, VINs, GPS coordinates, `.env`
files, database exports, screenshots containing private locations, or raw
production logs to a public GitHub issue.

Questions about the App Store privacy disclosure should use the
[official support page](https://my-t-privacy-policy.pages.dev/support/).
