# 隐私说明

[English](PRIVACY.md) · [简体中文](PRIVACY.zh-Hans.md) · [繁體中文](PRIVACY.zh-Hant.md)

最后更新：2026-08-22

公开隐私政策见 <https://my-tesla.app/privacy/>。本文说明自建数据路径的实际处理方式。

## 车辆数据与凭据

使用 TeslaMate 时，车辆历史仍保存在用户自己的 PostgreSQL 数据库；My T 直接读取用户设置的服务器，不把完整车辆历史转存到开发者运营的数据库。使用 Tessie 时，数据访问同时受用户 Tessie 账号及其服务条款约束。

服务器地址和认证资料使用 iOS 安全设施保存，秘密保存在 Keychain。My T 不要求 Tesla 账号密码。只有用户主动开启 iCloud 配置同步时，连接设置与凭据副本才可能通过用户自己的私有 iCloud 同步；行程、充电、GPS 历史和 TeslaMate 数据库不会进入该备份。

`.mytconnection` 文件和 HostBox 连接包只在用户主动分享或粘贴时传输。深层链接不携带密码、Bearer Token 或 Cloudflare Secret。连接文件可能包含用户选择分享的凭据，应像密码一样保管；My T 会先测试连接，再把凭据保存到 Keychain。

## 可选 Companion 与推送

Companion 运行在用户自己的 TeslaMate 主机，以只读方式查询数据库，并在自有数据卷中保存有上限的真实停车事件。它不会复制完整 TeslaMate 历史，也不会连接 Tesla 或唤醒车辆。

用户主动开启软件更新、充电／导航实时活动或“锁车且车内无人”通知后，投递中继会保存 APNs 设备令牌、不透明安装 ID、所需的实时活动令牌、语言和时间戳。事件只包含完成通知所需的最少字段；不发送 VIN、GPS 坐标、完整路线、TeslaMate 凭据、数据库密码或完整车辆历史。

锁车通知会显示标题与消息。通知声音由每台 iPhone 独立选择；内置声音标识、导入音频、文件名和静音选择都不会离开手机。导入文件会转换后保存在 App 的私有通知声音目录，用户可以删除。

中继按默认策略删除 365 天未活动的安装；只含不透明安装 ID、事件类型、投递结果和时间戳的审计记录最多保留 90 天。事件内容只用于即时 APNs 投递，不持久保存。若注销时暂时无法连接中继，App 只保留本机重试标记，稍后继续注销，不会保存车辆事件或重新开启通知。

## 安全支持

切勿在公开 Issue 提交密码、Token、Cloudflare Secret、VIN、GPS 坐标、家庭／公司地址、`.env`、数据库导出或未脱敏生产日志。请使用[官方支持页](https://my-tesla.app/support/)；安全问题按[安全政策](SECURITY.zh-Hans.md)私下报告。
