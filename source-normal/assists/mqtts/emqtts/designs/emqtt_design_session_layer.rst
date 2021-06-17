Session会话层
======================

会话层处理 MQTT 协议发布订阅(Publish/Subscribe)业务交互流程::

  1.缓存 MQTT 客户端的全部订阅(Subscription)，并终结订阅 QoS
  2.处理 Qos0/1/2 消息接收与下发，消息超时重传与离线消息保存
  3.飞行窗口(Inflight Window)，下发消息吞吐控制与顺序保证
  4.保存服务器发送到客户端的，已发送未确认的 Qos1/2 消息
  5.缓存客户端发送到服务端，未接收到 PUBREL 的 QoS2 消息
  6.客户端离线时，保存持久会话的离线 Qos1/2 消息

The session layer processes MQTT packets received from client and delivers PUBLISH packets to client::

  A MQTT session will store the subscriptions and inflight messages in memory:
  1.The Client’s subscriptions.
  2.Inflight qos1/2 messages sent to the client but unacked, QoS 2 messages which have been sent to the Client, but have not been completely acknowledged.
  3.Inflight qos2 messages received from client and waiting for PUBREL. QoS 2 messages which have been received from the Client, but have not been completely acknowledged.
  4.All qos1, qos2 messages published to when client is disconnected.


MQueue and Inflight Window(消息队列与飞行窗口)::

  Concept of Message Queue and Inflight Window:
        |<----------------- Max Len ----------------->|
      -----------------------------------------------
  IN -> |     Messages Queue    |  Inflight Window    | -> Out
        -----------------------------------------------
                                |<---   Win Size  --->|

  1.Inflight Window to store the messages delivered and await for PUBACK.
  2.Enqueue messages when the inflight window is full.
  3.If the queue is full, drop qos0 messages if store_qos0 is true, otherwise drop the oldest one.

  1.飞行窗口(Inflight Window)保存当前正在发送未确认的 Qos1/2 消息
  2.当客户端离线或者飞行窗口(Inflight Window)满时，消息缓存到队列
  3.如果消息队列满，先丢弃 Qos0 消息或最早进入队列的消息

  The larger the inflight window size is, the higher the throughput is. The smaller the window size is, the more strict the message order is.
  窗口值越大，吞吐越高；窗口值越小，消息顺序越严格。

PacketId and MessageId（报文 ID 与消息 ID）::

  PacketId:16bit
  MessageId:128bit

  |        Timestamp       |  NodeID + PID  |  Sequence  |
  |<------- 64bits ------->|<- 16+32bits -->|<- 16bits ->|

  The PacketId and MessageId in a End-to-End Message PubSub Sequence:
  
  PktId <-- Session --> MsgId <-- Router --> MsgId <-- Session --> PktId




