kafka-preferred-replica-election.sh
###################################

用法::

    bin/kafka-preferred-replica-election.sh --zookeeper 10.0.55.208:2181/wallet,10.0.55.209:2181/wallet,10.0.55.210:2181/wallet --path-to-json-file afei-preferred.json

注::

    如果不带--path-to-json-file就是对所有topic进行preferred replica election

afei-preferred.json::

    {
        "partitions": [{
            "topic": "afei",
            "partition": 0
        },
        {
            "topic": "afei",
            "partition": 1
        },
        {
            "topic": "afei",
            "partition": 2
        }]
    }

场景::

    在创建一个topic时，kafka尽量将partition均分在所有的brokers上，并且将replicas也均分在不同的broker上。
    每个partitiion的所有replicas叫做"assigned replicas"，
    "assigned replicas"中的第一个replicas叫"preferred replica"，刚创建的topic一般"preferred replica"是leader。
    leader replica负责所有的读写, 其他replica只是冷备状态，不接受读写请求。
    但随着时间推移，broker可能会主动停机甚至客观宕机，会发生leader选举迁移，导致机群的负载不均衡。
    我们期望对topic的leader进行重新负载均衡，让partition选择"preferred replica"做为leader。


验证::

    使用常见一个3个分区3个副本的topic，然后kill掉一个broker。
    1. 这时候topic信息如下，我们可以看到broker.id为0的broker上有两个leader：
    Topic:afei  PartitionCount:3    ReplicationFactor:3 Configs:
        Topic: afei Partition: 0    Leader: 0   Replicas: 0,1,2 Isr: 0,1,2
        Topic: afei Partition: 1    Leader: 1   Replicas: 1,2,0 Isr: 0,1,2
        Topic: afei Partition: 2    Leader: 0   Replicas: 2,0,1 Isr: 0,1,2
  
    2. 执行kafka-preferred-replica-election.sh脚本后，topic信息如下，leader均匀分布在3个不同的broker上
    Topic:afei  PartitionCount:3    ReplicationFactor:3 Configs:
        Topic: afei Partition: 0    Leader: 0   Replicas: 0,1,2 Isr: 0,1,2
        Topic: afei Partition: 1    Leader: 1   Replicas: 1,2,0 Isr: 0,1,2
        Topic: afei Partition: 2    Leader: 2   Replicas: 2,0,1 Isr: 0,1,2













