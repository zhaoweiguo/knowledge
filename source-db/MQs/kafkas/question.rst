常见问题
###########

Broker may not be available
===========================
现象::

    $>  ./kafka-console-producer.sh --broker-list localhost:9092 --topic test

    [2018-03-08 13:59:36,276] WARN [Producer clientId=console-producer] Connection to node -1 could not be established. Broker may not be available. (org.apache.kafka.clients.NetworkClient)
    [2018-03-08 14:01:43,637] WARN [Producer clientId=console-producer] Connection to node -1 could not be established. Broker may not be available. (org.apache.kafka.clients.NetworkClient)
    [2018-03-08 14:03:51,125] WARN [Producer clientId=console-producer] Connection to node -1 could not be established. Broker may not be available. (org.apache.kafka.clients.NetworkClient)

原因::

    endpoints:["PLAINTEXT://172.28.50.143:9092"] 

解决::

    将localhost:9092改为PLAINTEXT://172.28.50.143:9092
    $> ./kafka-console-consumer.sh --bootstrap-server PLAINTEXT://172.28.50.143:9092 --topic test

panic: kafka: client has run out of available brokers
=====================================================

* 现象::

    panic: kafka: client has run out of available brokers to talk to 
    (Is your cluster reachable?)

* 过程::
  
    最近用golang写的一个项目用到kafka,在本地测试好好的,一到线上就有问题
    最后一点点调试找到原因,连接kafka server是成功的,但收到返回值是"EOF",最后找到原因

* 原因::

    由于kafka的版本不一致导致的

* 说明::

    kafka_2.10-0.8.2-beta.jar
    其中:
      2.10是Scala版本
      0.8.2-beta是Kafka版本


kafka如何保证这种有序性
=======================

问题::

    如何保证消息消费的有序性呢？比如说生产者生产了0到100个商品，那么消费者在消费的时候按照0到100这个从小到大的顺序消费，
    *** 那么kafka如何保证这种有序性呢？***
    难度就在于，生产者生产出0到100这100条数据之后，通过一定的分组策略存储到broker的partition中的时候，
    比如0到10这10条消息被存到了这个partition中，10到20这10条消息被存到了那个partition中，
    这样的话，消息在分组存到partition中的时候就已经被分组策略搞得无序了。
    那么能否做到消费者在消费消息的时候全局有序呢？
    遇到这个问题，我们可以回答，在大多数情况下是做不到全局有序的。
    但在某些情况下是可以做到的。比如我的partition只有一个，这种情况下是可以全局有序的。
    那么可能有人又要问了，只有一个partition的话，哪里来的分布式呢？哪里来的负载均衡呢？
    所以说，全局有序是一个伪命题！全局有序根本没有办法在kafka要实现的大数据的场景来做到。
    但是我们只能保证当前这个partition内部消息消费的有序性。

结论::

        一个partition中的数据是有序的吗？回答：间隔有序，不连续。

        针对一个topic里面的数据，只能做到partition内部有序，不能做到全局有序。
        特别是加入消费者的场景后，如何保证消费者的消费的消息的全局有序性，
        这是一个伪命题，只有在一种情况下才能保证消费的消息的全局有序性，那就是只有一个partition。








