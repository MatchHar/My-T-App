#!/usr/bin/env python3
"""Synchronize Apple's public My T version without predicting App Review."""

from __future__ import annotations

import datetime as dt
import json
import urllib.request
from pathlib import Path

APP_ID = "6780299502"
LOOKUP_URL = f"https://itunes.apple.com/lookup?id={APP_ID}&country=us"
OUTPUT = Path(__file__).resolve().parents[1] / "docs" / "app-store-release.json"


def main() -> None:
    request = urllib.request.Request(
        LOOKUP_URL,
        headers={"Accept": "application/json", "User-Agent": "My-T-Docs-Version-Sync/1"},
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        payload = json.load(response)
    results = payload.get("results", [])
    if payload.get("resultCount") != 1 or len(results) != 1:
        raise SystemExit("Apple lookup did not return exactly one My T record")
    app = results[0]
    if str(app.get("trackId")) != APP_ID or not str(app.get("version", "")).strip():
        raise SystemExit("Apple lookup returned an unexpected app or empty version")
    record = {
        "app_id": APP_ID,
        "track_name": app.get("trackName", "My T"),
        "version": str(app["version"]),
        # Keep the public link storefront-neutral. Apple resolves this ID-only URL
        # to the visitor's active App Store storefront.
        "track_view_url": f"https://apps.apple.com/app/id{APP_ID}",
        "source": LOOKUP_URL,
        "checked_at": dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat().replace(
            "+00:00", "Z"
        ),
    }
    if OUTPUT.exists():
        current = json.loads(OUTPUT.read_text(encoding="utf-8"))
        stable_keys = ("app_id", "track_name", "version", "track_view_url", "source")
        if all(current.get(key) == record.get(key) for key in stable_keys):
            print(f"Apple public version remains {record['version']}; no file change")
            return
    OUTPUT.write_text(json.dumps(record, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
