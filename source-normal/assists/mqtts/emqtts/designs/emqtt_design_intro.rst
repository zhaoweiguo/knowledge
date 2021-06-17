前言
=======

全异步架构::

  EMQ 消息服务器是基于 Erlang/OTP 平台的全异步的架构：
    异步 TCP 连接处理、
    异步主题(Topic)订阅、
    异步消息发布
  只有在资源负载限制部分采用同步设计，比如
    TCP 连接创建、
    Mnesia 数据库事务执行
  一条 MQTT 消息从发布者(Publisher)到订阅者(Subscriber)，在 EMQ 消息服务器内部异步流过一系列 Erlang 进程 Mailbox:
                    ----------          -----------          ----------
  Publisher --Msg-->| Client | --Msg--> | Session | --Msg--> | Client | --Msg--> Subscriber
                    ----------          -----------          ----------

消息持久化::

  EMQ 1.0 版本不支持服务器内部消息持久化
  EMQ 2.0 版本将发布 EMQ X 平台产品，支持消息持久化到 Redis、Kafka、Cassandra、PostgreSQL 等数据库

  首先，EMQ 解决的核心问题是连接与路由；
  其次，我们认为内置持久化是个错误设计。

  广泛使用的 JMS 服务器 ActiveMQ，几乎每个大版本都在重新设计持久化部分
  Kafka 在上述问题上，做出了正确的设计：一个完全基于磁盘分布式 Commit Log 的消息服务器

  内置消息持久化在设计上有两个问题:
  1.如何平衡内存与磁盘使用？消息路由基于内存，消息存储是基于磁盘。
  2.多服务器分布集群架构下，如何放置 Queue 如何复制 Queue 的消息？

NetSplit问题::

  EMQ 1.0 消息服务器集群，基于 Mnesia 数据库设计
  NetSplit 发生时，节点间状态是：Erlang 节点间可以连通，互相询问自己是否宕机，对方回答你已经宕机:(

  NetSplit 故障发生时，EMQ 消息服务器的 log/emqttd_error.log 日志，会打印 critical 级别日志:

  Mnesia inconsistent_database event: running_partitioned_network, emqttd@host
  EMQ 集群部署在同一 IDC 网络下，NetSplit 发生的几率很低，一旦发生又很难自动处理。所以 EMQ 1.0 版本设计选择是，集群不自动化处理 NetSplit，需要人工重启部分节点。












