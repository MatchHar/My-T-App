# Together / 同行

Verified September 10, 2026: these features belong to **6.01 (620), Waiting for
Review**. Public App Store **5.32** remains a separate release. Check
[availability](FEATURE_AVAILABILITY.md) and [Apple](https://apps.apple.com/app/id6780299502).

## English

**Two cars on your server.** Choose the car you are in as the reference. The
map can show both cars, your car or the other car, with north-up or a vehicle's
heading. Road distance is directional: the route from A to B may differ from
B to A. The destination is the other car's last usable observed position, so
the estimate is not a promise to catch a moving car. Navigation and ETA appear
only when the source provides usable data. Stale or missing values stay labelled.

**Friends on different servers.** Both people need a compatible My T App and
their own reachable, enabled Companion. Each owner chooses a vehicle and
sharing duration, sends an invitation, and confirms the intended recipient.
The two directions are approved independently; accepting one invitation does
not give access to the other owner's server or all their cars. These temporary
peers do not become normal saved connections.

Server operators must install the [signed recommended Companion](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json)
and follow its [Friend Together deployment guide](https://github.com/MatchHar/My-T-Companion/blob/main/docs/friend-together.md).
The owner API keeps owner authentication. The separate guest HTTPS hostname
exposes only the limited sharing routes, with device-bound authorization.
Never open Companion's raw port, the database, MQTT or general owner API to
friends. A release upgrade remains off by default until this setup is complete;
notification pairing is unrelated. The feature must report enabled and ready
before invitations can be created.

Precise location is required and may expose sensitive places. Navigation,
battery and permitted trip trace are optional, initially off. Read the
[privacy details](../PRIVACY.md#optional-friend-together-sharing-in-601).
Sharing expires or can be stopped; restarting Companion ends an active v1
share. A new invitation is then required. Friend Together does not add
background friend-tracking Lock Screen cards. Use a passenger for interaction
while driving; keep attention on the road.

## 简体中文

**自己服务器上的两车。** 选择“我在哪辆车上”作为起点。地图可显示两车全览、
以我为主或查看对方，支持正北向上及车辆行驶方向。道路距离有方向性，从 A 到 B
可能与 B 到 A 不同。目标是另一辆车最近可用的观测位置，因此不能承诺追上移动
车辆的时间。只有来源提供可用导航数据时才显示预计到达信息；过期或缺失的数据
会明确标识。

**不同服务器上的朋友。** 双方都需要兼容的 My T，以及自己可访问、已启用的
Companion。每位车主选择车辆和共享时长，发送邀请并确认指定接收者。两个方向
分别授权；接受一份邀请不代表获得另一方服务器或全部车辆的访问权。临时同行
伙伴不会变为普通保存的服务器连接。

服务器管理员须安装[签名目录建议的 Companion](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json)，
并依照其[朋友同行部署说明](https://github.com/MatchHar/My-T-Companion/blob/main/docs/friend-together.md)设置。
车主接口继续保留车主认证；独立访客 HTTPS 域名只开放受设备授权保护的有限共享
路径。不要向朋友直接开放 Companion 端口、数据库、MQTT 或普通车主接口。
升级后仍默认关闭，完成以上配置才会启用；通知配对与此无关。创建邀请前，服务
必须报告已启用且就绪。

精确位置是必需权限，可能暴露敏感地点；导航、电池和允许范围内的本次轨迹为
默认关闭的可选权限。详见[隐私说明](../PRIVACY.zh-Hans.md)。共享会到期，也可
停止；Companion 重启会结束进行中的 v1 共享，之后需要新邀请。朋友同行不包含
后台追踪朋友的锁屏卡片。驾驶时应由乘客操作，注意道路安全。

## 繁體中文

**自己伺服器上的兩車。** 選擇「我在哪輛車上」作為起點。地圖可顯示兩車全覽、
以我為主或查看對方，支援正北向上及車輛行駛方向。道路距離有方向性，從 A 到 B
可能與 B 到 A 不同。目標是另一輛車最近可用的觀測位置，因此不能承諾追上移動
車輛的時間。只有來源提供可用導航資料時才顯示預計抵達資訊；過期或缺失的資料
會明確標示。

**不同伺服器上的朋友。** 雙方都需要相容的 My T，以及自己可存取、已啟用的
Companion。每位車主選擇車輛和共享時長，傳送邀請並確認指定接收者。兩個方向
分別授權；接受一份邀請不代表取得另一方伺服器或全部車輛的存取權。臨時同行
夥伴不會變成一般保存的伺服器連線。

伺服器管理員須安裝[簽章目錄建議的 Companion](https://raw.githubusercontent.com/MatchHar/My-T-Companion/main/hostbox/myt-stack.json)，
並依照其[朋友同行部署說明](https://github.com/MatchHar/My-T-Companion/blob/main/docs/friend-together.md)設定。
車主介面繼續保留車主驗證；獨立訪客 HTTPS 網域只開放受裝置授權保護的有限共享
路徑。不要向朋友直接開放 Companion 連接埠、資料庫、MQTT 或一般車主介面。
升級後仍預設關閉，完成以上設定才會啟用；通知配對與此無關。建立邀請前，服務
必須回報已啟用且就緒。

精確位置是必要權限，可能暴露敏感地點；導航、電池和允許範圍內的本次軌跡為
預設關閉的選用權限。詳見[隱私說明](../PRIVACY.zh-Hant.md)。共享會到期，也可
停止；Companion 重新啟動會結束進行中的 v1 共享，之後需要新邀請。朋友同行不含
背景追蹤朋友的鎖定畫面卡片。駕駛時應由乘客操作，注意道路安全。
