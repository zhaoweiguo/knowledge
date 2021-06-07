kafka-reassign-partitions.sh
############################

场景::

    将一些topic上的分区从当前所在broker移到其他比如新增的broker上。
    假设有个名为ORDER-DETAIL的topic，在broker.id为2的broker上：
    Topic:ORDER-DETAIL  PartitionCount:1    ReplicationFactor:1 Configs:
    Topic: ORDER-DETAIL Partition: 0    Leader: 2   Replicas: 2 Isr: 2

现在想要把它移动到broker.id为1的broker上，执行脚本::

    bin/kafka-reassign-partitions.sh \
        --zookeeper 10.0.55.208:2181/wallet,10.0.55.209:2181/wallet,10.0.55.210:2181/wallet \
        --topics-to-move-json-file move.json --broker-list "1" --generate

--generate参数表示生成一个分区再分配配置，并不会真正的执行，命令执行结果如下::

    Current partition replica assignment
    {"version":1,"partitions":[{"topic":"ORDER-DETAIL","partition":0,"replicas":[2],"log_dirs":["any"]}]}

    Proposed partition reassignment configuration
    {"version":1,"partitions":[{"topic":"ORDER-DETAIL","partition":0,"replicas":[1],"log_dirs":["any"]}]}

我们只需要把第二段json内容保存到一个新建的final.json文件中（如果知道如何编写这段json内容，那么也可以不执行第一条命令），然后执行命令::

    bin/kafka-reassign-partitions.sh \
    --zookeeper 10.0.55.208:2181/wallet,10.0.55.209:2181/wallet,10.0.55.210:2181/wallet \
    --reassignment-json-file move_final.json --execute

    注: 此次执行的命令带有--execute参数，说明是真正的执行分区重分配。

通过这个命令还可以给某个topic增加副本，例如有一个名为ORDER-DETAIL的topic，有3个分区，但是只有1个副本，为了高可用，需要将副本数增加到2，那么编写replica.json文本内容如下::

    {
        "version": 1,
        "partitions": [{
            "topic": "ORDER-DETAIL",
            "partition": 0,
            "replicas": [1, 2]
        },
        {
            "topic": "ORDER-DETAIL",
            "partition": 1,
            "replicas": [0, 2]
        },
        {
            "topic": "ORDER-DETAIL",
            "partition": 2,
            "replicas": [1, 0]
        }]
    }

然后执行命令即可::

    bin/kafka-reassign-partitions.sh \
        --zookeeper 10.0.55.208:2181/wallet,10.0.55.209:2181/wallet,10.0.55.210:2181/wallet \
        --reassignment-json-file replica.json














