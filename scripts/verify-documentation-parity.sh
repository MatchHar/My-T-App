#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

privacy_files=(PRIVACY.md PRIVACY.zh-Hans.md PRIVACY.zh-Hant.md)
compatibility_files=(docs/COMPATIBILITY.md docs/COMPATIBILITY.zh-Hans.md docs/COMPATIBILITY.zh-Hant.md)
changelog_files=(CHANGELOG.md CHANGELOG.zh-Hans.md CHANGELOG.zh-Hant.md)

for file in "${privacy_files[@]}" "${compatibility_files[@]}" "${changelog_files[@]}"; do
  test -s "$file" || { echo "Missing documentation: $file" >&2; exit 1; }
done

for file in "${changelog_files[@]}"; do
  test "$(grep -c '^## ' "$file")" -eq 2 || {
    echo "$file does not match the two-section changelog structure" >&2
    exit 1
  }
done

expected_privacy_sections=9
for file in "${privacy_files[@]}"; do
  count="$(grep -c '^## ' "$file")"
  test "$count" -eq "$expected_privacy_sections" || {
    echo "$file has $count privacy sections; expected $expected_privacy_sections" >&2
    exit 1
  }
done

for file in "${compatibility_files[@]}"; do
  grep -q '2026-08-23' "$file" || { echo "$file has a stale validation date" >&2; exit 1; }
  grep -q 'TeslaMateAPI.*1.25.0' "$file" || { echo "$file omits TeslaMateAPI 1.25.0" >&2; exit 1; }
  grep -q 'TeslaMate.*4.1.1' "$file" || { echo "$file omits the verified TeslaMate version" >&2; exit 1; }
  grep -q 'releases/latest' "$file" || { echo "$file must use the permanent Companion release URL" >&2; exit 1; }
done

if rg -n 'TeslaMateAPI.*:latest|tobiasehlert/teslamateapi:latest|My-T-Companion/releases/tag/v' \
  README*.md PRIVACY*.md docs; then
  echo "Documentation contains a mutable image or a fixed Companion release link" >&2
  exit 1
fi

echo "Documentation language and compatibility checks passed."
