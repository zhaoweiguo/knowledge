Kafka客户端：sarama
########################


文档 [1]_
源码 [2]_

关于offset::

    1. sarama.OffsetOldest
    2. sarama.OffsetNewest

    只有这2个选项, 如果你执行了session.MarkMessage(msg)
    则client重启后不管你用哪个选项, 只从mark的offset的下一点开始
    如想从最新or最老的开始读取可以使用新的groudId解决


.. [1] https://godoc.org/github.com/Shopify/sarama
.. [2] https://github.com/Shopify/sarama