基本命令
########


查看集合是否分片 [1]_
=====================

1. 去config库中查询::
   
    db.collections.find({$and:
        [
        {'dropped':{$ne:true}},  // 没有被删除的
         {'name':'/dbname/'}]  // 根据数据库名进行模糊查询
    })

2. 查看数据分布::

    use dbname
    db.colname.getShardDistribution() #可以查看数据分布

3. 最简单的方法::

    use databaseName;
    db.collectionName.stats().sharded #简单的返回true或者false

修改指定表为分片表
==================

实例::

    use <db>;
    db.wei64_scale_data_info.createIndex({"_id":"hashed"});

    use admin;
    db.runCommand({"shardcollection":"<db>.wei64_scale_data_info","key":{"_id" : "hashed"}});

    // 查看
    use <db>;
    db.wei64_scale_data_info.getShardDistribution();



基本
====

配置分片集群::

    sh.addShard("rep_shard1/10.0.4.6:27018,10.0.4.7:27018,10.0.4.8:27018")
    sh.addShard("rep_shard2/10.0.4.6:27019,10.0.4.7:27019,10.0.4.8:27019")

验证分片集群是否搭建成功::

    > sh.status() 
    shards:
    {  "_id" : "rep_shard1",  "host" : "rep_shard1/10.0.4.6:27018,10.0.4.7:27018,10.0.4.8:27018",  "state" : 1 }
    {  "_id" : "rep_shard2",  "host" : "rep_shard2/10.0.4.6:27019,10.0.4.7:27019,10.0.4.8:27019",  "state" : 1 }

将均衡器的迁移 chunk 时间控制在凌晨 02 点至凌晨 06 点::

    use config
    db.settings.update(
       { _id: "balancer" },
       { $set: { activeWindow : { start : "02:00", stop : "06:00" } } },
       { upsert: true }
    )

将 chunk 的大小调整为 1MB::

    > use config
    > db.settings.save({_id:"chunksize",value:1})
    > db.serverStatus().sharding
    {
        "configsvrConnectionString" : "confsvr/10.0.4.6:20000,10.0.4.7:20000,10.0.4.8:20000",
        "lastSeenConfigServerOpTime" : {
            "ts" : Timestamp(1566895485, 2),
            "t" : NumberLong(16)
        },
        "maxChunkSizeInBytes" : NumberLong(1048576)
    }

基于 Ranged 分片
================

开启 test 库的分片功能::

    > sh.enableSharding("test")

对指定集合分片::

    // MongoDB 会自动为 age 字段创建索引
    > sh.shardCollection("test.test_shard",{"age": 1})

观察分片效果::

    > sh.status()
    test.test_shard
    shard key: { "age" : 1 }
    unique: false
    balancing: true
    chunks:
            rep_shard1    2
            rep_shard2    3
    { "age" : { "$minKey" : 1 } } --<< { "age" : 0 } on : rep_shard1 Timestamp(2, 0)
    { "age" : 0 } --<< { "age" : 36 } on : rep_shard1 Timestamp(3, 0)
    { "age" : 36 } --<< { "age" : 73 } on : rep_shard2 Timestamp(2, 3)
    { "age" : 73 } --<< { "age" : 92 } on : rep_shard2 Timestamp(2, 4)
    { "age" : 92 } --<< { "age" : { "$maxKey" : 1 } } on : rep_shard2 Timestamp(3, 1)

    说明:
    test.test_shard 集合总共有 2 个分片
    分片 rep_shard1 上有 2 个 chunk，分片 rep_shard2 上有 3 个 chunk

    年龄大于或等于 0 并且小于 36 的文档数据放到了第一个分片 rep_shard1
    年龄大于或等于 36 并且小于 73 的文档数据放到了第二个分片 rep_shard2
    此时已经达到了分片的效果

使用 find 命令来确认是否对应的数据存在相应的分片::

    > db.test_shard.find({ age: { $gte : 36 ,$lt : 73 } }).explain()
    {
        "queryPlanner" : {
            "winningPlan" : {
                "stage" : "SINGLE_SHARD",
                "shards" : [
                    {
                        "shardName" : "rep_shard2",
                        "connectionString" : "rep_shard2/10.0.4.6:27019,10.0.4.7:27019,10.0.4.8:27019",
                        "namespace" : "test.test_shard",
                        "winningPlan" : {
                            "stage" : "FETCH",
                            "inputStage" : {
                                "stage" : "SHARDING_FILTER",
                                "inputStage" : {
                                    "stage" : "IXSCAN",
                                    "keyPattern" : {
                                        "age" : 1
                                    },
                                    "indexName" : "age_1",
                                    "direction" : "forward",
                                    "indexBounds" : {
                                        "age" : [
                                            "[36.0, 73.0)"
                                        ]
                                    }
                                }
                            }
                        },
                    }
                ]
            }
        }
    }

    说明:
    当查找年龄范围为大于等于 36 并且小于 73 的文档数据
    MongoDB 会直接定位到分片 rep_shard2，从而避免全分片扫描以提高查找效率

    扩展:
    如果将 $gte : 36 改为 $gte : 35 
    MongoDB 会扫描全部分片
    执行计划的结果将由 SINGLE_SHARD 变为 SHARD_MERGE


基于 Hashed 分片
================

创建的是 hash 索引分片::

    sh.shardCollection("test.test_shard",{"age": "hashed"})


观察分片效果::

    > sh.status()
    chunks:
            rep_shard1    2
            rep_shard2    2
    { "age" : { "$minKey" : 1 } } --<< { "age" : NumberLong("-4611686018427387902") } on : rep_shard1 Timestamp(1, 0)
    { "age" : NumberLong("-4611686018427387902") } --<< { "age" : NumberLong(0) } on : rep_shard1 Timestamp(1, 1)
    { "age" : NumberLong(0) } --<< { "age" : NumberLong("4611686018427387902") } on : rep_shard2 Timestamp(1, 2)
    { "age" : NumberLong("4611686018427387902") } --<< { "age" : { "$maxKey" : 1 } } on : rep_shard2 Timestamp(1, 3)

    说明:
    总共有 4 个 chunk，分片 rep_shard1 有 2 个 chunk，分片 rep_shard2 有 2 个 chunk
    分片后按照分片值 hash 后，存放到对应不同的分片


explain分析::

    > db.test_shard.find({ age: { $gte : 36 ,$lt : 73 } }).explain()
    {
      "queryPlanner" : {
        "winningPlan" : {
          "stage" : "SHARD_MERGE",
          "shards" : [
            {
              "shardName" : "rep_shard1",
              "connectionString" : "rep_shard1/10.0.4.6:27018,10.0.4.7:27018,10.0.4.8:27018",
              "winningPlan" : {
                "stage" : "SHARDING_FILTER",
                "inputStage" : {
                  "stage" : "COLLSCAN",
                }
              }
            },
            {
              "shardName" : "rep_shard2",
              "connectionString" : "rep_shard2/10.0.4.6:27019,10.0.4.7:27019,10.0.4.8:27019",
              "winningPlan" : {
                "stage" : "SHARDING_FILTER",
                "inputStage" : {
                  "stage" : "COLLSCAN",
                }
              }
            }
          ]
        }
      }
    }

    结论:
    对于范围查找，基于 Hashed 的分片很可能需要全部分片都扫描一遍才能找到对应的数据，效率比较低下
    如果等值查找，基于 Hashed 分片查找效率很高，直接定位到一个分片就可以返回满足条件的数据，无需进行全部分片的查找


查看主从关系::

    > rs.isMaster()










.. [1] https://blog.csdn.net/zhanaolu4821/article/details/88198905