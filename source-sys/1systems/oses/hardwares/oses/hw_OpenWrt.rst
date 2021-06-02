OpenWrt
#######

常用命令::

    opkg update
    opkg install tcpdump


实例
====

PC 端使用 wireshark 实时监听::

    plink.exe -batch -ssh -pw 123456 root@192.168.2.1 "tcpdump -ni br-lan -s 0 -w - not port 22" | "C:\Program Files\Wireshark\Wireshark.exe" -k -i -
    说明:
    root 表示路由用户名
    123456 表示路由登录密码
    192.168.2.1 表示路由 IP


常用地址
========

* http://downloads.openwrt.org/snapshots/trunk/
* for x86: http://downloads.openwrt.org/snapshots/trunk/x86/packages/tcpdump_4.2.1-1_x86.ipk





