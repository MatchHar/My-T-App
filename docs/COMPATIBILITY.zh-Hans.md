# 兼容性说明

[English](COMPATIBILITY.md) · [简体中文](COMPATIBILITY.zh-Hans.md) · [繁體中文](COMPATIBILITY.zh-Hant.md)

最后验证：**2026-08-23**

| 组件 | 已验证状态 | 说明 |
| --- | --- | --- |
| My T | [App Store 当前公开版本](https://apps.apple.com/us/app/my-t/id6780299502)，iPhone、iOS 18+ | [自动生成的发布记录](app-store-release.json)会跟随 Apple 的公开信息更新。Apple 正式发布之前，开发中的功能仍属于预发布内容。iPad 不是已承诺支持的目标。 |
| TeslaMateAPI | `1.25.0` | My T 的主要 TeslaMate 数据接口 |
| TeslaMate | HostBox 已签名稳定目录中的 `4.1.1` | 车辆数据通过 TeslaMateAPI 传给 My T。上游 `4.2.0` 在完整 My T 路径完成验证前，不会进入稳定目录。 |
| My T Companion | [HostBox 签名稳定目录](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json) · [上游最新版本](https://github.com/MatchHar/My-T-Companion/releases/latest) | HostBox 只部署目录中固定的版本及安装包摘要；兼容性还会通过 `/api/v1/capabilities` 协商，而不是只看版本号。 |
| 认证 | 仅可信局域网／VPN 可使用无认证；也支持 Basic、Bearer、Cloudflare Access | 不支持无认证的公网 HTTP |
| 网络 | 局域网、Tailscale／VPN、HTTPS 反向代理、Cloudflare Tunnel | 必须提供 API 根地址 |

上方永久链接会动态显示签名部署建议和 GitHub 当前上游版本，本文不再复制容易过期的版本号。较新的上游版本不会自动成为部署建议；HostBox 会等待完整验证和目录签名。只有服务器报告所需能力后，My T 才会开启对应增强功能。

这是一份带日期的验证记录，并不承诺所有旧版或未来上游版本都兼容。TeslaMate 与 TeslaMateAPI 是独立项目，可能在 My T 未发布新版本时发生变化。

升级服务器组件前：

1. 备份 PostgreSQL 和配置。
2. 记录当前运行的镜像引用与摘要。
3. 阅读上游的重大变更说明。
4. 每次只更改一个组件。
5. 验证 TeslaMate 数据采集与 TeslaMateAPI 健康状态。
6. 在 My T 中运行“测试连接”。
7. 检查概览、一段行程、一次充电及当前车辆状态。
8. 如果已安装 Companion，请通过 My T 的正常地址验证 `/api/v1/capabilities`。

报告兼容性结果时，不要提供凭据、VIN、位置或原始生产数据。
