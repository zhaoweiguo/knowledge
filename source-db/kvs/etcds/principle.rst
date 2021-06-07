原理
####

.. sidebar:: 目录

    :contents:


etcd读请求
==========

.. figure:: /images/dbs/etcds/architecture2_read.png

   基础架构

串行读与线性读
--------------


.. figure:: /images/dbs/etcds/principle1.png

   KVServer 模块之串行读

数据敏感度::

    1. 数据敏感度低
    串行 (Serializable) 读:
    具有低延时、高吞吐量的特点，适合对数据一致性要求不高的场景。

    2. 数据敏感度高
    线性(lineal)读

    方法1: 使用ReadIndex
    方法2: 早期 etcd 3.0 中读请求通过走一遍 Raft 协议保证一致性， 
      这种 Raft log read 机制依赖磁盘 IO， 性能相比 ReadIndex 较差。


.. figure:: /images/dbs/etcds/principle2.png

   KVServer 模块之线行读


MVCC
----

* 多版本并发控制 (Multiversion concurrency control)::
  
    为了解决 etcd v2 不支持保存 key 的历史版本、不支持多 key 事务等问题而产生的

    它核心由内存树形索引模块 (treeIndex) 和嵌入式的 KV 持久化存储库 boltdb 组成

基于 boltdb 保存一个 key 的多个历史版本::

    方案 1 是一个 key 保存多个历史版本的值
        方案 1 会导致 value 较大，存在明显读写放大、并发冲突等问题

    方案 2 每次修改操作，生成一个新的版本号 (revision)，以版本号为 key， 
        value 为用户 key-value 等信息组成的结构体
        boltdb 的 key 是全局递增的版本号 (revision)，value 是用户 key、value 等字段组合成的结构体
        然后通过 treeIndex 模块来保存用户 key 和版本号的映射关系

.. figure:: /images/dbs/etcds/principle3_mvcc.png

   MVCC 读事务流程图



etcd写请求
==========



















