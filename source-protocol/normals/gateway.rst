网关
####


::

    1. 转发网关
      不改变 IP 地址的网关，我们称为转发网关
    2. NAT 网关
      改变 IP 地址的网关，我们称为 NAT 网关
      Network Address Translation，简称 NAT





conntrack


自治系统 AS（Autonomous System）分几种类型::

    1. Stub AS：
      对外只有一个连接，这类 AS 不会传输其他 AS 的包。
      例如，个人或者小公司的网络。
    2. Multihomed AS：
      可能有多个连接连到其他的 AS，但是大多拒绝帮其他的 AS 传输包。
      例如一些大公司的网络。
    3. Transit AS：
      有多个连接连到其他的 AS，并且可以帮助其他的 AS 传输包。
      例如主干网。







