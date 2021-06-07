常见命令
##############


.. contents::
   :depth: 1
   :local:
   :backlinks: none

.. highlight:: console


默认配置文件 ``conf/zoo.cfg``::

   tickTime=2000     # basic time unit(2000ms)
   dataDir=/var/lib/zookeeper    # 数据目录
   dataLogDir = /var/lib/zklog   # log目录, 默认和dataDir相同的设置.
   clientPort=2181


replicated mode配置文件::

    tickTime=2000    # zookeeper中使用的基本时间单位, 毫秒值
    dataDir=/var/lib/zookeeper
    dataLogDir=/var/log/zookeeper
    clientPort=2181

    initLimit=5    # follower和leader之间的最长心跳时间(基于tickTime),这儿是5*2000ms=10s
    syncLimit=2    # leader和follower之间发送消息, 请求和应答的最大时间长度

    server.1=<zoo1>:2888:3888   # 2888为该server和集群中的leader交换消息所使用的端口
    server.2=<zoo2>:2888:3888   # 3888为选举leader时所使用的端口
    server.3=<zoo3>:2888:3888






命令使用::

    bin/zkServer.sh start   //启动server
    // client
    bin/zkCli.sh -server 127.0.0.1:2181   // java
    ./cli_mt 127.0.0.1:2181    // c

    // 命令使用
    zk> help
    zk> ls /
    zk> create /<nodeName> <value>
    zk> get /<nodeName>  
    zk> set /<nodeName> <value>
    zk> delete /<nodeName>  # 子结点为空
    zk> rmr /<nodeName>     # 级联删除

使用get命令获取指定节点的数据时, 同时也将返回该节点的状态信息, 称为Stat. 其包含如下字段::

    czxid. 节点创建时的zxid.
    mzxid. 节点最新一次更新发生时的zxid.
    ctime. 节点创建时的时间戳.
    mtime. 节点最新一次更新发生时的时间戳.
    dataVersion. 节点数据的更新次数.
    cversion. 其子节点的更新次数.
    aclVersion. 节点ACL(授权信息)的更新次数.
    ephemeralOwner. 如果该节点为ephemeral节点, ephemeralOwner值表示与该节点绑定的session id. 如果该节点不是ephemeral节点, ephemeralOwner值为0. 至于什么是ephemeral节点, 请看后面的讲述.
    dataLength. 节点数据的字节数.
    numChildren. 子节点个数.


节点类型::


    1. persistent:

    2. ephemeral: 临时性的, 如果创建该节点的session结束了, 该节点就会被自动删除. ephemeral节点不能拥有子节点. 虽然ephemeral节点与创建它的session绑定, 但只要该该节点没有被删除, 其他session就可以读写该节点中关联的数据. 使用-e参数指定创建ephemeral节点
    zk> create -e /zookeeper/weiguo/<node1> <value1>

    3. sequence:sequence节点既可以是ephemeral的, 也可以是persistent的. 创建sequence节点时, ZooKeeper server会在指定的节点名称后加上一个数字序列, 该数字序列是递增的. 因此可以多次创建相同的sequence节点, 而得到不同的节点. 使用-s参数指定创建sequence节点:
    zk> create -s /zookeeper/weiguo/item value1
    Created /zookeeper/weiguo/item000001


Watch监听::

    1. ls命令的第一个参数指定znode, 第二个参数如果为true, 则说明监听该znode的"子节点的增减", 以及"该znode本身的删除事件"
    zk> ls /zookeeper true  # 增加第二个参数true
    zk> create /zookeeper/new  <value>

    WATCHER:

    WatchEvent state:SyncConnected type:NodeChildrenChanged path:/zookeeper
    Created /zookeeper/new

    2. get命令的第一个参数指定znode, 第二个参数如果为true, 则说明监听该znode的更新和删除事件.





