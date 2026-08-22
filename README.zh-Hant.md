# My T

[English](README.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

<p align="center">
  <img src="docs/images/my-t-logo.png" width="112" alt="My T App 圖示">
</p>

**My T 是用於查看及理解使用者自建 TeslaMate 資料的獨立 iPhone 用戶端。**

[前往 App Store 下載 My T](https://apps.apple.com/us/app/my-t/id6780299502) ·
[部署指南](docs/SETUP.zh-Hant.md) ·
[技術支援](SUPPORT.md) ·
[隱私說明](PRIVACY.md)

> **公開版本：** 已於 2026 年 8 月 22 日核對 Apple 公開頁面，目前 App Store
> 可下載版本為 **My T 3.10**。本文件不預測審查狀態；實際可下載版本以 App Store
> 頁面為準。Companion 按能力協商相容，請使用
> [My T Companion 最新穩定版](https://github.com/MatchHar/My-T-Companion/releases/latest)，
> 用於增強停車歷史、真實軌跡，以及安全配對後的選用即時動態與軟體推播。詳情請參閱
> [功能可用性說明](docs/FEATURE_AVAILABILITY.md)。

[![Companion 最新版本](https://img.shields.io/github/v/release/MatchHar/My-T-Companion?display_name=tag&sort=semver)](https://github.com/MatchHar/My-T-Companion/releases/latest)

本倉庫只包含公開的產品介紹、部署文件及支援資料，**不包含 My T App
原始碼**。

## My T 以 TeslaMate 為核心

[TeslaMate](https://github.com/teslamate-org/teslamate) 是 My T 自建服務
體驗的基礎。它運作於使用者自己的伺服器，負責連線車輛、記錄車輛狀態、行程、
充電、位置及能耗資料，並將歷史儲存於使用者自己的 PostgreSQL 資料庫。

My T 將 TeslaMate 儲存的資料整理成適合 iPhone 使用的概覽、可搜尋行程、
充電分析、每日時間線、地圖及路線回放。My T 不會取代 TeslaMate，不會另外連線
使用者的 Tesla 帳號，也不會將 TeslaMate 車輛歷史轉移至 My T 營運的雲端。

三個專案分工不同：

| 元件 | 作用 |
| --- | --- |
| [TeslaMate](https://github.com/teslamate-org/teslamate) | 使用自建連線時的主要資料採集器及資料依據 |
| [TeslaMateAPI](https://github.com/tobiasehlert/teslamateapi) | 將一般 TeslaMate 資料以 JSON 提供給 My T 的連線層 |
| [My T 擴充服務](https://github.com/MatchHar/My-T-Companion) | 選裝的唯讀擴充：長期停車、真實行駛軌跡、充電／導航即時動態及車輛軟體通知 |

新使用者應先依照 [TeslaMate 官方文件](https://docs.teslamate.org/) 部署並驗證
TeslaMate，再安裝 TeslaMateAPI、連線 My T，最後按需要選裝 My T 擴充服務。

## My T 可以做什麼

- 檢視電量、續航、總里程、上鎖狀態、胎壓、位置、軟體更新，以及資料來源提供的車門與四扇車窗狀態。
- 將行程與停車整理為依日期分組的紀錄與綜合時間軸，並顯示單次行程效率與更多遙測資料。
- 駕駛統計提供里程趨勢、溫度、常用目的地與平日／週末比較，並可沿道路動態重播行程。
- 檢視充電電量、費用、即時充電遙測、續航增加速度，以及只依符合條件資料計算的電池健康趨勢。
- 資料服務支援時，提供尋車地圖、真實行駛資料、目的地進度、預計抵達時間與抵達資訊。
- 支援多個自建 TeslaMate 連線及多輛車。
- 亦可將 Tessie 作為另一種獨立資料來源。
- 連線憑證儲存於 iOS Keychain。

### 長期停車：逐個動作查看

安裝選用的 My T 擴充服務後，停車監控可以持續保存 iPhone 暫停期間無法連續
採集的真實觀測：

- 按時間順序顯示上線、離線、休眠、喚醒及充電狀態；
- 在 TeslaMate 確實回報時，顯示每個邊界的電量百分比及額定續航；
- 插槍、拔槍、開始充電及停止充電；
- 上鎖、解鎖、車門、車窗、前後行李廂及充電口變化；
- 哨兵、空調、預熱及電池加熱變化。

安裝或重新啟動後的第一個 MQTT 保留值只建立基線，不會產生假事件。缺少電量、
續航或動作資料時維持缺失，不作估算。停車事件預設長期保存，並設有容量上限
避免無限增長。未安裝擴充服務時，一般停車、行程及充電歷史仍可正常使用。

## My T 如何配合 TeslaMate

```text
車輛 → TeslaMate → PostgreSQL
                       │
                       ├─ TeslaMateAPI → My T
                       │
                       └─ My T 擴充服務（選裝、唯讀）→ My T
```

一般車輛、行程、充電及統計資料透過
[TeslaMateAPI](https://github.com/tobiasehlert/teslamateapi) 讀取。My T
可能選擇性存取 TeslaMate 網頁介面以顯示伺服器版本；一般車輛資料不依賴網頁
介面。

[My T Companion 最新穩定版](https://github.com/MatchHar/My-T-Companion/releases/latest)
是建議的伺服器版本；此永久連結及上方徽章會自動指向 GitHub 目前正式版。它是選裝伺服器元件，用於真實的長期停車休眠／喚醒歷史、狀態邊界的電量與額定
續航觀測、已保留的插槍／充電／保全／開關／空調等 MQTT 事件、可靠的目前行駛
軌跡、帶真實起點／目的地變更／行程時間的導航工作階段歷史，以及在完成安全
配對後、App 未開啟時的選用充電／導航鎖定畫面即時動態與軟體通知。未安裝時，
My T 基本功能仍可正常使用。Companion 亦會連結回本倉庫的 App 可用性與部署
說明，兩個公開倉庫共同說明同一條相容使用路徑。

## 介面預覽

<p>
  <img src="docs/images/zh-Hant/01-overview-san-francisco.png" width="9%" alt="含示範位置的車輛概覽">
  <img src="docs/images/zh-Hant/02-drives.png" width="9%" alt="依日期分組的行駛紀錄">
  <img src="docs/images/zh-Hant/03-charge-detail.png" width="9%" alt="充電詳細資料與遙測">
  <img src="docs/images/zh-Hant/04-vehicle-safety.png" width="9%" alt="車門、車窗與車輛安全狀態">
  <img src="docs/images/zh-Hant/05-drive-stats.png" width="9%" alt="駕駛統計儀表板">
  <img src="docs/images/zh-Hant/06-drive-replay.png" width="9%" alt="沿道路的行程重播">
  <img src="docs/images/zh-Hant/07-battery-health.png" width="9%" alt="電池健康趨勢">
  <img src="docs/images/zh-Hant/08-parking-detail.png" width="9%" alt="停車活動詳細資料">
  <img src="docs/images/zh-Hant/09-navigation-map.png" width="9%" alt="目的地導航地圖">
  <img src="docs/images/zh-Hant/10-connections.png" width="9%" alt="私人連線管理">
</p>

截圖使用示範資料，不包含真實使用者的位置、VIN、伺服器位址或憑證。

公開版與預發佈功能邊界請看[功能可用性說明](docs/FEATURE_AVAILABILITY.md)；3.32 文案僅作為歷史版本記錄保留。

## 使用條件

- iOS 18 或更高版本的 iPhone。
- 已正常運作的自建 TeslaMate 與相容的 TeslaMateAPI，或受支援的 Tessie 連線。
- iPhone 能透過可信區域網路、VPN/Tailscale，或帶驗證的 HTTPS 安全存取 API。

My T 目前已驗證 TeslaMateAPI `1.25.0`。上游專案升級後相容性可能改變，修改
伺服器版本前請查看附日期的[相容性說明](docs/COMPATIBILITY.md)。

## 開始使用

1. 按照 [TeslaMate 官方文件](https://docs.teslamate.org/docs/installation/docker/)
   部署並確認 TeslaMate 正常採集資料。
2. 安裝並保護
   [TeslaMateAPI](https://github.com/tobiasehlert/teslamateapi)。
3. 在 My T 開啟「設定 → 管理連線 → TeslaMate 伺服器」。
4. 填寫 API 根位址及相應驗證方式。
5. 執行「測試連線」並選擇車輛。
6. 一般連線成功後，再按需要選裝 My T 擴充服務。

切勿將 TeslaMate、PostgreSQL、MQTT、Grafana 或無驗證 API 直接暴露至公網。
請閱讀[完整部署指南](docs/SETUP.zh-Hant.md)。

## 隱私

My T 不營運車輛歷史資料庫。車輛資料仍儲存於使用者選擇的自建伺服器或服務商，
App 直接從已設定的資料來源讀取。只有使用者主動啟用的軟體通知或即時動態會
使用推播中繼，並且只傳送完成通知投遞所需的最少資料；詳見
[PRIVACY.md](PRIVACY.md)。

## 獨立專案聲明

My T 是獨立第三方應用程式，與 Tesla, Inc.、TeslaMate 專案及 TeslaMateAPI
專案不存在隸屬、認可或官方支援關係。相關名稱及商標歸各自權利人所有。

## 公開倉庫安全規則

- App 原始碼、簽署材料、內部建置檔案及私人基礎設施不會公開。
- 請勿在 Issue 中提交 API Token、密碼、Cloudflare Secret、VIN、座標、
  `.env`、原始日誌或資料庫匯出。
- 安全問題請依照 [SECURITY.md](SECURITY.md) 私下回報。
- 文件貢獻請遵循 [CONTRIBUTING.md](CONTRIBUTING.md)。

Copyright © 2026 My T。文件與產品素材使用條款見 [LICENSE.md](LICENSE.md)。
