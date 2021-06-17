MQTT V3.1.1协议报文
======================

报文结构::

  固定报头(Fixed header)
  可变报头(Variable header)
  报文有效载荷(Payload)

固定报头::

  Bit       7 6 5 4             3 2 1 0
  byte1     MQTT Packet type    Flags
  byte2…           Remaining Length

报文类型(MQTT Packet type)::

  类型名称      类型值      报文说明
  CONNECT       1         发起连接
  CONNACK       2         连接回执
  PUBLISH       3         发布消息
  PUBACK        4         发布回执
  PUBREC        5         QoS2消息回执
  PUBREL        6         QoS2消息释放
  PUBCOMP       7         QoS2消息完成
  SUBSCRIBE     8         订阅主题
  SUBACK        9         订阅回执
  UNSUBSCRIBE   10        取消订阅
  UNSUBACK      11        取消订阅回执
  PINGREQ       12        PING请求
  PINGRESP      13        PING响应
  DISCONNECT    14        断开连接

QOS::

  MQTT发布消息QoS保证不是端到端的,是客户端与服务器之间的
  订阅者收到MQTT消息的QoS级别,最终取决于发布消息的QoS和主题订阅的QoS




其他::

  1.MQTT V3.1.1 Protocol Specification: http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html


