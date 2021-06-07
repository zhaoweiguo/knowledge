.. _concepts:

Concepts
=============

**Riak是什么?(What is Riak?)**
   Riak是:
      * A Database
      * A key/value store
      * A “NoSQL” database
      * Scalable

   Writen in Erlang and C primaryly with a small amount of JavaScript.
   Riak有两种版本:开源版本和企业版本，其中企业版本是开源版本的超集,它支持SNMP, inter-datacenter replication, web-based administration interface, and top-tier support


**语言支持库(language support libary)**
   * Erlang
   * JavaScript
   * Java
   * PHP
   * Python
   * Ruby

   `深入了解客户端库 <http://wiki.basho.com/Client-Libraries.html>`_

**数据存储(Data Storage)**
   * Buckets and keys
       Buckets and keys是Riak中组织数据的唯一方式，用户数据以bucket/key对的形式存储。
   * Links and Metadata
       Bucket/key entries(这儿作为Riak object),可以指向other entries的links。这links可以直接通过Riak's HTTP 接口或作为map/reduce job的一部分。Riak objects and buckets可以把用户自定义的metadata附加上。这个metadata在HTTP interface作为http headers或者在map/reduce中相关数组。
   * Local Disk Storage
       0.12 release版本来说，Bitcast是Riak默认后端存储。Bitcast是一种简单但功能很强的k/v存储，来作为Riak低延迟，高吞吐存储。
   * Pluggable Backends
       Riak用API来和storage subsystem进行交互，The API允许Riak在需要的时候支持嵌入多个后端。目前Riak支持的后端有:Bitcast, dets, ets,Erlang平衡树(gb_trees)或者直接写入文件中。Riak也支持per-bucket backends(一个Bucket一种后端)。想了解更多请查看 `配置文件 <http://wiki.basho.com/Configuration-Files.html>`_
   * 其他后端(other backends)
       Basho也开发了一个基于嵌入式 ``InnoDB`` 版本，名为 ``Innostore`` 的后端，由于版本许可限制，Innostore需要单独提供，想要察看更多配置innerStore的信息，请参看 `Innostore <http://wiki.basho.com/Innostore.html>`_


**The Riak Cluster**
   任何一个Riak cluster都有一个160-bit的integer space，并会被平均分区.
   一个物理服务器运行N个虚拟结点(vnode)，每个vnode都会在下图的ring中声明一块分区.active vnode的数量由这个ring被划分的分区数决定.这些数量在ring初使化时就决定的了。
   每个在cluster中的每个node被分配ring的1/(physical nodes总数量)，你可以知道每个node中vnode的数量(通过如下计算(partition的数量/node的数量)).
   举个例子，一个ring有32个partition，由4上物理node组成，那么我们就知道每个node有8个vnode，如下图:

.. figure:: image/riak-ring.png
   :width: 50%

   Riak cluster中的所有node都是同等的，每个node都能服务client的所有請求。riak用hash的方法解决了cluster中distribute data.

**Data Replication**
   在riak中replication是基本功能并自动实现，保证数据的安全性，只要你一个node活着，数据就不会丢失。
   下图就是一个实例，n_val=3(这是默认设置)，当存储数据时，这个数据会被复制到ring的3个地方。

.. figure:: image/riak-data-distribution.png
   :width: 50%

   目前，riak用MapReduce执行請求来扩展基本k/v存储模型的限制，
   现在，riak可以用Erlang和javascript来写他们的MapReduce queries。

**读数据(Reading Data)**
    * 读取(fetching)
        Riak objects如果知道bucket和key，就可以直接读取。这Riak得到数据最快的形式！
    * R Value
    * 读容错(Reading failure tolerance)
    * Linking walking
        
**写(更新)数据(Writing and Updating Data)**
    * 向量时钟(Vector clock)
        Vector clock会跟踪每次更新， 决定Riak的顺序，探测分布式系统中的冲突！
    * 冲突解决(Conflict resolution)
        有两种方法，一种是默认最后一次更新为正确，另一种是Riak可以把这个对象的版本都返给客户端，让客户端自己处理
    * W Value
    * 写容错(Writing failure tolerance)

**MapReduce**
    Riak中的MapReduce并行化的操作你的数据，最大化的利用你整个Cluster的硬件资源。MapReduce用一系列含有inputs, phases和timeout of a job信息的JSON来描绘。A job含有任意数量的Map和Reduce phases。所以Riak中的MapReduce可以被认为是实时的迷你Hadoop(real-time "mini-Hadoop"). A job通过HTTP提交返回JSON格式编码(也支持Protocol Buffer接口).

    * 输入(inputs)        
    * Phases
    * Map Phase
    * Link Phase
    * Reduce Phase
    * Query Languages
        可以用Erlang或JavaScript来写，

        * Erlang
        * JavaScript
            Mozilla’s Spidermonkey引擎提供运行环境，预定义的JavaScript函数像erlang函数运行的一样快。JavaScript函数当前只允许对Riak读。

**Secondary Indexes**
    Version 1.0增加对Riak Secondary Indexes的支持。这个属性让应用tag a Riak object with one or more field/value pairs. The object is indexed under these field/value pairs, and the application can later query the index to retrieve a list of matching keys.

    * Schema Free
    * Real-Time and Atomic
    * Query via HTTP, Protocol Buffers, or MapReduce

**The Riak API**
    Riak(由于Erlang REST framework Webmachine)用REST作为他们的API，存储操作用HTTP PUTs和POST，查询操作用HTTP GETs。存储操作用预定义的URL(默认是'/riak')来提交。
    Client可以为Riak設定Content-Type header。Riak will replay the header when the object is fetched. This is nice since it allows Riak to be content agnostic.
    深入了解Riak API请点击 `这儿 <http://wiki.basho.com/HTTP-API.html>`_

