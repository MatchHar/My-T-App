# 安全政策

[English](SECURITY.md) · [简体中文](SECURITY.zh-Hans.md) · [繁體中文](SECURITY.zh-Hant.md)

## 范围与报告方式

安全报告可涉及 My T 已公开的服务器连接行为、凭据处理、公开文档或可选的 My T Companion。App 源代码为私有内容，不在本仓库范围内。

请勿为疑似漏洞创建公开 Issue。请使用 GitHub 的[私密漏洞报告](https://github.com/MatchHar/My-T-App/security/advisories/new)，并提供受影响版本、iOS 与服务器组件版本、网络／认证类型、已脱敏复现步骤、影响及安全的概念验证。

切勿提交生产密码、Token、Cookie、私钥、`.env`、VIN、车牌、GPS 坐标、路线历史、数据库导出或真实服务器地址。

## 安全部署基线

- 不使用无认证公网 API。
- 不向公网直接开放 PostgreSQL、MQTT、Grafana、TeslaMate、TeslaMateAPI 或 Companion 容器端口。
- 远程访问使用 HTTPS 或私有 VPN。
- 每项服务使用独立秘密，并保存在 Compose 源码之外。
- 只有用户理解并明确授权时才执行命令。
- 定期测试备份与恢复。
