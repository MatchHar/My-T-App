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

expected_privacy_sections=10
for file in "${privacy_files[@]}"; do
  count="$(grep -c '^## ' "$file")"
  test "$count" -eq "$expected_privacy_sections" || {
    echo "$file has $count privacy sections; expected $expected_privacy_sections" >&2
    exit 1
  }
done

grep -Fq 'one set of notification defaults for every vehicle on the' PRIVACY.md || {
  echo "English privacy text must disclose all-vehicle notification defaults" >&2
  exit 1
}
grep -Fq '全部车辆保存一组通知默认值' PRIVACY.zh-Hans.md || {
  echo "Simplified Chinese privacy text must disclose all-vehicle notification defaults" >&2
  exit 1
}
grep -Fq '所有車輛保存一組通知預設值' PRIVACY.zh-Hant.md || {
  echo "Traditional Chinese privacy text must disclose all-vehicle notification defaults" >&2
  exit 1
}

grep -Fq 'override for an individual vehicle' PRIVACY.md || {
  echo "English privacy text must disclose individual-vehicle overrides" >&2
  exit 1
}
grep -Fq '为单独车辆建立按类别的覆盖设置' PRIVACY.zh-Hans.md || {
  echo "Simplified Chinese privacy text must disclose individual-vehicle overrides" >&2
  exit 1
}
grep -Fq '為個別車輛建立分類覆寫設定' PRIVACY.zh-Hant.md || {
  echo "Traditional Chinese privacy text must disclose individual-vehicle overrides" >&2
  exit 1
}

grep -Fq 'Optional parked low-battery notifications' PRIVACY.md || {
  echo "English privacy text omits low-battery notifications" >&2
  exit 1
}
grep -Fq '可选停车低电量通知' PRIVACY.zh-Hans.md || {
  echo "Simplified Chinese privacy text omits low-battery notifications" >&2
  exit 1
}
grep -Fq '選用停車低電量通知' PRIVACY.zh-Hant.md || {
  echo "Traditional Chinese privacy text omits low-battery notifications" >&2
  exit 1
}

if grep -nE 'selected vehicle was observed|指定车辆被观察到|指定車輛被觀察到' "${privacy_files[@]}"; then
  echo "Selected-vehicle notification wording is forbidden; subscriptions are server-wide" >&2
  exit 1
fi

for file in "${compatibility_files[@]}"; do
  grep -q '2026-08-23' "$file" || { echo "$file has a stale validation date" >&2; exit 1; }
  grep -q 'TeslaMateAPI.*1.25.0' "$file" || { echo "$file omits TeslaMateAPI 1.25.0" >&2; exit 1; }
  grep -q 'TeslaMate.*4.2.0' "$file" || { echo "$file omits the verified TeslaMate version" >&2; exit 1; }
  grep -q 'releases/latest' "$file" || { echo "$file must use the permanent Companion release URL" >&2; exit 1; }
done

if rg -n 'TeslaMateAPI.*:latest|tobiasehlert/teslamateapi:latest|My-T-Companion/releases/tag/v' \
  README*.md PRIVACY*.md docs; then
  echo "Documentation contains a mutable image or a fixed Companion release link" >&2
  exit 1
fi

echo "Documentation language and compatibility checks passed."
