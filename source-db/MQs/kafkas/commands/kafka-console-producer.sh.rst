kafka-console-producer.sh
#########################

用法::

    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic afei

如果连接集群，那么broker-list参数格式为::

    HOST1:PORT1,HOST2:PORT2,HOST3:PORT3

这个命令后面还可带很多参数::

    --key-serializer：指定key的序列化方式，默认是 org.apache.kafka.common.serialization.StringSerializer
    --value-serializer：指定value的序列化方式，默认是 org.apache.kafka.common.serialization.StringSerializer






