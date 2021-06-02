QoS
###########################

当网络发生拥塞的时候，所有的数据流都有可能被丢弃；为满足用户对不同应用不同服务质量的要求，就需要网络能根据用户的要求分配和调度资源，对不同的数据流提供不同的服务质量：对实时性强且重要的数据报文优先处理；对于实时性不强的普通数据报文，提供较低的处理优先级，网络拥塞时甚至丢弃

通常QoS提供以下三种服务模型::

  Best-Effort service（尽力而为服务模型）
  Integrated service（综合服务模型，简称Int-Serv）
  Differentiated service（区分服务模型，简称Diff-Serv）


::

    Quality of Service
    QoS的关键指标主要包括可用性、吞吐量、时延、时延变化(包括抖动和漂移)和丢失
    QoS技术包括流分类、流量监管、流量整形、接口限速、拥塞管理、拥塞避免


Qos等级::

  最多一次（0）
  最少一次（1）
  只一次（2）


QoS0:
''''''''''''
场景::

  1.Use QoS 0 when …
  You have a complete or almost stable connection between sender and receiver. A classic use case is when connecting a test client or a front end application to a MQTT broker over a wired connection.
  You don’t care if one or more messages are lost once a while. That is sometimes the case if the data is not that important or will be send at short intervals, where it is okay that messages might get lost.
  You don’t need any message queuing. Messages are only queued for disconnected clients if they have QoS 1 or 2 and a persistent session.
  
架构图:

.. figure:: /images/protocols/protocol_qos0_seq.png
   :width: 70%




QoS1
'''''''''''
场景::

  2.Use QoS 1 when …
  You need to get every message and your use case can handle duplicates. The most often used QoS is level 1, because it guarantees the message arrives at least once. Of course your application must be tolerating duplicates and process them accordingly.
  You can’t bear the overhead of QoS 2. Of course QoS 1 is a lot fast in delivering messages without the guarantee of level 2.
  
架构图:

.. figure:: /images/protocols/protocol_qos1_seq.png
   :width: 70%





QoS2
'''''''''''
场景::

  3.Use QoS 2 when …
  It is critical to your application to receive all messages exactly once. This is often the case if a duplicate delivery would do harm to application users or subscribing clients. You should be aware of the overhead and that it takes a bit longer to complete the QoS 2 flow.


架构图:

.. figure:: /images/protocols/protocol_qos2_seq.png
   :width: 70%




