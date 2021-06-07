Kafka Streams [1]_
######################

Kafka Streams是一个Java库，而不是一个流处理框架，这点和Strom等流处理框架有明显地不同

Kafka Streams直接解决了在流处理中会遇到的很多难题::

    一次一件事件的处理(而不是microbatch)，延迟在毫秒
    有状态的处理，包括分布式join和aggregation
    一个方便的DSL
    使用类似于DataFlow的模型来处理乱序数据的windowing问题
    分布式处理，并且有容错机制，可以快速地实现failover
    有重新处理数据的能力，所以当你的代码更改后，你可以重新计算输出。
    没有不可用时间的滚动布署

Kafka Streams是一个用来构建流处理程序的库，特别是其输入是一个Kafka topic，输出是另一个Kafka topic的程序(或者是调用外部服务，或者是更新数据库，或者其它)


在流处理领域有很多正在进行的有趣的工作，包括像 Apache Spark [2]_ , Apache Storm [3]_ ,Apache Flink [4]_ ,和 Apache Samza [5]_ 这样的的开源框架，也包括像Google’s DataFlow [6]_ 和 AWS Lambda [7]_ 一样的专有服务








.. [1] https://docs.confluent.io/3.0.0/streams/index.html
.. [2] http://spark.apache.org/
.. [3] http://storm.apache.org/
.. [4] https://flink.apache.org/
.. [5] http://samza.apache.org/
.. [6] https://cloud.google.com/dataflow/
.. [7] https://aws.amazon.com/cn/lambda/
