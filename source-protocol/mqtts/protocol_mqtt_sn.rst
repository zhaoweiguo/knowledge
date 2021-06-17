MQTT-SN协议
######################

::

  MQTT-SN 协议是 MQTT 的直系亲属，它使用 UDP 进行通信，标准的端口是1884
  MQTT-SN 的主要目的是为了适应受限的设备和网络,比如一些传感器,只有很小的内存和CPU,TCP 对于这些设备来说非常奢侈
  还有一些网络,比如 ZIGBEE，报文的长度在300字节以下，无法承载太大的数据包
  所以 MQTT-SN 的数据包更小巧

MQTT-SN 的官方标准下载地址: http://mqtt.org/new/wp-content/uploads/2009/06/MQTT-SN_spec_v1.2.pdf

MQTT-SN 最大的不同是::

  Topic 使用 TopicId 来代替，而 TopicId 是一个16比特的数字
  每一个数字对应一个 Topic, 
  设备和云端需要使用 REGISTER 命令映射 TopicId 和 Topic 的对应关系。

尽管MQTT-SN被设计成尽可能接近于MQTT，但那些低功耗、电池驱动、资源受限的设备所在网络场景为低速带宽、高连接失败、物理层数据包上线为128字节。文档提出了以下不同点::

  CONNECT消息被拆分成三个消息（CONNECT，WILLTIPIC，WILLMSG），后两者用于客户端传递遗嘱主题和遗嘱消息等
  在PUBLISH消息中主题（topic name）被替换成两个字节长度自然数（topic id），这个需要客户端通过注册流程进行获取对应的topic id
  预定义（提前定义）topic id和topic name，省去中间注册流程，客户端和网关要求提前在其固件中指定
  协议引入的自动发现机制可帮助客户端发现潜在的网关。若存在多个网关，彼此可协调是为主从互备或者负载均衡
  “clean session”即可作用于订阅持久化，也被扩展作用于遗嘱特性（遗嘱主题和遗嘱消息）
  针对休眠设备增加离线保活机制支持，当有消息时代理需要缓存，客户端被唤醒时再发送

.. figure:: /images/protocols/protocol_mqtt-sn_architecture1.jpg
   :width: 80%

在MQTT-SN架构图中，存在三种组件::

  MQTT-SN 客户端
  MQTT-SN 网关，可单独存在，也可以被集成到MQTT服务器中。需要承担MQTT-SN和MQTT协议之间的转换工作
  MQTT-SN 转发器，负责转发当前客户端数据到不可直接访问的网关上去，针对客户端而言网关不可直接访问时，转发器作用就凸显。转发器封装MQTT-SN消息转发给网关，解封来自网关的消息发送给客户端。网关不能够篡改原始数据

目标::

  MQTT for Sensor Networks is aimed at embedded devices on non-TCP/IP networks, such as Zigbee. MQTT-SN is a publish/subscribe messaging protocol for wireless sensor networks (WSN), with the aim of extending the MQTT protocol beyond the reach of TCP/IP infrastructure for Sensor and Actuator solutions.

MQTT-SN传输网关::

  透明网关，会为每一个客户端都建立一个TCP连接到MQTT服务器的通道，这样会较为耗费网关网络资源，但模型简单
  聚合网关，只建立一条TCP连接通道到MQTT服务器上，所有的客户端共享一个通道，很经济的说。


.. figure:: /images/protocols/protocol_mqtt-sn_architecture2.jpg
   :width: 80%

MQTT-SN常用流程进行的流程简单梳理 [1]_::

                Client              Gateway            Server/Broker
                  |                   |                    |
  Generic Process | --- SERCHGW ----> |                    |
                  | <-- GWINFO  ----- |                    |
                  | --- CONNECT ----> |                    |
                  | <--WILLTOPICREQ-- |                    |
                  | --- WILLTOPIC --> |                    |
                  | <-- WILLMSGREQ -- |                    |
                  | --- WILLMSG ----> | ---- CONNECT ----> |(accepted)
                  | <-- CONNACK ----- | <--- CONNACK ----- |
                  | --- PUBLISH ----> |                    |
                  | <-- PUBACK  ----- | (invalid TopicId)  |
                  | --- REGISTER ---> |                    |
                  | <-- REGACK  ----- |                    |
                  | --- PUBLISH ----> | ---- PUBLISH ----> |(accepted)
                  | <-- PUBACK  ----- | <---- PUBACK ----- |
                  |                   |                    |
                  //                  //                   //
                  |                   |                    |
   SUBSCRIBE   -->| --- SUBSCRIBE --> | ---- SUBSCRIBE --> |
   [var Callback] | <-- SUBACK ------ | <--- SUBACK ------ |
                  |                   |                    |
                  //                  //                   //
                  |                   |                    |
                  | <-- REGISTER ---- | <--- PUBLISH ----- |<-- PUBLISH
                  | --- REGACK  ----> |                    |
  [exec Callback] | <-- PUBLISH  ---- |                    |
                  | --- PUBACK   ---> | ---- PUBACK  ----> |--> PUBACK
                  |                   |                    |
                  //                  //                   //
                  |                   |                    |
  active -> asleep| --- DISCONNECT -> | (with duration)    |
                  | <-- DISCONNECT -- | (without duration) |
                  |                   |                    |
                  //                  //                   //
                  |                   |                    |
                  |                   | <--- PUBLISH ----- |<-- PUBLISH
                  |                   | ----- PUBACK ----> |
                  |                   | <--- PUBLISH ----- |<-- PUBLISH
                  |                   | ----- PUBACK ----> |
                  |                   | (buffered messages)|
  asleep -> awake |                   |                    |
                  | --- PINGREQ ----> |                    |
  awake state     | <-- PUBLISH  ---- |                    |
                  | <-- PUBLISH  ---- |                    |
                  | <-- PINGRESP ---- |                    |
  asleep <-awake  |                   |                    |

MQTT-SN运行的协议栈:

.. figure:: /images/protocols/protocol_mqtt-sn_architecture3.png
   :width: 80%

基于MQTT-SN运行的架构图:

.. figure:: /images/protocols/protocol_mqtt-sn_architecture4.png
   :width: 80%

但实际上的其网络拓扑可能更为复杂，比如两个不同的传感器网络:


.. figure:: /images/protocols/protocol_mqtt-sn_architecture5.jpeg
   :width: 80%


.. [1] `MQTT-SN协议乱翻之小结篇 <http://www.blogjava.net/yongboy/archive/2015/01/13/422207.html>`_









