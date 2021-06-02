AMQP协议
##################

消息中间件::

  ActiveMQ:Apache 出品的、采用 Java 语言编写的完全基于 JMS1.1 规范的面向消息的中间件，为应用程序提供高效的、可扩展的、稳定的和安全的企业级消息通信
  RabbitMQ:AMQP 协议的消息中间件，最初起源于金融系统，用于在分布式系统中存储转发消息
  Kafka: LinkedIn 公司采用 Scala 语言开发的一个分布式、多分区、多副本且基于 zookeeper 协调的分布式消息系统
  RocketMQ:阿里开源的消息中间件，目前已经捐献个 Apache 基金会，它是由 Java 语言开发
  ZeroMQ:号称史上最快的消息队列，基于 C 语言开发


选型要点概述 [1]_
'''''''''''''''''''''
功能维度::

  优先级队列
  延迟队列
  死信队列
  重试队列
  消费模式
  广播消费
  消息回溯
  消息堆积 + 持久化
  消息追踪
  消息过滤
  多租户
  多协议支持
  跨语言支持
  流量控制
  消息顺序性
  安全机制
  消息幂等性
  事务性消息

性能::

  消息中间件的吞吐量始终会受到硬件层面的限制。就以网卡带宽为例，如果单机单网卡的带宽为 1Gbps，如果要达到百万级的吞吐，那么消息体大小不得超过 (1Gb/8)/100W，即约等于 134B，换句话说如果消息体大小超过 134B，那么就不可能达到百万级别的吞吐。这种计算方式同样可以适用于内存和磁盘。

  Kafka 在开启幂等、事务功能的时候会使其性能降低，RabbitMQ 在开启 rabbitmq_tracing 插件的时候也会极大的影响其性能。消息中间件的性能一般是指其吞吐量，虽然从功能维度上来说，RabbitMQ 的优势要大于 Kafka，但是 Kafka 的吞吐量要比 RabbitMQ 高出 1 至 2 个数量级，一般 RabbitMQ 的单机 QPS 在万级别之内，而 Kafka 的单机 QPS 可以维持在十万级别，甚至可以达到百万级


可靠性 + 可用性::

  对于 Kafka 而言，其采用的是类似 PacificA 的一致性协议
    通过 ISR（In-Sync-Replica）来保证多副本之间的同步，并且支持强一致性语义（通过 acks 实现）
  对应的 RabbitMQ 是通过镜像环形队列实现多副本及强一致性语义的
    多副本可以保证在 master 节点宕机异常之后可以提升 slave 作为新的 master 而继续提供服务来保障可用性
  Kafka 设计之初是为日志处理而生，给人们留下了数据可靠性要求不要的不良印象
    但是随着版本的升级优化，其可靠性得到极大的增强，详细可以参考 KIP101
  就目前而言，在金融支付领域使用 RabbitMQ 居多，而在日志处理、大数据等方面 Kafka 使用居多
  随着 RabbitMQ 性能的不断提升和 Kafka可靠性的进一步增强，相信彼此都能在以前不擅长的领域分得一杯羹

运维管理::

  rabbitmq:监控管理工具,rabbitmq_management 插件,社区内还有:
  AppDynamics, Collectd, DataDog, Ganglia, Munin, Nagios, New Relic, Prometheus, Zenoss
  Kafka: Kafka Manager, Kafka Monitor, Kafka Offset Monitor, Burrow, Chaperone, Confluent Control Center

社区力度及生态发展::

  一个产品用的人越多，踩过的坑也就越多，对应的解决方案也就越多




.. [1] `消息中间件选型分析：从Kafka与RabbitMQ的对比看全局 <http://www.infoq.com/cn/articles/kafka-vs-rabbitmq>`_


