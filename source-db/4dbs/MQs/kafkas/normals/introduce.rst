1.Kafka简介
############

* 语言支持 [1]_
* 协议指引 [2]_

一个streaming平台有3个关键作用::

    pub/sub记录流,类似消息队列或enterprise messaging system.
    以容错的持久方式存储记录流
    记录发生时处理流

Kafka主要用于以下2大类应用::

    构建在系统和应用间获取可靠数据的实时流数据pipelines
    构建转换或响应数据流的实时流应用程序

一些定义::

    Kafka可运行在一台或多台跨数据中心的服务器组成的集群上
    Kafka集群以topic的类别存储流记录
    每个record包含一key,一value和一时间戳

Kafka有4个api::

    Producer API
    Consumer API
    Streams API
    Connector API
    Adminclient API

担保::

  1.一个producer往一个topic上写消息,会以他们发送的顺序存储
  2.consumer实例以他们存储日志读取记录
  3.一个有N个复制实例的topic,可以容忍N-1个实例挂掉



参考:

* https://www.zybuluo.com/jewes/note/64450
* https://blog.csdn.net/CoderBoom/article/details/84845197


.. [1] https://cwiki.apache.org/confluence/display/KAFKA/Clients
.. [2] https://kafka.apache.org/protocol.html