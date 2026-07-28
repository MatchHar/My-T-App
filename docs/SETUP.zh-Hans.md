# My T 部署与连接指南

[English](SETUP.md) · [繁體中文](SETUP.zh-Hant.md)

本指南只说明 My T 需要的连接与安全条件。TeslaMate 和 TeslaMateAPI 自身部署
文件应以 [TeslaMate 官方 Docker 文档](https://docs.teslamate.org/docs/installation/docker/)
及 [TeslaMateAPI 上游仓库](https://github.com/tobiasehlert/teslamateapi)
为准，避免复制过期 Compose。

## 一、先确定访问方式

| 场景 | 推荐方式 | My T 地址示例 |
| --- | --- | --- |
| 家中服务器、同一可信 Wi-Fi | 私人局域网 | `http://192.168.1.10:8080` |
| 离家访问家中服务器 | Tailscale/WireGuard | `http://100.x.x.x:8080` |
| VPS | HTTPS 反向代理 + 认证 | `https://api.example.com` |
| VPS 不开放入站端口 | Cloudflare Tunnel + Access | `https://api.example.com` |

HTTP 只适用于可信局域网或私人 VPN。禁止把无认证 HTTP API 发布到公网。

## 二、部署并验证 TeslaMate

先按官方文档完成 TeslaMate：

- TeslaMate 健康并持续采集正确车辆。
- PostgreSQL 与 MQTT 没有暴露到公网。
- 加密密钥和数据库密码均为独立强随机值。
- 已经建立并测试数据库备份和恢复流程。
- Tesla 账号授权只在 TeslaMate 中完成；My T 不会索取 Tesla 账号密码。

## 三、增加 TeslaMateAPI

按照 TeslaMateAPI 上游 Docker 说明，将其接入与 TeslaMate 相同的 PostgreSQL
及 MQTT。My T 需要注意：

- 设置至少 32 字符的随机 `API_TOKEN`。
- 保持 `ENABLE_COMMANDS=false`；My T 查看功能不需要服务器控制接口。
- VPS 上只绑定本机，例如 `127.0.0.1:8080:8080`，再通过安全入口访问。
- 可信局域网可以绑定局域网端口，但路由器不得设置公网端口转发。
- 升级前记录实际镜像摘要，升级后重新测试 My T；不要无人值守地自动更新
  `latest`。

生成随机 Token：

```sh
openssl rand -hex 32
```

真实 Token 只能保存于服务器 `.env` 和 My T，不能出现在 Issue、截图、终端记录
或公开仓库。

### 本机验证

部分版本对 HEAD 请求可能返回非 200，但仍会提供 `API-Version` 响应头，因此
不要只按状态码判断：

```sh
curl -sS -D - -o /dev/null http://127.0.0.1:8080/api/ping
curl -sS http://127.0.0.1:8080/api/healthz
```

截至 2026-07-27，My T 已验证 TeslaMateAPI `1.25.0`。

## 四、建立安全的外部访问

按推荐顺序选择：

1. **Tailscale/WireGuard**：只有自己的设备需要访问时优先。
2. **HTTPS 反向代理**：Caddy、Nginx 或 Traefik，并启用 TLS 与认证。
3. **Cloudflare Tunnel + Access**：不开放 API 入站端口，使用 Service Token。

安全红线：

- 不把 3000、4000、5432、1883、8080 或 8083 直接开放到公网。
- 不使用 URL 查询参数传 Token，避免进入日志和浏览器历史。
- 不开启所有 TeslaMateAPI 命令组。
- 不因为某个上游示例省略认证就关闭认证。
- 备份文件必须采用与在线数据库相同等级的保护。

## 五、在 My T 中连接

打开“设置 → 管理连接 → TeslaMate 服务器”。

API 地址应填写根地址：

- 正确：`https://api.example.com`
- 局域网：`http://192.168.1.10:8080`
- 错误：`http://192.168.1.10:4000`（TeslaMate 网页）
- 错误：`https://api.example.com/api/v1/cars`（具体接口而非根地址）

认证方式对照：

| 服务器保护方式 | My T 选择 |
| --- | --- |
| 可信局域网/VPN，API 没有认证 | 无需认证 |
| 反向代理用户名与密码 | Basic Auth |
| TeslaMateAPI `API_TOKEN` | Bearer Token |
| Cloudflare Access | Cloudflare Service Token，并保留已有 API 认证 |

执行“测试连接”。My T 会分别检查网络、认证、API 兼容性和车辆列表；不能只通过
第一步网络检查就认为配置完成。

## 六、TeslaMate 网页地址是选填

My T 可能访问 TeslaMate 网页以显示已安装版本。这不是普通车辆数据来源。无法
显示 TeslaMate 版本时，只要 API 测试通过，车辆功能仍然正常。

## 七、选装 My T 增强服务

普通 TeslaMateAPI 连接成功后，才考虑安装
[My T 增强服务](https://github.com/MatchHar/My-T-Companion)。

它补充真实的长期停车状态历史和可靠的正在行驶轨迹，并且：

- 只读现有 TeslaMate PostgreSQL；
- 不建立第二套车辆历史数据库；
- 与普通 TeslaMateAPI 共用一个 My T 地址和认证；
- 8083 始终只绑定本机；
- 三个增强接口必须与普通 API 使用同一个统一入口。

如果 My T 直接连接 `内网IP:8080` 且没有统一反向代理，App 无法发现选装组件；
My T 基础功能不受影响。

## 八、常见错误

| 现象 | 优先检查 |
| --- | --- |
| 超时 | Wi-Fi/VPN、路由、防火墙、容器状态 |
| TLS 错误 | 证书有效期、域名匹配、完整证书链 |
| 401 | Basic/Bearer 凭证及认证方式 |
| 403 | Cloudflare Access Policy 与 Service Token |
| 404 | API 根地址、反向代理路径、是否误填 4000 |
| 没有车辆 | TeslaMate 登录/采集、数据库连接、API 日志 |
| 无法显示版本 | 选填网页接口；普通 API 可能完全正常 |
| My T 增强服务 不可用 | 同一地址的 `/api/v1/capabilities` 路由 |

求助时只提供脱敏后的版本、HTTP 状态码、代理类型和复现步骤。不要提交凭证、
VIN、坐标、`.env`、原始日志或数据库导出。
