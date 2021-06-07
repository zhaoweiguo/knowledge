kafka-console-consumer.sh
#########################

用法::

    $ bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic afei [--group groupName] [--partition 目标分区]

这个命令后面还可带很多参数::

    --key-deserializer：指定key的反序列化方式，默认是 org.apache.kafka.common.serialization.StringDeserializer
    --value-deserializer：指定value的反序列化方式，默认是 org.apache.kafka.common.serialization.StringDeserializer
    --from-beginning：从最早的消息开始消费，默认是从最新消息开始消费。
    --offset： 从指定的消息位置开始消费，如果设置了这个参数，还需要带上--partition。
        否则会提示：The partition is required when offset is specified.
    --timeout-ms：当消费者在这个参数指定时间间隔内没有收到消息就会推出，并抛出异常：kafka.consumer.ConsumerTimeoutException。
    --whitelist：接收的topic白名单集合，和--topic二者取其一。例如：
        --whitelist "afei.*"（以afei开头的topic）
        --whitelist "afei"（指定afei这个topic）
        --whitelist "afei|fly"（指定afei或者fly这两个topic）
    --blacklist: 和whitelist用法类似。








