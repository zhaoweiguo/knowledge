常用
####

topic和partition的关系:

.. image:: /images/dbs/kafkas/kafka_topic_partition.png


kafka与zookeeper 的关系::

    1) Producer端使用zookeeper用来"发现"broker列表,以及和Topic下每个partition leader建立socket连接并发送消息.
    2) Broker端使用zookeeper用来注册broker信息,以及监测partition leader存活性.
    3) Consumer端使用zookeeper用来注册consumer信息,其中包括consumer消费的partition列表等,
       同时也用来发现broker列表,并和partition leader建立socket连接,并获取消息。

Kafka中读写message有例如以下特点::

    1. 写message
    消息从java堆转入page cache(即物理内存)。
    由异步线程刷盘,消息从page cache刷入磁盘。
    
    2. 读message
    消息直接从page cache转入socket发送出去。
    当从page cache没有找到相应数据时，此时会产生磁盘IO,从磁
    盘Load消息到page cache,然后直接从socket发出去

磁盘I/O的性能，引用一组Kafka官方给出的测试数据(Raid-5，7200rpm)::

    Sequence I/O: 600MB/s
    Random I/O: 100KB/s




