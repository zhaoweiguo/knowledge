route命令
==============
::

   简单的的操作如下，
   查看路由状态：route print
   只查看ipv4（ipv6）路由状态：route print -4(-6)
   添加路由：route add 目的网络 mask 子网掩码 网关 ——重启机器或网卡失效
   route add 192.168.20.0 mask 255.255.255.0 192.168.10.1
   添加永久：route -p add 目的网络 mask 子网掩码网关
   route -p add 192.168.20.0 mask 255.255.255.0 192.168.10.1
   删除路由：route delete 目的网络 mask 子网掩码
   route delete 192.168.20.0 mask 255.255.255.0

