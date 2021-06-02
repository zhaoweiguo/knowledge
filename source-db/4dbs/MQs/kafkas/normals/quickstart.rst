Kafka快速使用
##################

基本
====

查看kafka版本::

    进入kafka/libs文件夹。你应该看到像kafka_2.10-0.8.2-beta.jar这样的文件
    其中2.10是Scala版本，0.8.2-beta是Kafka版本

启动zookeeper::

  > ./bin/zookeeper-server-start.sh config/zookeeper.properties
  % 启动kafka-server
  > ./bin/kafka-server-start.sh config/server.properties


创建1个topic:test,单partition,单replica::

  > ./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test

查看topic列表::

  > ./bin/kafka-topics.sh --list --zookeeper localhost:2181
  test

发送消息::

  > ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
  This is a message
  This is another message

启动消费者::

  > ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
  This is a message
  This is another message

Setting up a multi-broker cluster
=================================

启动前操作::

    > cp config/server.properties config/server-1.properties
    > cp config/server.properties config/server-2.properties
    % 更新文件内容, broker.id是唯一的
    config/server-1.properties:
      broker.id=1
      listeners=PLAINTEXT://:9093
      log.dirs=/tmp/kafka-logs-1
    config/server-2.properties:
      broker.id=2
      listeners=PLAINTEXT://:9094
      log.dirs=/tmp/kafka-logs-2

启动::

    > ./bin/kafka-server-start.sh config/server-1.properties &
    ...
    > ./bin/kafka-server-start.sh config/server-2.properties &
    ...

多复制多分区创建topic::

    % 创建topic,3个复制1个分区
    > ./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic my-replicated-topic
    % 1个复制,3个分区,自动删除1小时前数据
    > ./bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --create --topic lager-log-topic --partitions 3 --replication-factor 1 --config cleanup.policy=delete --config retention.ms=3600000


查看topic详情::

    % 1分片,每个分片复制3份
    > ./kafka-topics.sh --describe --zookeeper localhost:2181 --topic lager-log-topic
    Topic:lager-log-topic   PartitionCount:1    ReplicationFactor:3 Configs:
      Topic: lager-log-topic  Partition: 0    Leader: 1   Replicas: 1,2,0 Isr: 1,2,0
    % 3分片,每个分片复制1份
    > ./kafka-topics.sh --describe --zookeeper localhost:2181 --topic lager-log-topic
    Topic:lager-log-topic   PartitionCount:3        ReplicationFactor:1     Configs:retention.ms=7200000,cleanup.policy=delete
      Topic: lager-log-topic  Partition: 0    Leader: 2       Replicas: 2     Isr: 2
      Topic: lager-log-topic  Partition: 1    Leader: 0       Replicas: 0     Isr: 0
      Topic: lager-log-topic  Partition: 2    Leader: 1       Replicas: 1     Isr: 1

    % original topic
    > ./bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic test

生产&消费::

    % 往新topic上生产数据
    > ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic my-replicated-topic
    % 从新topic上消费数据
    > ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic my-replicated-topic








