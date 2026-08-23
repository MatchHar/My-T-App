# 技術支援

[English](SUPPORT.md) · [简体中文](SUPPORT.zh-Hans.md) · [繁體中文](SUPPORT.zh-Hant.md)

## 回報問題前

1. 確認 TeslaMate 正在收集目標車輛資料。
2. 確認 TeslaMateAPI 可從伺服器本機正常存取。
3. 確認 iPhone 具有區域網路、VPN/Tailscale 或 HTTPS 存取路徑。
4. 在 My T 執行「測試連線」，記下失敗步驟。
5. 閱讀[部署指南](docs/SETUP.zh-Hant.md)及[相容性說明](docs/COMPATIBILITY.md)。

## 可以安全提供的資料

- My T 版本與 Build、iOS 版本及 iPhone 型號。
- TeslaMate、TeslaMateAPI 與 Companion 版本。
- 網路類型及驗證類型，但不要提供憑證。
- 401、403、404、逾時等狀態碼及已遮蔽的重現步驟。

請勿提供密碼、API Token、Cloudflare Client Secret、Cookie、QR Code、Tesla 帳號資料、VIN、車牌、精確位置、住家／工作地址、路線歷史、正式環境伺服器位址、`.env`、Docker Secret、資料庫匯出或原始記錄。

產品及部署問題可透過儲存庫 Issue 範本回報；疑似安全漏洞請依[安全性政策](SECURITY.zh-Hant.md)私下回報。App Store、隱私權或一般支援請使用[My T 官方支援頁](https://my-tesla.app/support/zh-hant/)。

本獨立專案無法代表 Tesla、TeslaMate、TeslaMateAPI、Cloudflare、Tailscale 或其他第三方提供官方支援。
