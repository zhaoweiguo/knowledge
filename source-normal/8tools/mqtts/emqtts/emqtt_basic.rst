Emqtt基本
=================


文档地址::

  http://docs.emqtt.com/en/latest/getstarted.html
  中文版:
  http://emqtt.com/docs/v2/index.html


端口列表::

  // etc/emqttd.config
  1883  MQTT Port
  8883  MQTT/SSL Port
  8083  MQTT/WebSocket Port
  8084  MQTT/WebSocket/SSL Port
  8080  HTTP Management API Port
  18083 Web Dashboard Port   默认用户: admin，密码：public

  //EMQ 节点集群使用的 TCP 端口:
  4369  集群节点发现端口
  6369  集群节点控制通道
  集群节点间如有防护墙，需开启上述 TCP 端口互访权限。



设计目标::

  1.稳定承载大规模的 MQTT 客户端连接，单服务器节点支持50万到100万连接。
  2.分布式节点集群，快速低延时的消息路由，单集群支持1000万规模的路由。 // @todo 什么是单集群
  3.消息服务器内扩展，支持定制多种认证方式、高效存储消息到后端数据库。
  4.完整物联网协议支持，MQTT、MQTT-SN、CoAP、WebSocket 或私有协议支持。

MQTT协议::

  MQTT is a light-weight publish/subscribe messaging protocol, 
  originally created by IBM and Arcom (later to become part of Eurotech) around 1998. 
  The MQTT 3.1.1 specification has now been standardised by the OASIS consortium.
  The standard is available in a variety of formats.

说明::

  MQTT 是发布订阅(Publish/Subscribe) 模式的消息协议
  MQTT 主题(Topic) 支持’+’, ‘#’的通配符，’+’通配一个层级，’#’通配多个层级(必须在末尾)
  MQTT 消息发布者(Publisher) 只能向特定’名称主题’(不支持通配符)发布消息，订阅者(Subscriber)通过订阅’过滤主题’(支持通配符)来匹配消息。
  The 1.0 release of the EMQ broker has scaled to 1.3 million concurrent MQTT connections on a 12 Core, 32G CentOS server.
  The emqttd broker only allows 512 concurrent connections by default, for ‘ulimit -n’ limit is 1024 on most platform.
  We need tune the OS Kernel, TCP Stack, Erlang VM and emqttd broker for one million connections benchmark.
  The EMQ broker 1.0 is more like a network Switch or Router, not a traditional enterprise message queue. 
  The EMQ 2.0 seperated the Message Flow Plane and Monitor/Control Plane


功能列表::

  完整的 MQTT V3.1/V3.1.1 协议规范支持
  QoS0, QoS1, QoS2 消息支持
  持久会话与离线消息支持
  Retained 消息支持
  Last Will 消息支持
  TCP/SSL 连接支持
  MQTT/WebSocket/SSL 支持
  HTTP消息发布接口支持
  $SYS/# 系统主题支持
  客户端在线状态查询与订阅支持
  客户端 ID 或 IP 地址认证支持
  用户名密码认证支持
  LDAP 认证
  Redis、MySQL、PostgreSQL、MongoDB、HTTP 认证集成
  浏览器 Cookie 认证
  基于客户端 ID、IP 地址、用户名的访问控制(ACL)
  多服务器节点集群(Cluster)
  多服务器节点桥接(Bridge)
  mosquitto 桥接支持
  Stomp 协议支持
  MQTT-SN 协议支持
  CoAP 协议支持
  Stomp/SockJS 支持
  通过 Paho 兼容性测试
  2.0新功能: 本地订阅($local/topic)
  2.0新功能: 共享订阅($share/<group>/topic)
  2.0新功能: sysctl 类似 k = v 格式配置文件


高级特性 (Advanced Features)::

  本地订阅 (Local Subscription)
  共享订阅 (Shared Subscription)




开源 MQTT 客户端项目::

  GitHub: https://github.com/emqtt

  emqttc:  Erlang MQTT客户端库
  emqtt_benchmark: MQTT连接测试工具
  CocoaMQTT: Swift语言MQTT客户端库
  QMQTT: QT框架MQTT客户端库

Eclipse Paho: https://www.eclipse.org/paho/

MQTT.org: https://github.com/mqtt/mqtt.github.io/wiki/libraries















