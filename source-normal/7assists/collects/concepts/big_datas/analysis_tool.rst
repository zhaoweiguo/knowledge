MOLAP分析工具
-----------------

Kylin （apache开源分布式分析引擎软件）
''''''''''''''''''''''''''''''''''''''

Apache Kylin™是一个开源的分布式分析引擎，提供Hadoop之上的SQL查询接口及多维分析（OLAP）能力以支持超大规模数据，最初由eBay Inc. 开发并贡献至开源社区。它能在亚秒内查询巨大的Hive表。

优势:

- 可扩展超快OLAP引擎:
    Kylin是为减少在Hadoop上百亿规模数据查询延迟而设计
- Hadoop ANSI SQL 接口:
    Kylin为Hadoop提供标准SQL支持大部分查询功能
- 交互式查询能力:
    通过Kylin，用户可以与Hadoop数据进行亚秒级交互，在同样的数据集上提供比Hive更好的性能
- 多维立方体（MOLAP Cube）:
    用户能够在Kylin里为百亿以上数据集定义数据模型并构建立方体
- 与BI工具无缝整合:
    Kylin提供与BI工具，如Tableau，的整合能力，即将提供对其他工具的整合
- 其他特性:
  - Job管理与监控
  - 压缩与编码
  - 增量更新
  - 利用HBase Coprocessor
  - 基于HyperLogLog的Dinstinc Count近似算法
  - 友好的web界面以管理，监控和使用立方体
  - 项目及立方体级别的访问控制安全
  - 支持LDAP

Druid
''''''''
Druid是阿里巴巴开源平台上的一个项目，整个项目由数据库连接池、插件框架和SQL解析器组成。该项目主要是为了扩展JDBC的一些限制，可以让程序员实现一些特殊的需求，比如向密钥服务请求凭证、统计SQL信息、SQL性能收集、SQL注入检查、SQL翻译等，程序员可以通过定制来实现自己需要的功能。
Druid 是目前比较流行的高性能的，分布式列存储的OLAP框架(具体来说是MOLAP)。它有如下几个特点：
一. 亚秒级查询
druid提供了快速的聚合能力以及亚秒级的OLAP查询能力，多租户的设计，是面向用户分析应用的理想方式。
二.实时数据注入
druid支持流数据的注入，并提供了数据的事件驱动，保证在实时和离线环境下事件的实效性和统一性
三.可扩展的PB级存储
druid集群可以很方便的扩容到PB的数据量，每秒百万级别的数据注入。即便在加大数据规模的情况下，也能保证时其效性
四.多环境部署
druid既可以运行在商业的硬件上，也可以运行在云上。它可以从多种数据系统中注入数据，包括hadoop，spark，kafka，storm和samza等
五.丰富的社区
druid拥有丰富的社区，供大家学习。


phoenix
''''''''''''

OLTP and operational analytics for Apache Hadoop
http://phoenix.apache.org/

Apache Phoenix可以做Hadoop的OLTP和运营分析(operational analytics)
通过结合下面2个世界的优点，为低延迟应用程序提供:

    1.具有完整ACID事务功能的标准SQL和JDBC API的强大能力，
    2.以及利用HBase作为后备存储，具有NoSQL世界的灵活性，包括late-bound, schema-on-read

Apache Phoenix与其他Hadoop产品完全集成，如Spark，Hive，Pig，Flume和Map Reduce。

Phoenix查询引擎支持使用SQL进行HBase数据的查询，会将SQL查询转换为一个或多个HBase API，协同处理器与自定义过滤器的实现，并编排执行。使用Phoenix进行简单查询，其性能量级是毫秒。

Phoenix 与 Spark的区别:
ApsaraDB Phoenix是ApsaraDB HBase提供的SQL层，主要为了解决高并发、低延迟、简单查询场景，当然也可以解决一定的分析需求。 必须命中索引 且 命中后 返回的数据较少，如果是join，则join任意一则返回的数据量在10w以下，且另一侧必须命中索引。 为了保障集群稳定性，一些复杂的sql及耗时的sql会被平台拒绝运行。

ApsaraDB Spark是ApsaraDB HBase提供的分析引擎，满足 低并发，高延迟，复杂计算 场景。 不管怎么复杂的SQL，都可以完成。 另外 Spark可以支持sql、scala、java、python语言，支持流、OLAP、离线分析、数据清洗、支持多源(HBase、MongoDB、Redis、OSS等)。 (Spark Streaming支持准实时的在线流，不在此讨论访问内)

简单查询、 高并发、低延迟、 、在线业务 选择 Phoenix
复杂计算、低并发、高延迟、离线业务、准在线业务 选择 Spark


Spark/Spark SQL
''''''''''''''''''''

Apache Spark 是专为大规模数据处理而设计的快速通用的计算引擎。Spark是UC Berkeley AMP lab (加州大学伯克利分校的AMP实验室)所开源的类Hadoop MapReduce的通用并行框架，Spark，拥有Hadoop MapReduce所具有的优点；但不同于MapReduce的是——Job中间输出结果可以保存在内存中，从而不再需要读写HDFS，因此Spark能更好地适用于数据挖掘与机器学习等需要迭代的MapReduce的算法。
Spark 是在 Scala 语言中实现的，它将 Scala 用作其应用程序框架。与 Hadoop 不同，Spark 和 Scala 能够紧密集成，其中的 Scala 可以像操作本地集合对象一样轻松地操作分布式数据集。
尽管创建 Spark 是为了支持分布式数据集上的迭代作业，但是实际上它是对 Hadoop 的补充，可以在 Hadoop 文件系统中并行运行。通过名为 Mesos 的第三方集群框架可以支持此行为。Spark 由加州大学伯克利分校 AMP 实验室 (Algorithms, Machines, and People Lab) 开发，可用来构建大型的、低延迟的数据分析应用程序。

Spark 主要有三个特点：
首先，高级 API 剥离了对集群本身的关注，Spark 应用开发者可以专注于应用所要做的计算本身。
其次，Spark 很快，支持交互式计算和复杂算法。
最后，Spark 是一个通用引擎，可用它来完成各种各样的运算，包括 SQL 查询、文本处理、机器学习等，而在 Spark 出现之前，我们一般需要学习各种各样的引擎来分别处理这些需求。



.. _presto:

Presto
''''''''''

1.1 定义
Presto是一个分布式的查询引擎，本身并不存储数据，但是可以接入多种数据源，并且支持跨数据源的级联查询。Presto是一个OLAP的工具，擅长对海量数据进行复杂的分析；但是对于OLTP场景，并不是Presto所擅长，所以不要把Presto当做数据库来使用。

和大家熟悉的Mysql相比：首先Mysql是一个数据库，具有存储和计算分析能力，而Presto只有计算分析能力；其次数据量方面，Mysql作为传统单点关系型数据库不能满足当前大数据量的需求，于是有各种大数据的存储和分析工具产生，Presto就是这样一个可以满足大数据量分析计算需求的一个工具。

1.2 数据源
Presto需要从其他数据源获取数据来进行运算分析，它可以连接多种数据源，包括Hive、RDBMS（Mysql、Oracle、Tidb等）、Kafka、MongoDB、Redis等

一条Presto查询可以将多个数据源的数据进行合并分析。
比如：select * from a join b where a.id=b.id;，其中表a可以来自Hive，表b可以来自Mysql。

1.3 优势
Presto是一个低延迟高并发的内存计算引擎，相比Hive，执行效率要高很多。


1.4数据模型
Presto使用Catalog、Schema和Table这3层结构来管理数据。

Catalog:就是数据源。Hive是数据源，Mysql也是数据源，Hive 和Mysql都是数据源类型，可以连接多个Hive和多个Mysql，每个连接都有一个名字。一个Catalog可以包含多个Schema，大家可以通过show catalogs 命令看到Presto连接的所有数据源。
Schema：相当于一个数据库实例，一个Schema包含多张数据表。show schemas from 'catalog_name'可列出catalog_name下的所有schema。
Table：数据表，与一般意义上的数据库表相同。show tables from 'catalog_name.schema_name'可查看'catalog_name.schema_name'下的所有表。

在Presto中定位一张表，一般是catalog为根，例如：一张表的全称为 hive.test_data.test，标识 hive(catalog)下的 test_data(schema)中test表。
可以简理解为：数据源的大类.数据库.数据表。


Presto与Hive:

Hive是一个基于HDFS(分布式文件系统)的一个数据库，具有存储和分析计算能力， 支持大数据量的存储和查询。Hive 作为数据源，结合Presto分布式查询引擎，这样大数据量的查询计算速度就会快很多。

Presto支持标准SQL，这里需要提醒大家的是，在使用Hive数据源的时候，如果表是分区表，一定要添加分区过滤，不加分区扫描全表是一个很暴力的操作，执行效率低下并且占用大量集群资源，大家尽量避免这种写法。

这里提到Hive分区，我简单介绍一下概念。Hive分区就是分目录，把一个大的数据集根据业务需要分割成更细的数据集。











