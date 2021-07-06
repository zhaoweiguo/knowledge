etcdctl命令 [1]_
################

常用flag
========

--write-out="table"::

    table



查看集群成员::

    etcdctl member list

集群状态::

    etcdctl endpoint status  --write-out="table"





数据库操作
==========

put::

    $ etcdctl put /testdir/testkey "Hello world"
    OK

get::

    $ etcdctl put testkey hello
    OK
    $ etcdctl get testkey
    testkey
    hello

    查询所有数据:
    $ etcdctl get --from-key ""

    前缀查询:
    etcdctl get --prefix test


del::

    $ etcdctl del testkey
    1


watch::

    监测一个键值的变化，一旦键值发生更新，就会输出最新的值
    例如，用户更新 testkey 键值为 Hello world

    $ etcdctl watch testkey
    PUT
    testkey
    2

member::

    通过 list、add、update、remove 命令列出、添加、更新、删除 etcd 实例到 etcd 集群中
    例如本地启动一个 etcd 服务实例后，可以用如下命令进行查看

    $ etcdctl member list
    422a74f03b622fef, started, node1, http://172.16.238.100:2380, http://172.16.238.100:23


lead 租约
=========

::

    ectdctl lease grant  ttl    创建 lease，返回 lease ID ttl 秒
    ectdctl lease revoke  leaseId  删除 lease，并删除所有关联的 key 
    ectdctl lease timetolive leaseId 取得 lease 的总时间和剩余时间 
    ectdctl lease keep-alive leaseId     keep-alive 会不间断的刷新 lease 时间，从而保证 lease 不会过期。


分布式锁
========

使用 lock 命令后加锁名称 做分布式锁，如果没有显示释放锁，其他地方只能等待::

    etcdctl --endpoints=$ENDPOINTS lock mutex1

    # 在另一个终端输入
    etcdctl --endpoints=$ENDPOINTS lock mutex1
















.. [1] https://github.com/etcd-io/etcd/blob/master/Documentation/dev-guide/interacting_v3.md