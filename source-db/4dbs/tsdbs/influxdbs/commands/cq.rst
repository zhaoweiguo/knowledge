连续查询Continuous Query(CQ)
############################

是在数据库内部自动周期性跑着的一个InfluxQL的查询，CQs需要在SELECT语句中使用一个函数，并且一定包括一个GROUP BY time()语句。

说明::

    在写入之前设置CQs是因为CQ只对最近的数据有效, 即:
    1. 数据的时间戳不会比now()减去CQ的FOR子句的时间早
    2. 或是如果没有FOR子句的话比now()减去GROUP BY time()间隔早

<cq_query>::

    SELECT <function[s]> 
    INTO <destination_measurement> 
    FROM <measurement> 
    [WHERE <stuff>] 
    GROUP BY time(<interval>)[,<tag_key[s]>]

基本语法::

    CREATE CONTINUOUS QUERY <cq_name> ON <database_name>
    BEGIN
      <cq_query>
    END

高级语法::

    CREATE CONTINUOUS QUERY <cq_name> ON <database_name>
    RESAMPLE EVERY <interval> FOR <interval>
    BEGIN
      <cq_query>
    END

    说明:
    CQs对实时数据进行操作。
    使用高级语法，CQ使用本地服务器的时间戳以及RESAMPLE子句中的信息
      和InfluxDB的预设时间边界来确定执行时间和查询中涵盖的时间范围。
    CQs以与RESAMPLE子句中的EVERY间隔相同的间隔执行，并且它们在InfluxDB的预设时间边界开始时运行。
    如果EVERY间隔是两个小时，InfluxDB将在每两小时的开始执行CQ。

    EVERY间隔和FOR间隔都接受时间字符串。
    RESAMPLE子句适用于同时配置EVERY和FOR,或者是其中之一。
    如果没有提供EVERY间隔或FOR间隔，则CQ默认为相关为基本语法。


.. note:: 注意，在WHERE子句中，cq_query不需要时间范围。 InfluxDB在执行CQ时自动生成cq_query的时间范围。cq_query的WHERE子句中的任何用户指定的时间范围将被系统忽略。

创建
====

实例说明(:ref:`实战1实例<influxdb_practice1>`)::

    > CREATE CONTINUOUS QUERY "cq_30m" ON "food_data" 
    BEGIN
      SELECT mean("website") AS "mean_website",mean("phone") AS "mean_phone"
      INTO "a_year"."downsampled_orders"
      FROM "orders"
      GROUP BY time(30m)
    END

    创建了一个叫做cq_30m的CQ作用于food_data数据库上。
    cq_30m告诉InfluxDB每30分钟计算一次
        1. measurement为orders
        2. 并使用默认RPtow_hours的
        3. 字段website和phone的平均值
        4. 然后把结果写入到RP为a_year，
        5. 两个字段分别是mean_website和mean_phone的
        6. measurement名为downsampled_orders的数据中。
        7. InfluxDB会每隔30分钟跑对之前30分钟的数据跑一次这个查询。

实例::

    CREATE CONTINUOUS QUERY "cq_active1month" ON "device" 
        BEGIN
          SELECT mean("website") AS "mean_website",mean("phone") AS "mean_phone"
          INTO "a_year"."downsampled_orders"
          FROM "orders"
          GROUP BY time(30m)
        END

列出CQ
======

列出InfluxDB实例上的所有CQ::

    SHOW CONTINUOUS QUERIES

例子:下面展示了telegraf和mydb的CQ::

    > SHOW CONTINUOUS QUERIES
    name: _internal
    ---------------
    name   query


    name: telegraf
    --------------
    name           query
    idle_hands     CREATE CONTINUOUS QUERY idle_hands ON telegraf BEGIN SELECT min(usage_idle) INTO telegraf.autogen.min_hourly_cpu FROM telegraf.autogen.cpu GROUP BY time(1h) END
    feeling_used   CREATE CONTINUOUS QUERY feeling_used ON telegraf BEGIN SELECT mean(used) INTO downsampled_telegraf.autogen.:MEASUREMENT FROM telegraf.autogen./.*/ GROUP BY time(1h) END

    name: downsampled_telegraf
    --------------------------
    name   query

    name: mydb
    ----------
    name      query
    vampire   CREATE CONTINUOUS QUERY vampire ON mydb BEGIN SELECT count(dracula) INTO mydb.autogen.all_of_them FROM mydb.autogen.one GROUP BY time(5m) END


删除CQ
======

从一个指定的database删除CQ::

    DROP CONTINUOUS QUERY <cq_name> ON <database_name>

    例子: 从数据库telegraf中删除idle_hands这个CQ：
    > DROP CONTINUOUS QUERY "idle_hands" ON "telegraf"`

修改CQ
======

CQ一旦创建就不能修改了，你必须DROP再CREATE才行。


基本语法的实例
==============

* 以下例子使用数据库transportation中的示例数据。
* measurement:bus_data数据存储有关公共汽车乘客数量和投诉数量的15分钟数据::

    name: bus_data
    --------------
    time                   passengers   complaints
    2016-08-28T07:00:00Z   5            9
    2016-08-28T07:15:00Z   8            9
    2016-08-28T07:30:00Z   8            9
    2016-08-28T07:45:00Z   7            9
    2016-08-28T08:00:00Z   8            9
    2016-08-28T07:45:00Z   7            9

例一：自动采样数据::

    CREATE CONTINUOUS QUERY "cq_basic" ON "transportation"
    BEGIN
      SELECT mean("passengers") INTO "average_passengers" 
      FROM "bus_data" GROUP BY time(1h)
    END

例二：自动采样数据到另一个保留策略里::

    CREATE CONTINUOUS QUERY "cq_basic_rp" ON "transportation"
    BEGIN
      SELECT mean("passengers") INTO "transportation"."three_weeks"."average_passengers" 
      FROM "bus_data" GROUP BY time(1h)
    END

例三：使用逆向引用自动采样数据::

    // 计算数据库transportation中每个measurement的30分钟平均乘客和投诉。
    // 它将结果存储在数据库downsampled_transportation中。
    CREATE CONTINUOUS QUERY "cq_basic_br" ON "transportation"
    BEGIN
      SELECT mean(*) INTO "downsampled_transportation"."autogen".:MEASUREMENT 
      FROM /.*/ GROUP BY time(30m),*
    END


    > SELECT * FROM "downsampled_transportation."autogen"."bus_data"
    name: bus_data
    --------------
    time                   mean_complaints   mean_passengers
    2016-08-28T07:00:00Z   9                 6.5
    2016-08-28T07:30:00Z   9                 7.5

例四：自动采样数据并配置CQ的时间边界::

    # 使用GROUP BY time()子句的偏移间隔来改变CQ的默认执行时间和呈现的时间边界：
    CREATE CONTINUOUS QUERY "cq_basic_offset" ON "transportation"
    BEGIN
      SELECT mean("passengers") INTO "average_passengers" 
      FROM "bus_data" GROUP BY time(1h,15m)
    END

    说明:
    15分钟偏移间隔迫使CQ在默认执行时间后15分钟执行; cq_basic_offset在8:15而不是8:00执行
    在8:15cq_basic_offset执行时间范围time> ='7:15'AND time <'8:15'的查询

    > SELECT * FROM "average_passengers"
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T07:15:00Z   7.75
    2016-08-28T08:15:00Z   16.75

基本语法的常见问题
==================

.. note:: 基本语法不支持使用fill()更改不含数据的间隔报告的值。如果基本语法CQs包括了fill()，则会忽略fill()。默认情况下，所有INTO查询将源measurement中的任何tag转换为目标measurement中的field

在CQ中包含GROUP BY，以保留目的measurement中的tag，如::

    SELECT mean(*) INTO "downsampled_transportation"."autogen".:MEASUREMENT 
      FROM /.*/ GROUP BY time(30m),*

高级语法例子
============

示例数据如下::

    name: bus_data
    --------------
    time                   passengers
    2016-08-28T06:30:00Z   2
    2016-08-28T06:45:00Z   4
    2016-08-28T07:00:00Z   5
    2016-08-28T07:15:00Z   8
    2016-08-28T07:30:00Z   8
    2016-08-28T07:45:00Z   7
    2016-08-28T08:00:00Z   8
    2016-08-28T08:15:00Z   15
    2016-08-28T08:30:00Z   15
    2016-08-28T08:45:00Z   17
    2016-08-28T09:00:00Z   20

例一：配置执行间隔::

    CREATE CONTINUOUS QUERY "cq_advanced_every" ON "transportation"
    RESAMPLE EVERY 30m
    BEGIN
      SELECT mean("passengers") INTO "average_passengers" 
      FROM "bus_data" GROUP BY time(1h)
    END

    1. 在8:00cq_basic_every执行时间范围time> ='7:00'AND time <'8:00':
    time                   mean
    2016-08-28T07:00:00Z   7

    2. 在8:30cq_basic_every执行时间范围time> ='8:00'AND time <'9:00':
    time                   mean
    2016-08-28T08:00:00Z   12.6667

    3. 在9:00cq_basic_every执行时间范围time> ='8:00'AND time <'9:00'
    time                   mean
    2016-08-28T08:00:00Z   13.75

    最终结果为:
    > SELECT * FROM "average_passengers"
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T07:00:00Z   7
    2016-08-28T08:00:00Z   13.75

    说明: 每半小时执行一次, 每次算的时间段是1小时。
    如:cq_advanced_every计算8:00时间间隔的结果两次。
    第一次，它运行在8:30，计算每个可用数据点在8:00和9:00（8,15和15）之间的平均值。(8点45的数据还没生成)
      time                   mean
      2016-08-28T08:00:00Z   12.6667
    第二次，它运行在9:00，计算每个可用数据点在8:00和9:00（8,15,15和17）之间的平均值。
      time                   mean
      2016-08-28T08:00:00Z   13.75
    由于InfluxDB处理重复点的方式，所以第二个结果只是覆盖第一个结果。

例二：配置CQ的重采样时间范围::

    # 在RESAMPLE中使用FOR来指明CQ的时间间隔的长度。
    CREATE CONTINUOUS QUERY "cq_advanced_for" ON "transportation"
    RESAMPLE FOR 1h
    BEGIN
      SELECT mean("passengers") INTO "average_passengers" 
      FROM "bus_data" GROUP BY time(30m)
    END

    1. 在8:00cq_advanced_for执行时间范围time> ='7:00'AND time <'8:00':
    time                   mean
    2016-08-28T07:00:00Z   6.5
    2016-08-28T07:30:00Z   7.5

    2. 在8:30cq_advanced_for执行时间范围time> ='7:30'AND time <'8:30:
    time                   mean
    2016-08-28T07:30:00Z   7.5
    2016-08-28T08:00:00Z   11.5

    3. 在9:00cq_advanced_for执行时间范围time> ='8:00'AND time <'9:00':
    time                   mean
    2016-08-28T08:00:00Z   11.5
    2016-08-28T08:30:00Z   16

    最终结果为:
    > SELECT * FROM "average_passengers"
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T07:00:00Z   6.5
    2016-08-28T07:30:00Z   7.5
    2016-08-28T08:00:00Z   11.5
    2016-08-28T08:30:00Z   16

例三：配置执行间隔和CQ时间范围::

    CREATE CONTINUOUS QUERY "cq_advanced_every_for" ON "transportation"
    RESAMPLE EVERY 1h FOR 90m
    BEGIN
      SELECT mean("passengers") INTO "average_passengers" 
      FROM "bus_data" GROUP BY time(30m)
    END

    以1小时的间隔执行一次(由EVERY决定)
    覆盖时间段为now()和now()-90m(由FOR决定时间间隔)

    1. 在8:00cq_advanced_every_for执行时间范围time>='6:30'AND time <'8:00':
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T06:30:00Z   3
    2016-08-28T07:00:00Z   6.5
    2016-08-28T07:30:00Z   7.5
    2. 在9:00cq_advanced_every_for执行时间范围time> ='7:30'AND time <'9:00'
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T07:30:00Z   7.5
    2016-08-28T08:00:00Z   11.5
    2016-08-28T08:30:00Z   16

    最终结果为:
    > SELECT * FROM "average_passengers"
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T06:30:00Z   3
    2016-08-28T07:00:00Z   6.5
    2016-08-28T07:30:00Z   7.5
    2016-08-28T08:00:00Z   11.5
    2016-08-28T08:30:00Z   16

例四：配置CQ的时间范围并填充空值::

    使用FOR间隔和fill()来更改不含数据的时间间隔值

    请注意，至少有一个数据点必须在fill()运行的FOR间隔内。 
    如果没有数据落在FOR间隔内，则CQ不会将任何点写入目标measurement

    // 在没有结果的时间间隔里写入值1000
    CREATE CONTINUOUS QUERY "cq_advanced_for_fill" ON "transportation"
    RESAMPLE FOR 2h
    BEGIN
      SELECT mean("passengers") INTO "average_passengers" 
      FROM "bus_data" GROUP BY time(1h) fill(1000)
    END

    1. 在6:00cq_advanced_for_fill执行时间范围time>='4:00'AND time <'6:00'
       # 不写入任何点，因为在那个时间范围bus_data没有数据
    2. 在7:00cq_advanced_for_fill执行时间范围time>='5:00'AND time <'7:00'
        name: average_passengers
        ------------------------
        time                   mean
        2016-08-28T05:00:00Z   1000          <------ fill(1000)
        2016-08-28T06:00:00Z   3             <------ 2和4的平均值
    3. ...
    4. 在11:00cq_advanced_for_fill执行时间范围time> ='9:00'AND time <'11:00'
        name: average_passengers
        ------------------------
        2016-08-28T09:00:00Z   20            <------ 20的平均
        2016-08-28T10:00:00Z   1000          <------ fill(1000)
    5. 在12:00cq_advanced_for_fill执行时间范围time>='10:00'AND time <'12:00'
        向average_passengers不写入任何点，因为在那个时间范围bus_data没有数据.

    最终结果为:
    > SELECT * FROM "average_passengers"
    name: average_passengers
    ------------------------
    time                   mean
    2016-08-28T05:00:00Z   1000
    2016-08-28T06:00:00Z   3
    2016-08-28T07:00:00Z   7
    2016-08-28T08:00:00Z   13.75
    2016-08-28T09:00:00Z   20
    2016-08-28T10:00:00Z   1000

高级语法的常见问题
==================

问题一：如果EVERY间隔大于GROUP BY time()的间隔::

    不影响, 即:
    如果GROUP BY time()间隔为5m，并且EVERY间隔为10m
    则:
    CQ每10分钟执行一次
    now()和now()减去EVERY间隔之间的时间段

问题二：如果FOR间隔比执行的间隔少::

    InfluxDB返回如下错误:
    error parsing query: FOR duration must be >= GROUP BY time duration: 
      must be a minimum of <minimum-allowable-interval> got <user-specified-interval>
    为了避免在执行时间之间丢失数据，FOR间隔必须等于或大于GROUP BY time()或者EVERY间隔

CQ的使用场景
============

采样和数据保留::

    使用CQ与InfluxDB的保留策略（RP）来减轻存储问题。
    结合CQ和RP自动将高精度数据降低到较低的精度，并从数据库中移除可分配的高精度数据。

预先计算昂贵的查询::

    通过使用CQ预先计算昂贵的查询来缩短查询运行时间。
    提示：预先计算首选图形工具的查询，以加速图形和仪表板的展示。

替换HAVING子句::

    InfluxQL不支持HAVING子句。通过创建CQ来聚合数据并查询CQ结果以达到应用HAVING子句相同的功能。
    注意：InfluxDB提供了子查询也可以达到类似于HAVING相同的功能。

    如: 想达到下面这种效果
    SELECT mean("bees") FROM "farm" GROUP BY time(30m) HAVING mean("bees") > 20

    1. 创建一个CQ
      CREATE CONTINUOUS QUERY "bee_cq" ON "mydb" 
      BEGIN 
        SELECT mean("bees") AS "mean_bees" INTO "aggregate_bees" 
        FROM "farm" GROUP BY time(30m) 
      END
    2. 查询CQ的结果
      SELECT "mean_bees" FROM "aggregate_bees" WHERE "mean_bees" > 20

替换嵌套函数::

    InfluxDB不接受使用嵌套函数的以下查询

    如: 想达到下面这种效果
    SELECT mean(count("bees")) FROM "farm" GROUP BY time(30m)

    1. 创建一个CQ
      CREATE CONTINUOUS QUERY "bee_cq" ON "mydb" 
      BEGIN 
          SELECT count("bees") AS "count_bees" INTO "aggregate_bees" 
          FROM "farm" GROUP BY time(30m) 
      END
    2. 查询CQ的结果
      SELECT mean("count_bees") FROM "aggregate_bees" 
      WHERE time >= <start_time> AND time <= <end_time>









