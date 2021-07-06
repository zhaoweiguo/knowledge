etcd
####

* github  [1]_
* 官网 [2]_


.. toctree::
   :maxdepth: 1

   etcds/etcd
   etcds/etcdctl
   etcds/principle
   etcds/normal
   etcds/api
   etcds/history

简介::

    开发语言: Golang
    开源协议: Apache 2.0


etcd 是 CoreOS 团队于 2013 年 6 月发起的开源项目，它的目标是构建一个高可用的分布式键值（key-value）数据库，基于 Go 语言实现。受到 :ref:`Apache ZooKeeper <zookeeper>` 项目和 :ref:`doozer <doozer>` 项目的启发，etcd 在设计的时候重点考虑了下面四个要素::

    1. 简单: 具有定义良好、面向用户的 API (gRPC)
    2. 安全: 支持 HTTPS 方式的访问
    3. 快速: 支持并发 10 k/s 的写操作
    4. 可靠: 支持分布式结构，基于 Raft 的一致性算法

    1. Simple: well-defined, user-facing API (gRPC)
    2. Secure: automatic TLS with optional client cert authentication
    3. Fast: benchmarked 10,000 writes/sec
    4. Reliable: properly distributed using Raft




.. [1] https://github.com/etcd-io/etcd
.. [2] https://etcd.io