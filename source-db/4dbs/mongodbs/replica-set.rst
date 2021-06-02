副本集架构
##########

复制的基本架构
==============

* 基本的架构由3台服务器组成，一个三成员的复制集，由三个有数据，或者两个有数据，一个作为仲裁者。

三个存储数据的成员的复制集有::

    一个主库；
    两个从库组成，主库宕机时，这两个从库都可以被选为主库。

在三个成员的复制集中，有两个正常的主从，及一台arbiter节点::

    一个主库
    一个从库，可以在选举中成为主库
    一个aribiter节点，在选举中，只进行投票，不能成为主库

.. image:: /images/dbs/mongodbs/replica_set1.png

.. note:: 　　由于arbiter节点没有复制数据，因此这个架构中仅提供一个完整的数据副本。arbiter节点只需要更少的资源，代价是更有限的冗余和容错。


当主库宕机时，将会选择从库成为主，主库修复后，将其加入到现有的复制集群中即可:

.. image:: /images/dbs/mongodbs/replica_set2.png

Primary选举
-----------

复制集通过replSetInitiate命令（或mongo shell的rs.initiate()）进行初始化，初始化后各个成员间开始发送心跳消息，并发起Priamry选举操作，获得『大多数』成员投票支持的节点，会成为Primary，其余节点成为Secondary。

『大多数』的定义::

    假设复制集内投票成员（后续介绍）数量为N，则大多数为 N/2 + 1
    当复制集内存活成员数量不足大多数时，整个复制集将无法选举出Primary，复制集将无法提供写服务，处于只读状态。

复制集中成员说明
================

Secondary::

    正常情况下，复制集的Seconary会参与Primary选举（自身也可能会被选为Primary），
      并从Primary同步最新写入的数据，以保证与Primary存储相同的数据。
    Secondary可以提供读服务，增加Secondary节点可以提供复制集的读服务能力，同时提升复制集的可用性。
    另外，Mongodb支持对复制集的Secondary节点进行灵活的配置，以适应多种场景的需求。

Arbiter::

    Arbiter节点只参与投票，不能被选为Primary，并且不从Primary同步数据。
    比如你部署了一个2个节点的复制集，1个Primary，1个Secondary，任意节点宕机，复制集将不能提供服务了（无法选出Primary），
        这时可以给复制集添加一个Arbiter节点，即使有节点宕机，仍能选出Primary。
    Arbiter本身不存储数据，是非常轻量级的服务，当复制集成员为偶数时，最好加入一个Arbiter节点，以提升复制集可用性。

Priority0::

    Priority0节点的选举优先级为0，不会被选举为Primary
    比如你跨机房A、B部署了一个复制集，并且想指定Primary必须在A机房，
        这时可以将B机房的复制集成员Priority设置为0，这样Primary就一定会是A机房的成员。
    （注意：如果这样部署，最好将『大多数』节点部署在A机房，否则网络分区时可能无法选出Primary）

Vote0::

    Mongodb 3.0里，复制集成员最多50个，参与Primary选举投票的成员最多7个，其他成员（Vote0）的vote属性必须设置为0，即不参与投票。

Hidden::

    Hidden节点不能被选为主（Priority为0），并且对Driver不可见。因Hidden节点不会接受Driver的请求，
      可使用Hidden节点做一些数据备份、离线计算的任务，不会影响复制集的服务。

Delayed::

    Delayed节点必须是Hidden节点，并且其数据落后与Primary一段时间（可配置，比如1个小时）。
    因Delayed节点的数据比Primary落后一段时间，当错误或者无效的数据写入Primary时，可通过Delayed节点的数据来恢复到之前的时间点。

测试主从复制
============

在主节点插入数据::

    my_repl:PRIMARY> db.movies.insert([ { "title" : "Jaws", "year" : 1975, "imdb_rating" : 8.1 },
     ] );

在主节点查看数据::

    my_repl:PRIMARY> db.movies.find().pretty()
    {
        "_id" : ObjectId("5a4d9ec184b9b2076686b0ac"),
        "title" : "Jaws",
        "year" : 1975,
        "imdb_rating" : 8.1
    }

在从库打开配置（危险: 注意：严禁在从库做任何修改操作）::

    my_repl:SECONDARY> rs.slaveOk()
    my_repl:SECONDARY> show tables;
    movies
    my_repl:SECONDARY> db.movies.find().pretty()
    {
        "_id" : ObjectId("5a4d9ec184b9b2076686b0ac"),
        "title" : "Jaws",
        "year" : 1975,
        "imdb_rating" : 8.1
    }

复制集管理操作
==============

（1）查看复制集状态::

    rs.status();     # 查看整体复制集状态
    rs.isMaster();   #  查看当前是否是主节点

（2）添加,删除节点::

    rs.add("ip:port");     #  新增从节点
    rs.addArb("ip:port"); #  新增仲裁节点
    rs.remove("ip:port"); #  删除一个节点

添加特殊节点时::

    1>可以在搭建过程中设置特殊节点
    2>可以通过修改配置的方式将普通从节点设置为特殊节点
    /*找到需要改为延迟性同步的数组号*/;

3）配置延时节点（一般延时节点也配置成hidden）::

    cfg=rs.conf() 
    cfg.members[2].priority=0
    cfg.members[2].slaveDelay=120
    cfg.members[2].hidden=true

副本集其他操作命令::

    //查看副本集的配置信息
    my_repl:PRIMARY> rs.config()

    //查看副本集各成员的状态
    my_repl:PRIMARY> rs.status()

副本集角色切换（不要人为随便操作）::

    rs.stepDown()
    rs.freeze(300)  # 锁定从，使其不会转变成主库，freeze()和stepDown单位都是秒。
    rs.slaveOk()    # 设置副本节点可读：在副本节点执行
    
    插入数据:
    > use app
    switched to db app
    app> db.createCollection('a')
    { "ok" : 0, "errmsg" : "not master", "code" : 10107 }

    查看副本节点:
    > rs.printSlaveReplicationInfo()
    source: 192.168.1.22:27017
        syncedTo: Thu May 26 2016 10:28:56 GMT+0800 (CST)
        0 secs (0 hrs) behind the primary














