kafka-delete-records.sh
#######################

用法::

    bin/kafka-delete-records.sh --bootstrap-server 10.0.55.229:9092,10.0.55.229:9093,10.0.55.229:9094 \
        --offset-json-file offset.json

offset.json文件内容::

    {
        "partitions": [{
            "topic": "afei",
            "partition": 3,
            "offset": 10
        }],
        "version": 1
    }

执行结果如下，表示删除afei这个topic下分区为3的offset少于10的消息日志（不会删除offset=10的消息日志）::

    Executing records delete operation
    Records delete operation completed:
    partition: afei-3   low_watermark: 10






