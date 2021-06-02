Connection连接层
====================

1.built on the eSockd library::

  //eSockd:a general Non-blocking TCP/SSL Socket Server
  https://github.com/emqtt/esockd


负责 TCP、WebSocket 连接处理::

  1.Acceptor Pool and Asynchronous TCP Accept
  2.Parameterized Connection Module
  3.Max connections management
  4.Allow/Deny by peer address or CIDR
  5.Keepalive Support
  6.Rate Limit based on The Leaky Bucket Algorithm
  7.Fully Asynchronous TCP RECV/SEND

  1.基于 eSockd 框架的异步 TCP 服务端
  2.TCP Acceptor 池与异步 TCP Accept
  3.TCP/SSL, WebSocket/SSL 连接支持
  4.最大并发连接数限制
  5.基于 IP 地址(CIDR)访问控制
  6.基于 Leaky Bucket 的流控

MQTT 协议编解码::

  1.Parse MQTT frames received from client
  2.Serialize MQTT frames sent to client
  3.MQTT Connection Keepalive

  1.MQTT 协议编解码
  2.MQTT 协议心跳检测
  3.MQTT 协议报文处理


Main erlang modules::

  emqttd_client
  emqttd_ws_client
  emqttd_protocol
  emqttd_parser
  emqttd_serializer


