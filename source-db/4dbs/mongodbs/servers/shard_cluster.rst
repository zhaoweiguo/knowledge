分片实例
########

分片结构端口分布如下::

    Shard Server 1：27020
    Shard Server 2：27021
    Shard Server 3：27022
    Shard Server 4：27023
    Config Server ：27100
    Route Process：40000

启动 Shard Server::

    > mkdir -p /www/mongoDB/shard/s0
    mkdir -p /www/mongoDB/shard/s1
    mkdir -p /www/mongoDB/shard/s2
    mkdir -p /www/mongoDB/shard/s3
    mkdir -p /www/mongoDB/shard/log
    > /usr/local/mongoDB/bin/mongod --port 27020 --dbpath=/www/mongoDB/shard/s0 --logpath=/www/mongoDB/shard/log/s0.log --logappend --fork
    ....
    > /usr/local/mongoDB/bin/mongod --port 27023 --dbpath=/www/mongoDB/shard/s3 --logpath=/www/mongoDB/shard/log/s3.log --logappend --fork

启动 Config Server::

    > mkdir -p /www/mongoDB/shard/config
    > /usr/local/mongoDB/bin/mongod --port 27100 --dbpath=/www/mongoDB/shard/config --logpath=/www/mongoDB/shard/log/config.log --logappend --fork

启动 Route Process::

    > /usr/local/mongoDB/bin/mongos --port 40000 --configdb localhost:27100 --fork --logpath=/www/mongoDB/shard/log/route.log --chunkSize 500
    说明:
    chunkSize: 指定 chunk 的大小的，单位是 MB，默认大小为 200MB.

配置 Sharding::

    1. 使用 MongoDB Shell 登录到 mongos
    2. 添加 Shard 节点
    > /usr/local/mongoDB/bin/mongo admin --port 40000
    MongoDB shell version: 2.0.7
    connecting to: 127.0.0.1:40000/admin
    mongos> db.runCommand({ addshard:"localhost:27020" })
    { "shardAdded" : "shard0000", "ok" : 1 }
    ......
    mongos> db.runCommand({ addshard:"localhost:27029" })
    { "shardAdded" : "shard0009", "ok" : 1 }

    mongos> db.runCommand({ enablesharding:"test" }) #设置分片存储的数据库
    { "ok" : 1 }
    mongos> db.runCommand({ shardcollection: "test.log", key: { id:1,time:1}})
    { "collectionsharded" : "test.log", "ok" : 1 }









