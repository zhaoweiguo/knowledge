kafka-replica-verification.sh
#############################

用法::

    bin/kafka-replica-verification.sh --broker-list 10.0.55.229:9092,10.0.55.229:9093,10.0.55.229:9094 \
        [--topic-white-list afei]

    参数--topic-white-list指定要检查的目标topic

输出结果如下，如果输出信息为max lag is 0 for ...表示这个topic的复制没有任何延迟::

    2018-07-03 15:04:46,889: verification process is started.
    2018-07-03 15:05:16,811: max lag is 0 for partition multi-1 at offset 0 among 5 partitions
    2018-07-03 15:05:46,812: max lag is 0 for partition multi-1 at offset 0 among 5 partitions
    ... ...





