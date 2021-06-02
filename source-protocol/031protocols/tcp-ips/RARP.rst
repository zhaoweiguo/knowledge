RARP协议
########

之前有无盘工作站，即没有硬盘的机器，无法持久化 ip 地址到本地，但有网卡，所以可以用 RARP 协议来获取 IP 地址。RARP 可以用于局域网管理员想指定机器 IP（与机器绑定，不可变），又不想每台机器去设置静态 IP 的情况，可以在 RARP 服务器上配置 MAC 和 IP 对应的 ARP 表，不过获取每台机器的 MAC 地址，好像也挺麻烦的。这个协议现在应该用得不多了吧，都用 BOOTP 或者 DHCP 了。


* `ARAP 协议 <https://tools.ietf.org/html/rfc903>`_ 因为太难实现，被后来的 `BOOTP 协议 <https://tools.ietf.org/html/rfc951>`_ 和 `DHCP 协议 <https://tools.ietf.org/html/rfc2131>`_ 替代







