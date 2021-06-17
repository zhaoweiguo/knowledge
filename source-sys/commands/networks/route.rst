.. _route:

route命令使用
------------------

配置路由及网关::

  //查看路由状态
  route [-nee]
  route
  route -n
  route -nee
     -n  ：不要使用通讯协定或主机名称，直接使用 IP 或 port number；
     -ee ：使用更详细的资讯来显示   
  //指定路由及网关
  route add -net <路由地址> gw <网关地址> [ netmask <子网掩码> ] dev <网卡>
  route add -net 192.168.20.0 netmask 255.255.255.0 gw 192.168.10.1
  //删除路由及网关
  route del -net <路由地址> gw <网关地址> [ netmask <子网掩码> ]
  route del -net 192.168.20.0 netmask 255.255.255.0
  //设置默认网关
  route add default gw 192.168.10.1
     -net    ：表示后面接的路由为一个网域；
     -host   ：表示后面接的为连接到单部主机的路由；
     netmask ：与网域有关，可以设定 netmask 决定网域的大小；
     gw      ：gateway 的简写，后续接的是 IP 的数值喔，与 dev 不同；
     dev     ：如果只是要指定由那一块网路卡连线出去，则使用这个设定，后面接 eth0 等

内容代表的意义::

  //Gateway:该网域是通过那个 gateway 连接出去的
  1.如果显示 0.0.0.0 表示该路由是直接由本机传送,亦即可以透过区域网路的 MAC 直接传讯
  2.如果有显示IP的话,表示该路由需要经过路由器(通讯闸)的帮忙才能够传送出去
  // Flags：总共有多个旗标，代表的意义如下：
  o U (route is up)：该路由是启动的
  o H (target is a host)：目标是一部主机 (IP) 而非网域
  o G (use gateway)：需要透过外部的主机 (gateway) 来转递封包
  o R (reinstate route for dynamic routing)：使用动态路由时，恢复路由资讯的旗标
  o D (dynamically installed by daemon or redirect)：已经由服务或转 port 功能设定为动态路由
  o M (modified from routing daemon or redirect)：路由已经被修改了
  o !  (reject route)：这个路由将不会被接受(用来抵挡不安全的网域)
  

实例::

  root@zgapi2:/mnt/nginx# route -nee
  Kernel IP routing table
  Destination     Gateway         Genmask         Flags Metric Ref    Use Iface    MSS   Window irtt
  0.0.0.0         114.55.75.247   0.0.0.0         UG    0      0        0 eth1     0     0      0
  10.0.0.0        10.24.155.247   255.0.0.0       UG    0      0        0 eth0     0     0      0
  10.24.152.0     0.0.0.0         255.255.252.0   U     0      0        0 eth0     0     0      0
  100.64.0.0      10.24.155.247   255.192.0.0     UG    0      0        0 eth0     0     0      0
  114.55.72.0     0.0.0.0         255.255.252.0   U     0      0        0 eth1     0     0      0
  172.16.0.0      10.24.155.247   255.240.0.0     UG    0      0        0 eth0     0     0      0


