InfluxDB
###############

* github [1]_
* 官网 [2]_

.. toctree::
   :maxdepth: 2

   influxdbs/normal
   influxdbs/command
   influxdbs/practice
   influxdbs/question





influxdb::

  InfluxDB是一个开源的没有外部依赖的时间序列数据库。适用于记录度量，事件及执行分析。

  特性

  内置HTTP API，所以不用再写服务端代码来启动和运行。
  数据可以被标记，允许非常灵活的查询。
  类似SQL的查询语言
  安装和管理简单，数据输入和输出速度快
  它旨在实时响应查询。这意味着point数据写入即被索引并立即可供响应时间应小于100ms的查询使用。

  开源distributed time series, metrics, and events database。
  Go语言编写, 不依赖于其他外部服务。
  底层支持多种存储引擎，目前是LevelDB, RocksDB, HyberLevelDB和LMDB
   (0.9之后只支持Bolt，最新版本采用了自己写的存储引擎)。







.. [1] https://github.com/influxdata/influxdb
.. [2] https://influxdata.com/