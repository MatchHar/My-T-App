#!/bin/sh
set -eu

forbidden_pattern='(^|/)(MyCarMate|AppStore|ci_scripts|DerivedData)(/|$)|\.(swift|pbxproj|ipa|mobileprovision|p12|cer|key)$|\.xcodeproj/|\.xcworkspace/|(^|/)\.env(\.|$)|(^|/)GoogleService-Info\.plist$|(^|/)ExportOptions[^/]*\.plist$'

blocked=$(
  git ls-files |
    grep -E "$forbidden_pattern" || true
)

if [ -n "$blocked" ]; then
  echo "Public repository boundary violation:"
  echo "$blocked"
  exit 1
fi

if git grep -nE 'apps\.apple\.com/cn/app/my-t|My-T-Parking-Monitor|Parking Monitor' -- \
  '*.md' ':!CHANGELOG.md'; then
  echo "Outdated public product link or service name detected."
  exit 1
fi

echo "Public repository boundary verified."
