Kafka用例
##############
应用中的常见实例 [1]_

消息::

  kafka常被用于替换传统的消息代理。
  消息代理主要用于:分离数据生成操作与数据处理操作;缓冲未处理的消息。
  与传统的消息代理相比,kafka具有更高的吞吐、内置分区、复制、容错,使其成为大规模消息处理的选择

  消息的使用相对来说是:比较低的吞吐,但也相应要求更低的延时

  对比项: ActiveMQ or RabbitMQ.

Website Activity Tracking::

  kafka的原始用例,想把用户行为跟踪pipeline重建为一组实时pub/sub源
  这意味着Website Activity(包括pageviews, searchs等行为)
        被按activity type不同pub到不同的topic上
  这些源可以被sub到一系列用例,包括(实时处理、实时监控、加载到hadoop、用于脱机处理和报告的离线仓库系统)

  Activity tracking需求非常大的volume,因为每个活动用户页面都会产生activity messages

Metrics::

  Kafka is often used for operational monitoring data. 
  This involves aggregating statistics from distributed applications 
    to produce centralized feeds of operational data.

Log Aggregation::

  很多人用kafka做Log Aggregation解决方案
  经典的Log Aggregation是从各server收集物理日志文件,把它们合并放到中心化的地方(file服务器或HDFS)进行处理
  Kafka实现了Log Aggregation方案,并允许更低延时处理,并更容易支持多个数据源和多个分布式数据消耗
  对比日志中心系统(如Scribe or Flume),kafka提供了更高的效率、更强的耐用性保证、更低的端到端延时

Stream Processing::

  使用kafka做多阶段的管道数据流转:
  原始数据从kafka中消费,丰富然后聚合,生成新的数据转换为新主题写入到kafka中,以供一步的消费和后续处理
  这样处理pipeline基于各个主题创建实时数据流图
  从0.10.0.0开始,轻量但功能强大的流处理库 <Kafka Streams>_ 用于执行上面的数据处理
  类似的开源流处理工具有: Apache Storm and Apache Samza.

Event Sourcing::

  Event Sourcing是一种应用程序的设计风格,其状态更改被写入日志为时间排序的记录序列
  Kafka对非常大的存储日志数据的支持使其成为一个以此风格构建应用的出色后端

Commit Log::

  Kafka可作为分布式系统的一种external commit-log
  此种log有助于在节点间复制数据,并充当故障节点恢复数据的重新同步机制
  Kafka的压缩功能有助于支持此用法
  类似的项目有: Apache BookKeeper





.. [1] https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying

