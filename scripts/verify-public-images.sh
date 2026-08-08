#!/bin/sh
set -eu

if git ls-files 'docs/images/en/*.png' 'docs/images/zh-Hans/*.png' \
  'docs/images/zh-Hant/*.png' | grep -q .; then
  echo "Localized telemetry screenshots are not allowed in the public repository."
  exit 1
fi

test -f docs/images/privacy-safe-product-illustration.png || {
  echo "Missing privacy-safe product illustration."
  exit 1
}

blocked_pattern='GPSLatitude|GPSLongitude|/Users/|BEGIN [A-Z ]*PRIVATE KEY|104\.129\.180\.49|uat-hua\.com|Lily'
for image in $(git ls-files 'docs/images/*.png'); do
  if strings "$image" | grep -Ei "$blocked_pattern" >/dev/null; then
    echo "Potential private metadata or production identifier in $image"
    exit 1
  fi
done

echo "Public image privacy boundary verified."
