.. _ifconfig:

ifconfig命令使用
--------------------


ifconfig  配置网络接口::

    -a 显示所有网络接口

ifconfig <网卡> up|down  激 活|禁用网卡

示例::

  ifconfig eth0 down    // 关闭网卡
  ifconfig eth0 up      // 激活网卡

给网卡指定 IP 地址或子网掩码::

    ifconfig <网卡> add <IP 地址> [ netmask <子网掩码> ]

例::
  
    sudo ifconfig eth0 192.168.10.123 netmask 255.255.255.0




