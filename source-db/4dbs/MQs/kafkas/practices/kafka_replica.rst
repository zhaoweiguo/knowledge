使用多副本(replica)实现高可用
#############################

使用命令行命令查看当前topic 的详细信息::

    [root@idc-cui-pr-kafka-3 kafka]# ./bin/kafka-topics.sh --zookeeper 10.140.2.93:2181,10.140.2.97:2181,10.140.2.92:2181 --describe --topic wen

    Topic:wen PartitionCount:1 ReplicationFactor:1 Configs:
        Topic: wen Partition: 0 Leader: 3 Replicas: 3 Isr: 3

说明::

    • PartitionCount:1   当前topic 的分区个数
    • ReplicationFactor:1 当前topic分区的副本数 

    本例显示的topic wen 副本数为1, 则当topic所在的一个节点(本例为broker 3) down 的状况下，此 topic 将不可用

为了实现topic的高可用，可以在线实时扩展副本::

    可以根据实际应用负载情况来扩展分区（可选）：
    [root@idc-cui-pr-kafka-3 kafka]# ./bin/kafka-topics.sh --alter --zookeeper 10.140.2.93:2181,10.140.2.97:2181,10.140.2.92:2181 --partitions 3 --topic wen 

    WARNING: If partitions are increased for a topic that has a key, the partition logic or ordering of the messages will be affected
    Adding partitions succeeded!

调整完分区信息如下::

    [root@idc-cui-pr-kafka-3 kafka]# bin/kafka-topics.sh --zookeeper 10.140.2.93:2181,10.140.2.97:2181,10.140.2.92:2181 --describe --topic wen
    Topic:wen PartitionCount:3 ReplicationFactor:1 Configs:
    Topic: wen Partition: 0 Leader: 3 Replicas: 3 Isr: 3
    Topic: wen Partition: 1 Leader: 1 Replicas: 1 Isr: 1
    Topic: wen Partition: 2 Leader: 2 Replicas: 2 Isr: 2

扩展副本::

    首先编辑一个a.json 文件，格式如下：
    {
        "version": 1, 
        "partitions": [
            {
                "topic": "wen", 
                "partition": 0, 
                "replicas": [
                    2, 
                    1, 
                    3
                ]
            },
            {
                "topic": "wen", 
                "partition": 1, 
                "replicas": [
                    3, 
                    2, 
                    1
                ]
            },
            {
                "topic": "wen", 
                "partition": 2, 
                "replicas": [
                    1, 
                    2, 
                    3
                ]
            }
        ]
    }

使用 kafka-reassign-partitions.sh 命令行动态调整副本::

    [root@idc-cui-pr-kafka-3 kafka]# bin/kafka-reassign-partitions.sh --zookeeper 10.140.2.93:2181,10.140.2.97:2181,10.140.2.92:2181 --reassignment-json-file a.json --execute

    Current partition replica assignment
    {"version":1,"partitions":[{"topic":"wen","partition":0,"replicas":[3],"log_dirs":["any"]},{"topic":"wen","partition":2,"replicas":[2],"log_dirs":["any"]},{"topic":"wen","partition":1,"replicas":[1],"log_dirs":["any"]}]}
    Save this to use as the --reassignment-json-file option during rollback
    Successfully started reassignment of partitions.


查看调整完成之后的topic 信息::

    [root@idc-cui-pr-kafka-3 kafka]# bin/kafka-topics.sh --zookeeper 10.140.2.93:2181,10.140.2.97:2181,10.140.2.92:2181 --describe --topic wen
    Topic:wen PartitionCount:3 ReplicationFactor:3 Configs:
    Topic: wen Partition: 0 Leader: 3 Replicas: 2,1,3 Isr: 3,2,1
    Topic: wen Partition: 1 Leader: 1 Replicas: 3,2,1 Isr: 1,3,2
    Topic: wen Partition: 2 Leader: 2 Replicas: 1,2,3 Isr: 2,1,3

说明::

    显示副本数为3： ReplicationFactor:3

    这样在三台节点kafka 集群, 有三副本的topic, 在down 掉两个 broker 节点的情况下, 仍然工作正常, 业务不受影响





