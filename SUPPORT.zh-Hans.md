# 技术支持

[English](SUPPORT.md) · [简体中文](SUPPORT.zh-Hans.md) · [繁體中文](SUPPORT.zh-Hant.md)

## 提交问题前

1. 确认 TeslaMate 正在采集目标车辆。
2. 确认 TeslaMateAPI 可在服务器本机正常访问。
3. 确认 iPhone 具有局域网、VPN/Tailscale 或 HTTPS 访问路径。
4. 在 My T 执行“测试连接”，记录失败步骤。
5. 阅读[部署指南](docs/SETUP.zh-Hans.md)和[兼容性说明](docs/COMPATIBILITY.md)。

## 可以安全提供的资料

- My T 版本与 Build、iOS 版本和 iPhone 型号。
- TeslaMate、TeslaMateAPI 与 Companion 版本。
- 网络类型及认证类型，但不要提供凭据。
- 401、403、404、超时等状态码和已脱敏复现步骤。

请勿提供密码、API Token、Cloudflare Client Secret、Cookie、二维码、Tesla 账号资料、VIN、车牌、精确位置、家庭／公司地址、路线历史、生产服务器地址、`.env`、Docker Secret、数据库导出或原始日志。

产品与部署问题可通过仓库 Issue 模板提交；疑似安全漏洞请按照[安全政策](SECURITY.zh-Hans.md)私下报告。App Store、隐私或一般支持请使用[My T 官方支持页](https://my-tesla.app/support/)。

本独立项目无法代表 Tesla、TeslaMate、TeslaMateAPI、Cloudflare、Tailscale 或其他第三方提供官方支持。
