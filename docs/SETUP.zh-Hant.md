# My T 部署與連線指南

[English](SETUP.md) · [简体中文](SETUP.zh-Hans.md)

本指南只說明 My T 所需的連線與安全條件。TeslaMate 及 TeslaMateAPI 自身部署
檔案應以 [TeslaMate 官方 Docker 文件](https://docs.teslamate.org/docs/installation/docker/)
及 [TeslaMateAPI 上游倉庫](https://github.com/tobiasehlert/teslamateapi)
為準，避免複製過時 Compose。

## 一、先確定存取方式

| 場景 | 建議方式 | My T 位址範例 |
| --- | --- | --- |
| 家中伺服器、同一可信 Wi-Fi | 私人區域網路 | `http://192.168.1.10:8080` |
| 離家存取家中伺服器 | Tailscale/WireGuard | `http://100.x.x.x:8080` |
| VPS | HTTPS 反向代理 + 驗證 | `https://api.example.com` |
| VPS 不開放入站連接埠 | Cloudflare Tunnel + Access | `https://api.example.com` |

HTTP 只適用於可信區域網路或私人 VPN。禁止將無驗證 HTTP API 發布至公網。

## 二、部署並驗證 TeslaMate

先依官方文件完成 TeslaMate：

- TeslaMate 健康並持續採集正確車輛。
- PostgreSQL 與 MQTT 沒有暴露至公網。
- 加密金鑰及資料庫密碼均為獨立強隨機值。
- 已建立並測試資料庫備份與還原流程。
- Tesla 帳號授權只在 TeslaMate 完成；My T 不會索取 Tesla 帳號密碼。

## 三、增加 TeslaMateAPI

依 TeslaMateAPI 上游 Docker 說明，將其連接至與 TeslaMate 相同的 PostgreSQL
及 MQTT。My T 需要注意：

- 設定至少 32 字元的隨機 `API_TOKEN`。
- 維持 `ENABLE_COMMANDS=false`；My T 查看功能不需要伺服器控制介面。
- VPS 上只綁定本機，例如 `127.0.0.1:8080:8080`，再透過安全入口存取。
- 可信區域網路可以綁定區網連接埠，但路由器不得設定公網連接埠轉送。
- 升級前記錄實際映像摘要，升級後重新測試 My T；不要無人值守地自動更新
  `latest`。

產生隨機 Token：

```sh
openssl rand -hex 32
```

真實 Token 只能儲存於伺服器 `.env` 及 My T，不能出現在 Issue、截圖、終端記錄
或公開倉庫。

### 本機驗證

部分版本對 HEAD 請求可能回傳非 200，但仍會提供 `API-Version` 回應標頭，因此
不要只依狀態碼判斷：

```sh
curl -sS -D - -o /dev/null http://127.0.0.1:8080/api/ping
curl -sS http://127.0.0.1:8080/api/healthz
```

截至 2026-07-27，My T 已驗證 TeslaMateAPI `1.25.0`。

## 四、建立安全的外部存取

依建議順序選擇：

1. **Tailscale/WireGuard**：只有自己的裝置需要存取時優先。
2. **HTTPS 反向代理**：Caddy、Nginx 或 Traefik，並啟用 TLS 與驗證。
3. **Cloudflare Tunnel + Access**：不開放 API 入站連接埠，使用 Service Token。

安全紅線：

- 不將 3000、4000、5432、1883、8080 或 8083 直接開放至公網。
- 不使用 URL 查詢參數傳 Token，避免進入記錄及瀏覽器歷史。
- 不開啟所有 TeslaMateAPI 命令群組。
- 不因某個上游範例省略驗證便關閉驗證。
- 備份檔案必須採用與線上資料庫相同等級的保護。

## 五、在 My T 中連線

開啟「設定 → 管理連線 → TeslaMate 伺服器」。

API 位址應填寫根位址：

- 正確：`https://api.example.com`
- 區域網路：`http://192.168.1.10:8080`
- 錯誤：`http://192.168.1.10:4000`（TeslaMate 網頁）
- 錯誤：`https://api.example.com/api/v1/cars`（具體介面而非根位址）

驗證方式對照：

| 伺服器保護方式 | My T 選擇 |
| --- | --- |
| 可信區域網路/VPN，API 沒有驗證 | 無需驗證 |
| 反向代理使用者名稱及密碼 | Basic Auth |
| TeslaMateAPI `API_TOKEN` | Bearer Token |
| Cloudflare Access | Cloudflare Service Token，並保留已有 API 驗證 |

執行「測試連線」。My T 會分別檢查網路、驗證、API 相容性及車輛清單；不能只
通過第一步網路檢查便認為設定完成。

## 六、TeslaMate 網頁位址為選填

My T 可能存取 TeslaMate 網頁以顯示已安裝版本。這不是一般車輛資料來源。無法
顯示 TeslaMate 版本時，只要 API 測試通過，車輛功能仍然正常。

## 七、選裝 My T 擴充服務

一般 TeslaMateAPI 連線成功後，才考慮安裝
[My T 擴充服務](https://github.com/MatchHar/My-T-Companion)。

它補充真實的長期停車狀態歷史及可靠的正在行駛軌跡，並且：

- 唯讀現有 TeslaMate PostgreSQL；
- 不複製完整車輛歷史，但預設會在 VPS 自有資料卷保留 365 天的小型停車事件記錄；
- 與一般 TeslaMateAPI 共用一個 My T 位址及驗證；
- 8083 始終只綁定本機；
- 安裝器管理的全部增強介面必須與一般 API 使用同一個統一入口。

若 My T 直接連線 `內網IP:8080` 且沒有統一反向代理，App 無法發現選裝元件；
My T 基礎功能不受影響。

## 八、常見錯誤

| 現象 | 優先檢查 |
| --- | --- |
| 逾時 | Wi-Fi/VPN、路由、防火牆、容器狀態 |
| TLS 錯誤 | 憑證有效期、網域匹配、完整憑證鏈 |
| 401 | Basic/Bearer 憑證及驗證方式 |
| 403 | Cloudflare Access Policy 及 Service Token |
| 404 | API 根位址、反向代理路徑、是否誤填 4000 |
| 沒有車輛 | TeslaMate 登入/採集、資料庫連線、API 記錄 |
| 無法顯示版本 | 選填網頁介面；一般 API 可能完全正常 |
| My T 擴充服務 不可用 | 同一位址的 `/api/v1/capabilities` 路由 |

求助時只提供已遮蔽的版本、HTTP 狀態碼、代理類型及重現步驟。不要提交憑證、
VIN、座標、`.env`、原始記錄或資料庫匯出。
