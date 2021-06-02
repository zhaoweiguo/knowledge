kafka-topics.sh
###############

创建topic::

    bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic afei --partitions 3 --replication-factor 1

删除topic::

    bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic test

修改topic::

    bin/kafka-topics.sh --zookeeper localhost:2181 --alter --topic afei --partitions 5，修改topic时只能增加分区数量。

查询topic::

    bin/kafka-topics.sh --zookeeper localhost:2181 --describe [ --topic afei ]
    查询时如果带上--topic topicName，那么表示只查询该topic的详细信息
    这时候还可以带上--unavailable-partitions 和--under-replicated-partitions任意一个参数





