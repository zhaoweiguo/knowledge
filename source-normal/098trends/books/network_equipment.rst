图解网络硬件
##############

::

    节点: node
    链路: link
    主机: host
    客户端: client


    LAN: Local Area Network, 局域网
    WAN: Wide Area Network, 广域网
    MAN: Metropolitan Area Network, 城域网

    ISP: 互联网服务供应商（如: 歌华宽带、长城宽带）
      相关: 电信运营商(三大运营商即是 ISP也是运营商)

    OSI: Open System Interconnection(开放系统互联)


    NIC，网卡 (Network interface controller

公司::

    施乐(Xerox):
      LAN 标准——DIX 标准

    DEC:
      LAN 标准——DIX 标准

    Intel:
      LAN 标准——DIX 标准

    3COM:
      罗伯特-梅特卡夫博士
      LAN 标准——DIX 标准

LAN 标准::

    DIX 标准:
      DEC、Intel、施乐(Xerox)三个公司首字母
      COM公司(罗伯特-梅特卡夫博士)

    IEEE802.3:
      1980年2月
      IEEE 的802委员会

    以太网标准:
      狭义定义: 
          DIX, IEEE802.3标准
          10Mbit/s 以太网标准
          使用 CSMA/CD
      广义定义:
          IEEE802.3u, IEEE802.3z, IEEE802.3ae, IEEE802.3ba
          100Mbit/s 以上
          不使用 CSMA/CD

      标准的命名规则:

          速度    调制方式    传输媒介    编码体系     lane
          1000    BASE        S         X
          40G     BASE        L         R           4
          例:
            1000 BASE-S X
            40G BASE-L R 4
          速度说明:
            1000即1000M, 1G
          调制方式说明:
            BASE: Baseband(基带信号), 1根线缆只传输1个信号
            BROAD: Broadband(宽频信号), 1根线缆传送多个信号
          传输媒介说明:
            S: Short Reach(100m), 2芯多模光缆
            L: Long Reach(10km), 2芯单模或多模光缆
            ...
          编码体系说明:
            X: 
              1. 在快速以太网时使用4B/5B 作为分组码
              2. 在千兆以太网时使用8B/10B 作为分组码
            R: 使用64B/66B 作为分组码
          lane 说明:
            在40G/100G 以太网传输媒介中使用的并行传输通道

1. 物理层::
   
    Physical Layer
    数据形式: 比特流(0与1)
    主要网络协议:
      IEEE 802.3

2. 数据链路层::
   
    Data-link Layer
    数据形式: 帧
    主要网络协议:
      IEEE 802.2
      PPP
    对应的网络硬件:
      L2交换机
      无线 LAN 接入点

3. 网络层::
   
    Network Layer
    数据形式: 分组、数据报
    主要网络协议:
      IP
      IPX
      X.25
    对应的网络硬件:
       L3交换机
       路由器

4. 传输层::

    Transport Layer
    数据形式: 段、消息
    主要网络协议:
      TCP
      UDP
    对应的网络硬件:
      L4交换机
      防火墙

5. 会话层::

    Session Layer
    数据形式: 应用数据
    主要网络协议:
      SSL

6. 表示层::

    Presentation Layer
    数据形式: 应用数据
    主要网络协议:
      ASCII编码
      EBCDIC编码

7. 应用层::

    Application Layer
    数据形式: 应用数据
    主要网络协议:
      HTTP
      FTP
      SMTP
      SNMP
    对应的网络硬件:
      L7交换机
      防火墙
      代理

    




