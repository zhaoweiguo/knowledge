.. _ip:

ip命令使用
---------------

子命令::

       link 网卡配置
       address 配置地址。相当于 ifconfig
       route 配置路由。相当于 route

参数::

       show 显示 (默认)
       set 设置
       add 添加
       del 删除

示例::

     ip link show              显示网卡配置
     ip link set eth0 name xxx 重命名网络接口


