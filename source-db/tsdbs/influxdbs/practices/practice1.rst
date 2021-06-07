.. _influxdb_practice1:

实战1
#####

InfluxDB每秒可以处理数十万的数据点。如果要长时间地存储大量的数据，对于存储会是很大的压力。一个很自然的方式就是对数据进行采样，对于高精度的裸数据存储较短的时间，而对于低精度的的数据可以保存得久一些甚至永久保存。

表结构::

    数据库为food_data
    measurement为orders
    fields分别为phone和website

    实例:
    name: orders
    ------------
    time                   phone     website
    2016-05-10T23:18:00Z     10        30
    2016-05-10T23:18:10Z     12        39
    2016-05-10T23:18:20Z     11        56

目标::

    假定在长时间的运行中，我们只关心每三十分钟通过手机和网站订购的平均数量:
    1. 自动将十秒间隔数据聚合到30分钟的间隔数据
    2. 自动删除两个小时以上的原始10秒间隔数据
    3. 自动删除超过52周的30分钟间隔数据

步骤::

    1. 创建数据库
    > CREATE DATABASE "food_data"
    2. 创建一个两个小时的默认RP
    > CREATE RETENTION POLICY "two_hours" ON "food_data" DURATION 2h REPLICATION 1 DEFAULT
    3. 创建一个保留52周数据的RP
    > CREATE RETENTION POLICY "a_year" ON "food_data" DURATION 52w REPLICATION 1
    4. 创建CQ
    > CREATE CONTINUOUS QUERY "cq_30m" ON "food_data" 
    BEGIN
      SELECT mean("website") AS "mean_website",mean("phone") AS "mean_phone"
      INTO "a_year"."downsampled_orders"
      FROM "orders"
      GROUP BY time(30m)
    END

结果::

    > SELECT * FROM "orders" LIMIT 5
    name: orders
    ---------
    time                            phone  website
    2016-05-13T23:00:00Z      10     30
    2016-05-13T23:00:10Z      12     39
    2016-05-13T23:00:20Z      11     56
    2016-05-13T23:00:30Z      8      34
    2016-05-13T23:00:40Z      17     32

    > SELECT * FROM "a_year"."downsampled_orders" LIMIT 5
    name: downsampled_orders
    ---------------------
    time                            mean_phone  mean_website
    2016-05-13T15:00:00Z      12          23
    2016-05-13T15:30:00Z      13          32
    2016-05-13T16:00:00Z      19          21
    2016-05-13T16:30:00Z      3           26
    2016-05-13T17:00:00Z      4           23

结论::

    使用RPs和CQs的组合，我们已经成功地创建的数据库并保存高精度的裸数据较短的时间，而保存高精度的数据更长时间
    现在我们对这些特性的工作有了大概的了解，我们推荐到CQs和RPs去看更详细的文档。

