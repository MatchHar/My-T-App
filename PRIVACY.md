# Privacy

Last updated: 2026-07-29

The public privacy policy is available at
[https://my-tesla.app/privacy/](https://my-tesla.app/privacy/).
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
T through the user's own secured endpoint. It does not copy the full TeslaMate
vehicle history. To preserve events that iOS cannot reconstruct later, it keeps
a bounded Companion-owned parking-event log (up to the newest 50,000 events by
default) containing
observed state boundaries such as sleep/wake, plug/charging, security/opening,
and climate changes. This remains on the user's own VPS in the Companion data
volume.

## Optional vehicle software notifications

If the user enables vehicle software notifications in a compatible My T
version, Apple Push Notification service requires an App-operated delivery
relay. The relay stores the APNs device token and an opaque installation
identifier needed to address that installation, optional charging/navigation
push-to-start tokens, per-session Live Activity update tokens, locale, and
created/last-active timestamps.

The user's My T Companion sends only a signed software-update event: the
opaque installation ID, TeslaMate car ID or display label, reported update
type/version, and observation time. It does **not** send VIN, location,
TeslaMate credentials, database passwords, battery data, routes, charging
history, or driving history.

## Optional charging Live Activities

My T Companion 1.10.0 established the compatibility floor for charging Live
Activities. When a compatible My T build and a supported
[stable Companion release](https://github.com/MatchHar/My-T-Companion/releases/latest)
are paired, the same delivery relay can start and update a Lock Screen or
Dynamic Island charging Live Activity while the App is not open. The minimal
signed event can contain
the opaque installation ID, car ID or display label, charging session ID,
start/current/target battery percentage, genuine rated-range readings and
range gain, charging power, remaining duration, and estimated completion time.

This path does **not** send VIN, location, routes, TeslaMate credentials,
database passwords, driving history, or kWh. Missing range values are omitted
rather than estimated. APNs and Live Activity tokens are used only to address
the user's own App installation.

## Optional navigation Live Activities

For an active destination, the minimal signed event can contain the opaque
installation ID, car ID or display label, navigation session ID, destination
label, remaining distance and minutes, estimated arrival time, predicted
arrival battery percentage, driven/total distance, and whether the drive
trajectory was verified from TeslaMate. It does **not** contain GPS
coordinates, the full route, VIN, TeslaMate credentials, or database
passwords.

## Push relay retention

The relay reuses an installation identity when the same APNs device token
registers again, removes historical duplicates, and deletes registrations
after 365 days without a registration or signed event by default. Cleanup runs
at service startup and every 24 hours. The relay operator may configure a
different bounded retention period. A successful Live Activity end also
removes that session's update token.

Each installation uses a unique secret and signed requests. Disabling the
notification feature does not affect parking, navigation, or other self-hosted
features. This notification path is separate from normal vehicle-history
access, which continues directly between the user's server and My T.

## Public support

Never submit credentials, server addresses, VINs, GPS coordinates, `.env`
files, database exports, screenshots containing private locations, or raw
production logs to a public GitHub issue.

Questions about the App Store privacy disclosure should use the
[official support page](https://my-tesla.app/support/).
