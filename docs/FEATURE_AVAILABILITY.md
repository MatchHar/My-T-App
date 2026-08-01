# Feature availability / 功能可用性

Last verified: 2026-08-01

## English

| Channel | My T version | My T Companion |
| --- | --- | --- |
| **App Store** | **3.32 submitted; waiting for review** | Apple has received 3.32 with Companion integration. Until approval, the downloadable App Store binary may remain older and may not contain Companion screens. |
| **TestFlight / pre-release** | **3.32** | Companion **1.10.2** is supported: long-term parking sleep/wake timeline, observed plug/security/opening/climate events, verified drive trajectories, and optional Live Activities / software push after secure pairing. |

Standard TeslaMate and TeslaMateAPI connections, trips, charging, statistics,
and other core features remain independent of My T Companion.

**Recommended Companion version:** public release **1.10.2**. It adds long-term bounded parking-event retention, explicit temporary-state cleanup, localized release notes, and supported backup/restore tooling.

Optional vehicle software notifications, charging Live Activities, and navigation Live Activities require:

1. A compatible My T 3.32 build.
2. My T Companion **1.10.2** (or newer with the same capabilities).
3. Secure App ↔ relay pairing completed on the phone.

Without pairing, parking history and trajectories still work when Companion is reachable; push and Live Activity delivery stay inactive.

The server companion remains optional. Compatible My T builds detect it through the existing TeslaMateAPI base URL via `/api/v1/capabilities` and enable enhanced views only when present.

## 简体中文

| 渠道 | My T 版本 | My T Companion |
| --- | --- | --- |
| **App Store** | **3.32 已提交，等待审核** | Apple 已收到包含 Companion 接入的 3.32。审核通过前，App Store 当前可下载包仍可能是旧版，并且可能没有 Companion 页面。 |
| **TestFlight / 预发布** | **3.32** | 支持 Companion **1.10.2**：长期停车休眠/唤醒流水、插枪/安防/开闭/空调等真实观测事件、可验证行驶轨迹，以及完成安全配对后的可选实时活动与软件推送。 |

TeslaMate、TeslaMateAPI 连接、行程、充电、统计等基础功能不依赖 My T Companion。

**推荐 Companion 版本：** 公开版 **1.10.2**。该版本加入长期且有容量保护的停车事件、临时状态清理、三语更新说明及正式备份/恢复工具。

可选的车辆软件通知、充电实时活动、导航实时活动需要：

1. 兼容的 My T 3.32。
2. My T Companion **1.10.2**（或具备相同能力的更新版）。
3. 在手机上完成 App 与中继的安全配对。

未配对时，只要能访问 Companion，停车历史与轨迹仍可工作；推送与实时活动投递保持关闭。

服务器组件始终为选装。兼容 My T 通过现有 TeslaMateAPI 根地址检测 `/api/v1/capabilities`，仅在检测到组件后启用增强视图。

## 繁體中文

| 渠道 | My T 版本 | My T Companion |
| --- | --- | --- |
| **App Store** | **3.32 已提交，等待審查** | Apple 已收到包含 Companion 整合的 3.32。審查通過前，App Store 目前可下載套件仍可能是舊版，並且可能沒有 Companion 畫面。 |
| **TestFlight / 預發布** | **3.32** | 支援 Companion **1.10.2**：長期停車休眠／喚醒流水、插槍／保全／開關／空調等真實觀測事件、可驗證行駛軌跡，以及完成安全配對後的選用即時動態與軟體推播。 |

TeslaMate、TeslaMateAPI 連線、行程、充電、統計等基本功能不依賴 My T Companion。

**建議 Companion 版本：** 公開版 **1.10.2**。此版本加入長期且有容量保護的停車事件、暫時狀態清理、三語更新說明及正式備份／還原工具。

可選的車輛軟體通知、充電即時動態、導航即時動態需要：

1. 相容的 My T 3.32。
2. My T Companion **1.10.2**（或具備相同能力的更新版）。
3. 在手機上完成 App 與中繼的安全配對。

未配對時，只要能存取 Companion，停車歷史與軌跡仍可運作；推播與即時動態投遞保持關閉。

伺服器元件始終為選裝。相容 My T 經現有 TeslaMateAPI 根位址偵測 `/api/v1/capabilities`，僅在偵測到元件後啟用增強檢視。
