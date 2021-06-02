DHCP
####

DHCP 的工作方式::

    1. DHCP Discover 广播数据包
    2. DHCP Offer 广播数据包
    3. DHCP Request 广播数据包
    4. DHCP ACK 消息包

    收回和续租:
    在租期过去 50% 的时候
    1. 向 DHCP Server 发送 DHCP request 消息包
    2. DHCP Server 回应 DHCP ACK 消息包

DHCP Discover
=============

::

    新来的机器使用 IP 地址 0.0.0.0 发送了一个广播包，目的 IP 地址为 255.255.255.255。
    广播包封装了 UDP，UDP 封装了 BOOTP。
    其实 DHCP 是 BOOTP 的增强版，但是如果你去抓包的话，很可能看到的名称还是 BOOTP 协议。
    内容:
      a. Boot request
      b. 本机MAC 地址

.. figure:: /images/protocols/ip_dhcp1.png
   :width: 50%

   DHCP Discover请求的DHCP协议内容


DHCP Offer
==========

::

    验证请求的Mac地址是否唯一
    DHCP Server 为此客户保留为它提供的 IP 地址
    并发广播信息，其中内容有:
      a. 可用的 IP
      b. 子网掩码、网关和 IP 地址租用期

.. figure:: /images/protocols/ip_dhcp2.png
   :width: 50%

   DHCP Offer回复的DHCP协议内容

DHCP Request 广播数据包
=======================

::

    如果有多个 DHCP Server，这台新机器会收到多个 IP 地址
    并且会向网络发送一个 DHCP Request 广播数据包，包中包含:
      a. 客户端的 MAC 地址、
      b. 接受的租约中的 IP 地址、
      c. 提供此租约的 DHCP 服务器地址等，
    并告诉所有 DHCP Server 它将接受哪一台服务器提供的 IP 地址
    告诉其他 DHCP 服务器，可以撤销它们提供的 IP 地址

    注: 
      由于还没有得到 DHCP Server 的最后确认，
      客户端仍然使用 0.0.0.0 为源 IP 地址、255.255.255.255 为目标地址进行广播

.. figure:: /images/protocols/ip_dhcp3.png
   :width: 50%

   DHCP Request 广播数据包

DHCP ACK 消息包
===============

::

    DHCP Server 接收到客户机的 DHCP request 之后
    会广播返回给客户机一个 DHCP ACK 消息包，表明已经接受客户机的选择
    内容:
      IP 地址的合法租用信息
      其他的配置信息

.. figure:: /images/protocols/ip_dhcp4.png
   :width: 50%

   DHCP Request 广播数据包

扩展
====


预启动执行环境(PXE)
-------------------

.. figure:: /images/protocols/ip_dhcp5.png
   :width: 70%





