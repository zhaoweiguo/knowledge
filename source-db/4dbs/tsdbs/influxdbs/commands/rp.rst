保留策略Retention Policy(RP)
-----------------------------

是InfluxDB数据架构的一部分，它描述了InfluxDB保存数据的时间。InfluxDB会比较服务器本地的时间戳和请求数据里的时间戳，并删除比你在RPs里面用DURATION设置的更老的数据。一个数据库中可以有多个RPs但是每个数据表的RPs是唯一的。

说明::

    默认InfluxDB是每隔三十分钟check一次RP, 这个check的间隔可以在InfluxDB的配置文件中更改

查询策略::

    >show RETENTION POLICIES ON <DB>
    name    duration   shardGroupDuration replicaN default
    ----    --------   ------------------ -------- -------
    autogen 33600h0m0s 168h0m0s           1        true

    说明:
    name:       名称
    duration:   数据保存时间，0代表无限制
    shardGroupDuration:     shardGroup的存储时间
    replicaN:   副本个数(REPLICATION)
    default:    是否是默认策略

    注:
    创建数据库时会自动创建一个默认存储策略:
        永久保存数据，对应的在此存储策略下的 shard 所保存的数据的时间段为 7 天
    如果创建一个新的 retention policy 设置数据的保留时间为 1 天，则
        单个 shard 所存储数据的时间间隔为 1 小时，超过1个小时的数据会被存放到下一个shard

    Retention Policy’s DURATION         Shard Group Duration
        < 2 days                                1 hour
        >= 2 days and <= 6 months               1 day
        > 6 months                              7 days

创建策略::

    CREATE RETENTION POLICY <retention_policy_name> ON <database_name> 
        DURATION <duration> REPLICATION <n> [SHARD DURATION <duration>] [DEFAULT]

    示例1：为数据库mydb创建一个策略(RP保留数据1天)
    CREATE RETENTION POLICY "one_day_only" ON "mydb" 
        DURATION 1d REPLICATION 1

    示例2：为数据库mydb创建一个默认策略。
    CREATE RETENTION POLICY "one_day_only" ON "mydb" 
        DURATION 23h60m REPLICATION 1 DEFAULT

修改策略::

    ALTER RETENTION POLICY <retention_policy_name> ON <database_name> 
        DURATION <duration> REPLICATION <n> SHARD DURATION <duration> DEFAULT

    实例:
    > CREATE RETENTION POLICY "what_is_time" ON "NOAA_water_database" 
        DURATION 2d REPLICATION 1
    // 修改what_is_time的持续时间为3个星期，shard group的持续时间为30分钟:
    > ALTER RETENTION POLICY "what_is_time" ON "NOAA_water_database" 
        DURATION 3w SHARD DURATION 30m DEFAULT



删除策略::

    DROP RETENTION POLICY <retention_policy_name> ON <database_name>



