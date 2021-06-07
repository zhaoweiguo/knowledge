kafka-verifiable-consumer.sh
############################

用法::

    bin/kafka-verifiable-consumer.sh --broker-list 10.0.55.229:9092,10.0.55.229:9093,10.0.55.229:9094 \
        --topic afei --group-id groupName

这个脚本的作用是接收指定topic的消息消费，并发出消费者事件，例如：offset提交等。









