kafka-log-dirs.sh
#################

用法::

    bin/kafka-log-dirs.sh --bootstrap-server localhost:9092 --describe --topic-list afei[,topicName2,topicNameN]

* 如果没有指定--topic-list，那么会输出所有kafka消息日志目录以及目录下所有topic信息。
* 加上--topic-list参数后，输出结果如下，由这段结果可知，消息日志所在目录为/data/kafka-logs，并且afei这个topic有3个分区







