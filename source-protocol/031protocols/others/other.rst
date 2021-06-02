其他
####



MQTT-SN Protocol::

  MQTT-SN 协议是 MQTT 的直系亲属，它使用 UDP 进行通信，标准的端口是1884。MQTT-SN 的主要目的是为了适应受限的设备和网络，比如一些传感器，只有很小的内存和 CPU，TCP 对于这些设备来说非常奢侈。还有一些网络，比如 ZIGBEE，报文的长度在300字节以下，无法承载太大的数据包。所以 MQTT-SN 的数据包更小巧。

  MQTT-SN 的官方标准下载地址: http://mqtt.org/new/wp-content/uploads/2009/06/MQTT-SN_spec_v1.2.pdf


  MQTT-SN stands for “MQTT for Sensor Networks”
  说明书:http://mqtt.org/new/wp-content/uploads/2009/06/MQTT-SN_spec_v1.2.pdf
  WILL message???
  与MQTT的不同:TopicId,16bits整形代替TopicName

LWM2M(Lightweight M2M) Protocol::

  based on coap protocol, and can be carried on UDP or SMS.
  LWM2M 是由 Open Mobile Alliance(OMA) 定义的一套适用于物联网的协议，它提供了设备管理和通讯的功能。协议可以在 这里 下载。



::

   支持xhr-polling/jsonp-polling/htmlfile/websocket/flashsocket等通讯协议


::

  iotivity协议
    https://iotivity.org/
  protobuffer协议

noiseprotocol::

    http://noiseprotocol.org/
    Noise is a framework for crypto protocols based on Diffie-Hellman key agreement. 
    Noise can describe protocols that consist of a single message as well as interactive protocols.

NTP::

    网络时间协议（英語：Network Time Protocol，缩写：NTP）是在数据网络潜伏时间可变的计算机系统之间通过分组交换进行时钟同步的一个网络协议，位于OSI模型的应用层。 自1985年以来，NTP是目前仍在使用的最古老的互联网协议之一。 NTP由特拉华大学的David L. Mills设计。








