#!/usr/bin/env python3
"""Synchronize Apple's public My T version without predicting App Review."""

from __future__ import annotations

import datetime as dt
import json
import re
import urllib.request
from pathlib import Path

APP_ID = "6780299502"
LOOKUP_URL = f"https://itunes.apple.com/lookup?id={APP_ID}&country=us"
OUTPUT = Path(__file__).resolve().parents[1] / "docs" / "app-store-release.json"
STABLE_KEYS = ("app_id", "track_name", "version", "track_view_url", "source")


def version_parts(value: object) -> tuple[int, ...]:
    if not isinstance(value, str) or not re.fullmatch(r"[0-9]+(?:\.[0-9]+){0,2}", value):
        raise ValueError("Apple lookup returned an invalid version")
    parts = tuple(int(part) for part in value.split("."))
    return parts + (0,) * (3 - len(parts))


def release_record(payload: dict, current: dict | None = None) -> dict | None:
    """Reject wrong-app/empty/downgrade data; unchanged listings create no commit."""
    results = payload.get("results", [])
    if payload.get("resultCount") != 1 or len(results) != 1:
        raise ValueError("Apple lookup did not return exactly one My T record")
    app = results[0]
    if str(app.get("trackId")) != APP_ID:
        raise ValueError("Apple lookup returned an unexpected app")
    version = app.get("version")
    candidate_parts = version_parts(version)
    if current and candidate_parts < version_parts(current.get("version")):
        raise ValueError("Apple lookup would move the public version backwards")
    record = {
        "app_id": APP_ID,
        "track_name": app.get("trackName", "My T"),
        "version": version,
        "track_view_url": f"https://apps.apple.com/app/id{APP_ID}",
        "source": LOOKUP_URL,
        "checked_at": dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat().replace(
            "+00:00", "Z"
        ),
    }
    if current and all(current.get(key) == record.get(key) for key in STABLE_KEYS):
        return None
    return record


def main() -> None:
    request = urllib.request.Request(
        LOOKUP_URL,
        headers={"Accept": "application/json", "User-Agent": "My-T-Docs-Version-Sync/1"},
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        payload = json.load(response)
    current = json.loads(OUTPUT.read_text(encoding="utf-8")) if OUTPUT.exists() else None
    record = release_record(payload, current)
    if record is None:
        print(f"Apple public version remains {current['version']}; no file change")
        return
    OUTPUT.write_text(json.dumps(record, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
