日志
####

fluentd
=======

* `官网 <https://www.fluentd.org/>`_
* `github <https://github.com/fluent/fluentd/>`_

简介::

    语言: Ruby
    开源协议: Apache2.0


其他
===

开源的日志系统，包括facebook的scribe，apache的chukwa，linkedin的kafka和cloudera的flume等

【Scribe】 is a server for aggregating log data streamed in real time from a large number of servers


常用的日志收集系统有Syslog-ng，Scribe，Flume，当然还有ELK的LogStash.而目前互联网公司最长用的时Scribe和Flume，Scibe是Facebook开源的，但是现在已经不维护，所以不推荐使用。

其他还有Apache Flume，Apache Chuwka，Apache Kafka


Scribe：C++编写，现在已经不再维护，不推荐使用

Logstash： 针对日志收集，搜索，计算，可视化有一系列的产品，并且可使用的插件以及社区较为活跃推荐使用

Flume: Java编写,较为灵活，并且吞吐量高。业界已经验证过，建议使用

关于日志收集系统，业界的解决方案是ELK

Apache Kafka是一个分布式发布 - 订阅消息系统和一个强大的队列，可以处理大量的数据，并使您能够将消息从一个端点传递到另一个端点。 Kafka适合离线和在线消息消费。 Kafka消息保留在磁盘上，并在群集内复制以防止数据丢失。 Kafka构建在ZooKeeper同步服务之上。 它与Apache Storm和Spark非常好地集成，用于实时流式数据分析。


go实现海量日志收集
http://www.cnblogs.com/zhaof/tag/go%E5%AE%9E%E7%8E%B0%E6%B5%B7%E9%87%8F%E6%97%A5%E5%BF%97%E6%94%B6%E9%9B%86/











