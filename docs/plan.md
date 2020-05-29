# 多功能PI盒规划

本文讨论的硬件设备为树莓派4，带有一个以太网口和一个WIFI网口。

## 有线网卡IP

`eth0`配置两个IP地址，主地址使用DHCP，`eth0:1`配置一个B类地址`169.254.x.y`，其中
`x.y`为随机生成。准备一张标签，记录设备的169.254地址以及网卡MAC地址并粘贴到外壳上。

这个步骤的目的是为了在特殊情况下可以通过第二IP连接盒子，或者通过MAC地址在DHCP服务器上找到IP分配记录。

## WIFI热点

利用内置WIFI网卡，创建一个热点，该热点的SSID公开，其格式为`<前缀>+<以太网口IP>`，例如
`PI192.168.1.100`。这样，无需连接该热点，只要扫描一下就知道盒子的有线网口IP。当然，
该热点还可以提供在没有有线网络的情况下接入本盒子。

> 根据WIFI标准，SSID是一个0～32字节的标识，允许任何字符。

## DHCP/DNS服务

使用**dnsmasq**提供DHCP和DNS转发服务。有以下目的：

- 内置WIFI热点需要给连上来的客户端分配IP地址
- 使用内置DHCP可以收集网内主机MAC/IP，便于远程接入时访问需要管理的主机
- 内置DNS转发器可以提供特殊的域名解析，比如在内网某个固定域名直接解析到盒子的IP

## DDNS

利用DNSPod或花生壳等，将盒子的外网IP与动态域名绑定，方便在外网使用域名访问盒子。

## 内网穿透

利用FRP等工具，可以设定一个公网VPS为盒子提供SSH接入。该接入手段可能非常重要，
因为不是每一个内网环境都开放VPN端口。

## 管理界面

用Go语言编写一个WEB管理界面，可以配置网络参数或开关各种服务。

## 内建防火墙

使用**iptables**提供必要的安全防护，比如管理服务只可以通过WIFI热点接入访问。
也可以为外网接入的连接做端口转发到内网某个主机。

## 文件服务器

使用Samba提供Windows文件共享服务器。对于USB接入的移动存储设备可以自动提供远程访问。

## L2TP服务

提供跨平台的VPN接入服务。

## SOCKS服务

提供基于SOCKS4/5的科学上网服务（需要公网VPS支持）。

## DLNA服务

将本地视频通过DLNA协议分享给电视机，另外，考虑使用 **youtube-dl**
点播视频推送到本地RTMP服务器（NginX）提供电视机访问。