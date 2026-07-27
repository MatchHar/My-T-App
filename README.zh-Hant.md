# My T

[English](README.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

<p align="center">
  <img src="docs/images/my-t-logo.png" width="112" alt="My T App 圖示">
</p>

**My T 是用於查看及理解使用者自建 TeslaMate 資料的獨立 iPhone 用戶端。**

[前往 App Store 下載 My T](https://apps.apple.com/cn/app/my-t/id6780299502) ·
[部署指南](docs/SETUP.zh-Hant.md) ·
[技術支援](SUPPORT.md) ·
[隱私說明](PRIVACY.md)

本倉庫只包含公開的產品介紹、部署文件及支援資料，**不包含 My T App
原始碼**。

## My T 可以做什麼

- 查看車輛狀態、電量、額定續航、位置及停車時長。
- 將行程整理為可搜尋歷史、統計、每日時間線及動態路線回放。
- 查看充電記錄、電量、費用、充電曲線及趨勢。
- 在伺服器儲存了真實資料時顯示車輛即時位置及正在行駛資訊。
- 支援多個自建 TeslaMate 連線及多輛車。
- 亦可將 Tessie 作為另一種獨立資料來源。
- 連線憑證儲存於 iOS Keychain。

My T 不能取代 TeslaMate。車輛資料的採集與歷史保存始終由 TeslaMate 負責。

## 資料架構

```text
車輛 → TeslaMate → PostgreSQL
                       │
                       ├─ TeslaMateAPI → My T
                       │
                       └─ My T Parking Monitor（選裝、唯讀）→ My T
```

一般車輛、行程、充電及統計資料透過
[TeslaMateAPI](https://github.com/tobiasehlert/teslamateapi) 讀取。My T
可能選擇性存取 TeslaMate 網頁介面以顯示伺服器版本；一般車輛資料不依賴網頁
介面。

[My T Parking Monitor](https://github.com/MatchHar/My-T-Parking-Monitor)
是選裝伺服器元件，用於真實的長期停車休眠/喚醒歷史、電量/續航觀測及可靠的
正在行駛軌跡。未安裝時，My T 基礎功能仍可正常使用。

## 介面預覽

<p>
  <img src="docs/images/zh-Hant/01-vehicle-at-a-glance.png" width="24%" alt="車輛概覽">
  <img src="docs/images/zh-Hant/02-live-navigation.png" width="24%" alt="即時導航">
  <img src="docs/images/zh-Hant/03-trip-insights.png" width="24%" alt="行程分析">
  <img src="docs/images/zh-Hant/04-charging-history.png" width="24%" alt="充電歷史">
</p>

截圖使用示範資料，不包含真實使用者的位置、VIN、伺服器位址或憑證。

## 使用條件

- iOS 18 或更高版本的 iPhone。
- 已正常運作的自建 TeslaMate。
- 使用 TeslaMate 資料來源時需要相容的 TeslaMateAPI。
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
6. 一般連線成功後，再按需要選裝 My T Parking Monitor。

切勿將 TeslaMate、PostgreSQL、MQTT、Grafana 或無驗證 API 直接暴露至公網。
請閱讀[完整部署指南](docs/SETUP.zh-Hant.md)。

## 獨立專案聲明

My T 是獨立第三方應用程式，與 Tesla, Inc.、TeslaMate 專案及 TeslaMateAPI
專案不存在隸屬、認可或官方支援關係。相關名稱及商標歸各自權利人所有。

## 公開倉庫安全規則

- App 原始碼、簽署材料、內部建置檔案及私人基礎設施不會公開。
- 請勿在 Issue 中提交 API Token、密碼、Cloudflare Secret、VIN、座標、
  `.env`、原始日誌或資料庫匯出。
- 安全問題請依照 [SECURITY.md](SECURITY.md) 私下回報。

Copyright © 2026 My T。文件與產品素材使用條款見 [LICENSE.md](LICENSE.md)。
