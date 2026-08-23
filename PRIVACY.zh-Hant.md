# 隱私權說明

[English](PRIVACY.md) · [简体中文](PRIVACY.zh-Hans.md) · [繁體中文](PRIVACY.zh-Hant.md)

最後更新：2026-08-22

公開隱私權政策請見 <https://my-tesla.app/privacy/zh-hant/>。本文說明自行託管資料路徑的實際處理方式。

## 車輛資料與憑證

使用 TeslaMate 時，車輛歷史仍儲存在使用者自己的 PostgreSQL 資料庫；My T 直接讀取使用者設定的伺服器，不會把完整車輛歷史轉存至開發者營運的資料庫。使用 Tessie 時，資料存取同時受使用者 Tessie 帳號及其服務條款約束。

伺服器位址及驗證資料使用 iOS 安全設施保存，秘密儲存於 Keychain。My T 不會要求 Tesla 帳號密碼。只有使用者主動開啟 iCloud 設定同步時，連線設定及憑證副本才可能透過使用者自己的私人 iCloud 同步；行程、充電、GPS 歷史及 TeslaMate 資料庫不會進入該備份。

`.mytconnection` 檔案及 HostBox 連線套件只在使用者主動分享或貼上時傳輸。深層連結不攜帶密碼、Bearer Token 或 Cloudflare Secret。連線檔案可能包含使用者選擇分享的憑證，應比照密碼妥善保管；My T 會先測試連線，再將憑證存入 Keychain。

## 選用 Companion 與推播

Companion 執行於使用者自己的 TeslaMate 主機，以唯讀方式查詢資料庫，並在自己的資料卷中保存有容量上限的真實停車事件。它不會複製完整 TeslaMate 歷史，也不會連線 Tesla 或喚醒車輛。

使用者主動開啟軟體更新、充電／導航即時動態或「上鎖且車內無人」通知後，投遞中繼會保存 APNs 裝置權杖、不透明安裝 ID、所需的即時動態權杖、語言及時間戳記。事件只包含完成通知所需的最少欄位；不會傳送 VIN、GPS 座標、完整路線、TeslaMate 憑證、資料庫密碼或完整車輛歷史。

上鎖通知會顯示標題及訊息。通知聲音由每支 iPhone 個別選擇；內建聲音識別碼、匯入音訊、檔名及靜音選擇均不會離開手機。匯入檔案會轉換後儲存於 App 的私人通知聲音目錄，使用者可以刪除。

中繼依預設政策刪除 365 天未活動的安裝；只含不透明安裝 ID、事件類型、投遞結果及時間戳記的稽核記錄最多保留 90 天。事件內容只用於即時 APNs 投遞，不會持久保存。若取消註冊時暫時無法連線中繼，App 只保留本機重試標記，稍後繼續取消，不會保存車輛事件或重新開啟通知。

## 安全支援

請勿在公開 Issue 提交密碼、Token、Cloudflare Secret、VIN、GPS 座標、住家／工作地址、`.env`、資料庫匯出或未遮蔽的正式環境記錄。請使用[官方支援頁](https://my-tesla.app/support/zh-hant/)；安全性問題請依[安全性政策](SECURITY.zh-Hant.md)私下回報。
