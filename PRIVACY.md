# Privacy

Last updated: 2026-07-28

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

## Optional My T Companion

My T Companion runs on the user's TeslaMate host. It reads the existing
PostgreSQL database in read-only mode and returns requested data directly to My
T through the user's own secured endpoint. It does not operate a second vehicle
history store.

## Optional vehicle software notifications

If the user enables vehicle software notifications in a compatible My T
version, Apple Push Notification service requires an App-operated delivery
relay. The relay stores the APNs device token and an opaque installation
identifier needed to address that installation.

The user's My T Companion sends only a signed software-update event: the
opaque installation ID, TeslaMate car ID or display label, reported update
type/version, and observation time. It does **not** send VIN, location,
TeslaMate credentials, database passwords, battery data, routes, charging
history, or driving history.

## Optional charging Live Activities

When a compatible My T build and My T Companion 1.9.2 are paired, the same
delivery relay can start and update a Lock Screen or Dynamic Island charging
Live Activity while the App is not open. The minimal signed event can contain
the opaque installation ID, car ID or display label, charging session ID,
start/current/target battery percentage, genuine rated-range readings and
range gain, charging power, remaining duration, and estimated completion time.

This path does **not** send VIN, location, routes, TeslaMate credentials,
database passwords, driving history, or kWh. Missing range values are omitted
rather than estimated. APNs and Live Activity tokens are used only to address
the user's own App installation.

Each installation uses a unique secret and signed requests. Disabling the
notification feature does not affect parking, navigation, or other self-hosted
features. This notification path is separate from normal vehicle-history
access, which continues directly between the user's server and My T.

## Public support

Never submit credentials, server addresses, VINs, GPS coordinates, `.env`
files, database exports, screenshots containing private locations, or raw
production logs to a public GitHub issue.

Questions about the App Store privacy disclosure should use the
[official support page](https://my-t-privacy-policy.pages.dev/support/).
