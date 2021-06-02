架构设计
########

单节点架构
==========

单节点架构保障系统超高的性价比，是测试环境业务、学习培训业务、企业内部系统业务等的首选。

副本集架构
==========

.. image:: /images/dbs/mongodbs/architecture_replica_set.png

MongoDB提供扩展节点功能（扩展至五节点、七节点），您可以按照业务需求增加Secondary节点数量

分片集群架构
============

分片集群实例提供Mongos节点、Shard节点、ConfigServer三个组件。

.. image:: /images/dbs/mongodbs/architecture_shard_cluster.png

Mongos节点::

    单节点架构 
    负责将查询和写操作路由到分片集群实例的对应分片中。

Shard节点::

    副本集架构（三节点）  
    负责存储数据库数据。

ConfigServer节点::

    副本集架构（三节点）  
    用于存储集群和分片的元数据，即各分片包含哪些数据的信息。


