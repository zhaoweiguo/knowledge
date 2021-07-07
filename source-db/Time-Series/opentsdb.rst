OpenTSDB
###############

* 官网 [1]_
* github [2]_



OpenTSDB是一个基于HBase的分布式、可伸缩的开源时序数据库。OpenTSDB由TSD（Time Series Daemon）和一系列命令行工具组成。TSD用于接收用户请求并将时序数据存储在HBase中。TSD之间是相互独立的，没有master，也没有共享状态，因此可以根据系统的负载情况任意进行扩展。下图是一个基于OpenTSDB的监控系统架构图（来自官方文档）

.. figure:: /images/dbs/mysqls/opentsdb_architecture.png
   :width: 80%


主要用途，就是做监控系统；譬如收集大规模集群（包括网络设备、操作系统、应用程序）的监控数据并进行存储，查询
存储到OpenTSDB的数据，是以metric为单位的，metric就是1个监控项，譬如服务器的话，会有CPU使用率、内存使用率这些metric；
OpenTSDB使用HBase作为存储，由于有良好的设计，因此对metric的数据存储支持到秒级别；
OpenTSDB支持数据永久存储，即保存的数据不会主动删除；并且原始数据会一直保存（有些监控系统会将较久之前的数据聚合之后保存）

OpenTSDB存储的一些核心概念::

    譬如假设我们采集1个服务器（hostname=qatest）的CPU使用率，发现该服务器在21:00的时候，CPU使用率达到99%

    1）Metric：即平时我们所说的监控项。譬如上面的CPU使用率
    2）Tags：就是一些标签，在OpenTSDB里面，Tags由tagk和tagv组成，即tagk=tagv。
        标签是用来描述Metric的，譬如上面为了标记是服务器A的CpuUsage，tags可为hostname=qatest
    3）Value：一个Value表示一个metric的实际数值，譬如上面的99%
    4）Timestamp：即时间戳，用来描述Value是什么时候的；譬如上面的21:00
    5）Data Point：即某个Metric在某个时间点的数值。
        Data Point包括以下部分：Metric、Tags、Value、Timestamp
       上面描述的服务器在21:00时候的cpu使用率，就是1个DataPoint

Telegraf [3]_
=============

Telegraf是一款开源的数据采集代理。其设计目标是较小的内存使用，通过插件来构建各种服务和第三方组件的 metrics 收集。Telegraf的内置插件支持将采集的数据上报给OpenTSDB。








.. [1] http://opentsdb.net/
.. [2] https://github.com/OpenTSDB/opentsdb
.. [3] https://github.com/influxdata/telegraf