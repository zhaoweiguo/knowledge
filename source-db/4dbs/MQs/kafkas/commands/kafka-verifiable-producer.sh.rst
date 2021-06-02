kafka-verifiable-producer.sh
############################

用法::

    bin/kafka-verifiable-producer.sh --broker-list 10.0.55.229:9092,10.0.55.229:9093,10.0.55.229:9094 \
        --topic afei [--max-messages 64]

    建议使用该脚本时增加参数--max-messages，否则会不停的发送消息。

这个脚本的作用是持续发送消息到指定的topic中，参数--max-messages限制最大发送消息数。且每条发送的消息都会有响应信息，这就是和kafka-console-producer.sh最大的不同::

    [mwopr@jtcrtvdra35 kafka_2.12-1.1.0]$ bin/kafka-verifiable-producer.sh  --broker-list 10.0.55.229:9092,10.0.55.229:9093,10.0.55.229:9094 --topic afei --max-messages 9
    {"timestamp":1530515959900,"name":"startup_complete"}
    {"timestamp":1530515960310,"name":"producer_send_success","key":null,"value":"1","offset":5,"topic":"afei","partition":0}
    {"timestamp":1530515960315,"name":"producer_send_success","key":null,"value":"4","offset":6,"topic":"afei","partition":0}
    {"timestamp":1530515960315,"name":"producer_send_success","key":null,"value":"7","offset":7,"topic":"afei","partition":0}
    {"timestamp":1530515960316,"name":"producer_send_success","key":null,"value":"0","offset":5,"topic":"afei","partition":1}
    {"timestamp":1530515960316,"name":"producer_send_success","key":null,"value":"3","offset":6,"topic":"afei","partition":1}
    {"timestamp":1530515960316,"name":"producer_send_success","key":null,"value":"6","offset":7,"topic":"afei","partition":1}
    {"timestamp":1530515960316,"name":"producer_send_success","key":null,"value":"2","offset":6,"topic":"afei","partition":2}
    {"timestamp":1530515960316,"name":"producer_send_success","key":null,"value":"5","offset":7,"topic":"afei","partition":2}
    {"timestamp":1530515960316,"name":"producer_send_success","key":null,"value":"8","offset":8,"topic":"afei","partition":2}
    {"timestamp":1530515960333,"name":"shutdown_complete"}
    {"timestamp":1530515960334,"name":"tool_data","sent":9,"acked":9,"target_throughput":-1,"avg_throughput":20.689655172413794}

afei这个topic有3个分区，使用kafka-verifiable-producer.sh发送9条消息。根据输出结果可以看出，往每个分区发送了3条消息。另外，我们可以通过设置参数--max-messages一个比较大的值，可以压测一下搭建的kafka集群环境。











