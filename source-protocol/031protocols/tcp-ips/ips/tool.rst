工具
====

配置 IP 地址::

  1. 使用 net-tools:
  $ sudo ifconfig eth1 10.0.0.1/24
  $ sudo ifconfig eth1 up

  2. 使用 iproute2:
  $ sudo ip addr add 10.0.0.1/24 dev eth1
  $ sudo ip link set up eth1





