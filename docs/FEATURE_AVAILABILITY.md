# Feature availability / 功能可用性

Last verified: 2026-09-11. This is a dated release snapshot; Apple's listing
and the generated public record identify subsequent public releases.

## English

| Channel | Verified version | Availability |
| --- | --- | --- |
| **Public App Store** | **6.01** | Released. [Apple's public lookup](https://itunes.apple.com/lookup?id=6780299502&country=us) reports `2026-09-11T16:28:14Z`. The [Apple listing](https://apps.apple.com/app/id6780299502) and [generated public record](app-store-release.json) identify later public updates. |
| **My T Companion** | [signed deployment recommendation](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [upstream latest](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox deploys the signed recommendation; My T also discovers capabilities at `/api/v1/capabilities`. A newer upstream tag is informational until validated. |

Public My T 6.01 includes long-term parking and vehicle-activity monitoring,
observed lock/opening/security/climate/charging changes, verified trajectories,
destination-trip history, optional Live Activities and device-local alert sounds.
Missing upstream door/window
observations cannot be reconstructed. Push is not guaranteed instantaneous.

[Together and Friend Together](TOGETHER.md) in 6.01 distinguish two cars on one
authorized server from temporary cross-server access approved by both owners.
Each friend server requires enabled Companion and a secured guest HTTPS origin;
installing a new App or pairing notifications alone does not enable sharing.

Standard TeslaMate/TeslaMateAPI trips, charging and statistics do not require
Companion. Push and Live Activity delivery remain inactive until secure pairing
is completed.

## 简体中文

| 渠道 | 已核对版本 | 可用状态 |
| --- | --- | --- |
| **App Store 公开版** | **6.01** | 已上架。[Apple 公开查询](https://itunes.apple.com/lookup?id=6780299502&country=us)报告发布时间为 `2026-09-11T16:28:14Z`。之后的公开更新以 [Apple 产品页](https://apps.apple.com/app/id6780299502)及[自动生成的公开记录](app-store-release.json)为准。 |
| **My T Companion** | [签名部署建议](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [上游最新版本](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox 部署签名建议版本；My T 还会通过 `/api/v1/capabilities` 发现能力。较新的上游标签在验证前只作提示。 |

公开版 My T 6.01 包括长期停车与车辆活动监控、真实观测的锁车／开闭／安防／空调／
充电变化、可验证轨迹、目的地行程历史，以及可选实时活动和本机提示音。
来源未报告的快速开关门窗动作不能补造；推送不保证瞬时更新。

6.01 的[同行与朋友同行](TOGETHER.md)区分同一授权服务器的两车，以及双方车主批准的
临时跨服务器共享。每台朋友服务器都需要启用 Companion 和安全的访客 HTTPS 入口；
安装新版 App 或通知配对本身不会启用共享。

普通 TeslaMate／TeslaMateAPI 行程、充电和统计不依赖 Companion。未完成安全
配对时，推送和实时活动保持关闭。

## 繁體中文

| 渠道 | 已核對版本 | 可用狀態 |
| --- | --- | --- |
| **App Store 公開版** | **6.01** | 已上架。[Apple 公開查詢](https://itunes.apple.com/lookup?id=6780299502&country=us)回報發布時間為 `2026-09-11T16:28:14Z`。之後的公開更新以 [Apple 產品頁](https://apps.apple.com/app/id6780299502)及[自動產生的公開記錄](app-store-release.json)為準。 |
| **My T Companion** | [簽章部署建議](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [上游最新版本](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox 會部署簽章建議版本；My T 也會透過 `/api/v1/capabilities` 探測能力。較新的上游標籤在驗證前只作提示。 |

公開版 My T 6.01 包括長期停車與車輛活動監控、真實觀測的上鎖／開關／保全／空調／
充電變化、可驗證軌跡、目的地行程歷史，以及選用即時動態和本機提示音。
來源未回報的快速開關門窗動作不能補造；推播不保證瞬時更新。

6.01 的[同行與朋友同行](TOGETHER.md)區分同一授權伺服器的兩車，以及雙方車主核准的
臨時跨伺服器共享。每台朋友伺服器都需要啟用 Companion 和安全的訪客 HTTPS 入口；
安裝新版 App 或通知配對本身不會啟用共享。

一般 TeslaMate／TeslaMateAPI 行程、充電及統計不依賴 Companion。未完成安全
配對時，推播及即時動態維持關閉。
