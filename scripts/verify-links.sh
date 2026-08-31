#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

python3 - <<'PY'
from pathlib import Path
from urllib.parse import unquote
import re

errors = []
markdown_link = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
for document in sorted(Path(".").rglob("*.md")):
    text = document.read_text(encoding="utf-8")
    for raw_target in markdown_link.findall(text):
        target = raw_target.strip().split(maxsplit=1)[0].strip("<>")
        if not target or target.startswith(("#", "https://", "http://", "mailto:")):
            continue
        local = unquote(target.split("#", 1)[0].split("?", 1)[0])
        if not local:
            continue
        resolved = (document.parent / local).resolve()
        try:
            resolved.relative_to(Path.cwd().resolve())
        except ValueError:
            errors.append(f"{document}: link escapes repository: {target}")
            continue
        if not resolved.exists():
            errors.append(f"{document}: missing link target: {target}")

if errors:
    raise SystemExit("\n".join(errors))
print("Local Markdown links verified.")
PY

public_urls=(
  "https://apps.apple.com/app/id6780299502"
  "https://github.com/MatchHar/My-T-Companion/releases/latest"
  "https://my-tesla.app/"
  "https://my-tesla.app/privacy/"
  "https://my-tesla.app/support/"
)
for public_url in "${public_urls[@]}"; do
  curl --fail --location --silent --show-error \
    --retry 3 --retry-all-errors --connect-timeout 10 --max-time 30 \
    --output /dev/null "$public_url"
done
echo "Public links verified."
