常用命令
########

查看当前数据库的可用连接数::

    > db.serverStatus().connections
    { 
        "current" : 6.0, 
        "available" : 3885.0, 
        "totalCreated" : 9.0
    }

开启慢日志::

    db.setProfilingLevel(<level>, <slowtime_ms>)

    参数说明:
    1. level:
      // 支持三个级别:
      0:默认，不开启命令记录
      1:记录慢日志，默认记录执行时间大于 100ms 的命令
      2:记录所有命令
    2. slowtime_ms:
      指定超过多少 ms 被认为是慢命令


直接获取当前数据库正在执行中的命令::

    db.currentOp()


停止指定进程的操作::

    db.killOp(99080)

获取某一个集合总的索引大小(bytes)::

    db.collection.totalIndexSize()

查看占存储量
============

数据库查询::

    > db.stats();
    {
      "db" : "test",        // 当前数据库
      "collections" : 3,      // 当前数据库多少表
      "objects" : 4,        // 当前数据库所有表多少条数据
      "avgObjSize" : 51,      // 每条数据的平均大小
      "dataSize" : 204,      // 所有数据的总大小
      "storageSize" : 16384,    // 所有数据占的磁盘大小
      "numExtents" : 3,
      "indexes" : 1,        // 索引数
      "indexSize" : 8176,     // 索引大小
      "fileSize" : 201326592,   // 预分配给数据库的文件大小
      "nsSizeMB" : 16,
      "dataFileVersion" : {
        "major" : 4,
        "minor" : 5
      },
      "ok" : 1
    }

普通表查询::

    > db.log.stats();
    {
        sharded: false,                     // 此表为非shard表
        primary: "d-2ze15bc9e0a5c484",
        capped: false,
        ns: "api.log",                      // 表名
        count: 639909865,                   // 条数: 6.39亿
        size: 3.58750408577E11,             // 未压缩的数据(raw document size): 350G
        storageSize: 1.5874340864E11,       // 数据占存储量: 150G(data on disk is compressed)
        totalIndexSize: 8.442488832E10,     // 索引占存储量: 84G
        indexSizes: {                       // 各索引分别占多少存储
            _id_: 2.8398866432E10,
            event_source_type_1_user_id_1_time_created_-1: 9.11304704E9,
            is_delete_1_is_read_1_event_type_1_event_source_type_1_user_id_1: 4.870557696E9,
            is_delete_1_user_id_1_time_created_-1: 9.08275712E9,
            source_id_1: 4.208246784E9,
            source_id_1_user_id_1_is_delete_1_is_read_1: 5.08647424E9,
            source_id_1_user_id_1_is_delete_1_is_read_1_time_created_-1: 1.1746791424E10,
            time_created_1: 7.15108352E9,
            user_id_1: 4.767064064E9
        },
        avgObjSize: 560.0,
        maxSize: NumberLong(0),
        nindexes: 9,
        nchunks: 1
    }

shard cluster表查询::

    > db.log.stats();
    {
        sharded: true,                          // 此表为shard表
        capped: false,
        ns: "api.update_gadget_statistic",      // 表名
        count: 893400504,                       // 表条数, 这儿是8.9亿
        size: NumberLong(1152228969217),        // 未压缩的数据(raw document size)
        storageSize: 3.76780988416E11,          // 数据占存储量: 376G(data on disk is compressed)
        totalIndexSize: 8.8084123648E10,        // 索引占存储量: 88G
        indexSizes: {                           // 各索引分别占多少存储
            _id_: 3.8060089344E10,
            gadget_id_1_time_created_1: 1.5656927232E10,
            hub_type_1: 5.212393472E9,
            hub_type_1_time_created_1: 1.47602432E10,
            time_created_1: 1.43944704E10
        },
        avgObjSize: 1289.0,
        maxSize: NumberLong(0),
        nindexes: 5,
        nchunks: 25558
    }

以 KB 为单位显示::

    // 默认单位是 bytes，可改成KB
    >  db.posts.stats(1024);

仅查看集合占用空间大小::

    > db.posts.dataSize();



other
=====

查看此DB下慢查询大于5s的::

    db.system.profile.find({millis:{$gt:5000}})




