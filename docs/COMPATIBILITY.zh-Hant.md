# 相容性說明

[English](COMPATIBILITY.md) · [简体中文](COMPATIBILITY.zh-Hans.md) · [繁體中文](COMPATIBILITY.zh-Hant.md)

最後驗證：**2026-08-23**

| 元件 | 已驗證狀態 | 說明 |
| --- | --- | --- |
| My T | [App Store 目前公開版本](https://apps.apple.com/us/app/my-t/id6780299502)，iPhone、iOS 18+ | [自動產生的發行記錄](app-store-release.json)會跟隨 Apple 的公開資訊更新。Apple 正式發布前，開發中的功能仍屬預先發行內容。iPad 並非已承諾支援的目標。 |
| TeslaMateAPI | `1.25.0` | My T 的主要 TeslaMate 資料介面 |
| TeslaMate | HostBox 已簽署穩定目錄中的 `4.1.1` | 車輛資料透過 TeslaMateAPI 傳給 My T。上游 `4.2.0` 在完整 My T 路徑完成驗證前，不會進入穩定目錄。 |
| My T Companion | [HostBox 簽章穩定目錄](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [上游最新版本](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox 只會部署目錄中固定的版本及安裝包摘要；相容性也會透過 `/api/v1/capabilities` 協商，而不是只看版本號。 |
| 驗證 | 僅可信任的區域網路／VPN 可使用無驗證；也支援 Basic、Bearer、Cloudflare Access | 不支援無驗證的公用網路 HTTP |
| 網路 | 區域網路、Tailscale／VPN、HTTPS 反向代理、Cloudflare Tunnel | 必須提供 API 根網址 |

上方永久連結會動態顯示簽章部署建議及 GitHub 目前的上游版本，本文不再複製容易過期的版本號。較新的上游版本不會自動成為部署建議；HostBox 會等待完整驗證及目錄簽署。只有伺服器回報所需能力後，My T 才會開啟對應的強化功能。

這是一份附日期的驗證記錄，並不保證所有舊版或未來的上游版本均相容。TeslaMate 與 TeslaMateAPI 是獨立專案，可能在 My T 未發布新版本時發生變更。

升級伺服器元件前：

1. 備份 PostgreSQL 與設定。
2. 記錄目前執行中的映像檔參照及摘要。
3. 閱讀上游重大變更說明。
4. 每次只變更一個元件。
5. 驗證 TeslaMate 資料收集與 TeslaMateAPI 健全狀態。
6. 在 My T 中執行「測試連線」。
7. 檢查概覽、一筆行程、一次充電及目前車輛狀態。
8. 若已安裝 Companion，請透過 My T 的正常網址驗證 `/api/v1/capabilities`。

回報相容性結果時，請勿提供憑證、VIN、位置或原始正式環境資料。
