# Feature availability / 功能可用性

Last verified: 2026-08-23

## English

| Channel | Verified version | Availability |
| --- | --- | --- |
| **Public App Store** | [Current Apple listing](https://apps.apple.com/us/app/my-t/id6780299502) | Downloadable availability comes from Apple. The [generated public record](app-store-release.json), not an internal review note, supplies the current version. |
| **Pre-release development** | Newer builds | Screenshots and documentation may describe capabilities still being validated for a later App Store release. They are not represented as publicly downloadable until Apple’s listing changes. |
| **My T Companion** | [signed deployment recommendation](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [upstream latest](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox deploys the signed recommendation; My T also discovers capabilities at `/api/v1/capabilities`. A newer upstream tag is informational until validated. |

Newer My T builds include long-term parking and vehicle-activity monitoring,
observed lock/opening/security/climate/charging changes, verified trajectories,
destination-trip history, optional Live Activities and device-local alert sounds.
Treat these as pre-release until the public App Store listing includes them.

Standard TeslaMate/TeslaMateAPI trips, charging and statistics do not require
Companion. Push and Live Activity delivery remain inactive until secure pairing
is completed.

## 简体中文

| 渠道 | 已核对版本 | 可用状态 |
| --- | --- | --- |
| **App Store 公开版** | [Apple 当前产品页](https://apps.apple.com/us/app/my-t/id6780299502) | 可下载状态以 Apple 为准；当前版本由[自动生成的公开记录](app-store-release.json)提供，不使用内部审核记录。 |
| **预发布开发版** | 更新版本 | 截图和文档可能介绍仍在为后续 App Store 版本验证的能力；Apple 页面更新前，不会把这些能力描述成已公开下载。 |
| **My T Companion** | [签名部署建议](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [上游最新版本](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox 部署签名建议版本；My T 还会通过 `/api/v1/capabilities` 发现能力。较新的上游标签在验证前只作提示。 |

较新的 My T 版本包括长期停车与车辆活动监控、真实观测的锁车／开闭／安防／空调／
充电变化、可验证轨迹、目的地行程历史，以及可选实时活动和本机提示音。在 App Store
公开页面包含这些能力前，应将其视为预发布功能。

普通 TeslaMate／TeslaMateAPI 行程、充电和统计不依赖 Companion。未完成安全
配对时，推送和实时活动保持关闭。

## 繁體中文

| 渠道 | 已核對版本 | 可用狀態 |
| --- | --- | --- |
| **App Store 公開版** | [Apple 目前產品頁](https://apps.apple.com/us/app/my-t/id6780299502) | 可下載狀態以 Apple 為準；目前版本由[自動產生的公開記錄](app-store-release.json)提供，不使用內部審查記錄。 |
| **預發佈開發版** | 更新版本 | 截圖及文件可能介紹仍在為後續 App Store 版本驗證的能力；Apple 頁面更新前，不會將這些能力描述為已公開下載。 |
| **My T Companion** | [簽章部署建議](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [上游最新版本](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox 會部署簽章建議版本；My T 也會透過 `/api/v1/capabilities` 探測能力。較新的上游標籤在驗證前只作提示。 |

較新的 My T 版本包括長期停車與車輛活動監控、真實觀測的上鎖／開關／保全／空調／
充電變化、可驗證軌跡、目的地行程歷史，以及選用即時動態和本機提示音。在 App Store
公開頁面包含這些能力前，應將其視為預發佈功能。

一般 TeslaMate／TeslaMateAPI 行程、充電及統計不依賴 Companion。未完成安全
配對時，推播及即時動態維持關閉。
