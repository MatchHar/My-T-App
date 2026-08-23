# 安全性政策

[English](SECURITY.md) · [简体中文](SECURITY.zh-Hans.md) · [繁體中文](SECURITY.zh-Hant.md)

## 範圍與回報方式

安全性回報可涉及 My T 已公開的伺服器連線行為、憑證處理、公開文件或選用的 My T Companion。App 原始碼為私人內容，不在本儲存庫範圍內。

請勿為疑似漏洞建立公開 Issue。請使用 GitHub 的[私人漏洞回報](https://github.com/MatchHar/My-T-App/security/advisories/new)，並提供受影響版本、iOS 與伺服器元件版本、網路／驗證類型、已遮蔽的重現步驟、影響及安全的概念驗證。

請勿提交正式環境密碼、Token、Cookie、私鑰、`.env`、VIN、車牌、GPS 座標、路線歷史、資料庫匯出或真實伺服器位址。

## 安全部署基準

- 不使用未驗證的公開網路 API。
- 不向公開網路直接開放 PostgreSQL、MQTT、Grafana、TeslaMate、TeslaMateAPI 或 Companion 容器連接埠。
- 遠端存取使用 HTTPS 或私人 VPN。
- 每項服務使用個別秘密，並儲存於 Compose 原始碼之外。
- 只有在使用者理解並明確授權時才執行命令。
- 定期測試備份與還原。
