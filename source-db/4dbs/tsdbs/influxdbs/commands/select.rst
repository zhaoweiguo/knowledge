查询
####

语法::

    SELECT <field_key>[,<field_key>,<tag_key>] 
    FROM <measurement_name>[,<measurement_name>]


最简单的::

    # 查看自定度量的数据, 里面的相关字段，官方建议使用“双引号”标注出来
    select * from "CPU" order by time desc

    # 查看指定的Field和Tag
    select "load1","role" from "CPU" order by time desc

    # 只查看Field
    select *::field from "CPU" 

    # 执行基本的运算
    select ("load1" * 2) + 0.5 from "CPU"

    # 查询指定Tag的数据，注意，Where子句的字符串值要使用“单引号”，字符串值
    # 如果没有使用引号或者使用了双引号，都不会有任何值的返回
    注: 一定要使用单引号
    select * from "CPU" where role = 'FrontServer'

    # 查询Field中，load1 > 20 的所有数据
    select * from "CPU" where "load1" > 20

使用非默认RP::

    只要不是使用默认的RP我们就需要指定RP
    注:这儿measurement为downsampled_orders的rp名为rp_year
    > SELECT * FROM "rp_year"."downsampled_orders" LIMIT 5

执行基本计算::

    // SELECT语句支持使用基本的数学运算符，例如，+、-、/、*和()等等。
    SELECT field_key1 + field_key2 AS "field_key_sum" 
      FROM "measurement_name" WHERE time < now() - 15m
    SELECT (key1 + key2) - (key3 + key4) AS "some_calculation" 
      FROM "measurement_name" WHERE time < now() - 15m

提供其标识符类型::

    > SELECT "level description"::field,"location"::tag,"water_level"::field 
        FROM "h2o_feet"
    // 查询所有field
    > SELECT *::field FROM "h2o_feet"

从多个measurement中查询数据::

    > SELECT * FROM "h2o_feet","h2o_pH"

指定DB::

    > SELECT * FROM "NOAA_water_database"."autogen"."h2o_feet"
    // 从特定数据库中查询measurement的所有数据



GroupBy
=======

语法::

    SELECT_clause FROM_clause [WHERE_clause] GROUP BY [* | <tag_key>[,<tag_key]]
    实例说明:
    1. 对结果中的所有tag作group by
       GROUP BY *
    2. 对结果按指定的tag作group by
        GROUP BY <tag_key>
    3. 对结果数据按多个tag作group by，其中tag key的顺序没所谓
        GROUP BY <tag_key>,<tag_key>

GroupBy指定时区::

    influx -precision rfc3339 -execute="
        SELECT count(*) FROM "win_cpu" 
        WHERE (time >= now() - 15d) 
        GROUP BY IP,host,customer TZ('Asia/Beijing')"  // 指定东八区
        -database=telegraf -format=csv

使用Group计算百分比::

    SELECT (sum(field_key1) / sum(field_key2)) * 100 AS "calculated_percentage" 
      FROM "measurement_name" WHERE time < now() - 15m GROUP BY time(1m)
    SELECT count(value) FROM devices where time > '2019-08-29T00:00:00Z' 
        group by gadget_type_id, time(1d)

时间相关查询::

    > SELECT count(value) FROM devices 
        where time > '2019-08-26T00:00:00Z' group by time(1d)
    > SELECT count(value) FROM devices 
        where time > now() - 10w group by time(1w)

时间偏移offset::

    > SELECT MEAN("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-08-18T00:06:00Z' AND time <= '2015-08-18T00:54:00Z' 
    GROUP BY time(18m, 6m)
    
    带offset为6m的主要是下面3个时间段:
    time >= 00:06:00Z AND time < 00:24:00Z    
    time >= 00:24:00Z AND time < 00:42:00Z    
    time >= 00:42:00Z AND time < 01:00:00Z    

    不带offset的包括下面4个时间段:
    time >= 00:06:00Z AND time < 00:18:00Z    
    time >= 00:18:00Z AND time < 00:36:00Z    
    time >= 00:36:00Z AND time < 00:54:00Z    
    time = 00:54:00Z 

fill()
======

说明: fill()更改不含数据的时间间隔的返回值::

    fill的参数:
    1. 任一数值：用这个数字返回没有数据点的时间间隔
    2. linear：返回没有数据的时间间隔的线性插值结果。
    3. none: 不返回在时间间隔里没有点的数据
    4. previous：返回时间隔间的前一个间隔的数据

例一：fill(100)::

    1. 不带fill(100):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235
    2015-09-18T16:36:00Z

    2. 带fill(100):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m) fill(100)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235
    2015-09-18T16:36:00Z   100

例二：fill(linear)::

    1. 不带fill(linear):
    > SELECT MEAN("tadpoles") FROM "pond" 
    WHERE time >= '2016-11-11T21:00:00Z' AND time <= '2016-11-11T22:06:00Z' 
    GROUP BY time(12m)
    结果:
    name: pond
    time                   mean
    ----                   ----
    2016-11-11T21:00:00Z   1
    2016-11-11T21:12:00Z
    2016-11-11T21:24:00Z   3
    2016-11-11T21:36:00Z
    2016-11-11T21:48:00Z
    2016-11-11T22:00:00Z   6

    2. 带fill(linear):
    > SELECT MEAN("tadpoles") FROM "pond" 
    WHERE time >= '2016-11-11T21:00:00Z' AND time <= '2016-11-11T22:06:00Z' 
    GROUP BY time(12m) fill(linear)
    结果:
    name: pond
    time                   mean
    ----                   ----
    2016-11-11T21:00:00Z   1
    2016-11-11T21:12:00Z   2
    2016-11-11T21:24:00Z   3
    2016-11-11T21:36:00Z   4
    2016-11-11T21:48:00Z   5
    2016-11-11T22:00:00Z   6

例三：fill(none)::

    1. 不带fill(none):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235
    2015-09-18T16:36:00Z

    2. 带fill(none):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m) fill(none)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235

例四：fill(null)::

    1. 不带fill(null):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235
    2015-09-18T16:36:00Z

    2. 带fill(null):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m) fill(null)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235
    2015-09-18T16:36:00Z

例五：fill(previous)::

    1. 不带fill(previous):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235
    2015-09-18T16:36:00Z

    2. 带fill(previous):
    > SELECT MAX("water_level") FROM "h2o_feet" 
    WHERE time >= '2015-09-18T16:00:00Z' AND time <= '2015-09-18T16:42:00Z' 
    GROUP BY time(12m) fill(previous)
    结果:
    name: h2o_feet
    --------------
    time                   max
    2015-09-18T16:00:00Z   3.599
    2015-09-18T16:12:00Z   3.402
    2015-09-18T16:24:00Z   3.235
    2015-09-18T16:36:00Z   3.235



复杂查询实例
============

其他::

    // 多个AND
    SELECT * from (_INNER_QUERY_HERE_) 
    WHERE count_linux = -1 AND count_linux64 = -1 AND count_mac = -1 
        AND count_win = -1 AND count_win64 = -1;

    // 多个OR
    SELECT * from (_INNER_QUERY_HERE_) 
    WHERE count_linux = -1 OR count_linux64 = -1 OR count_mac = -1 
        OR count_win = -1 OR count_win64 = -1;

    // And加Or
    > SELECT "water_level" FROM "h2o_feet" 
        WHERE "location" <> 'santa_monica' AND (water_level < -0.59 OR water_level > 9.95)

ORDER BY TIME DESC
==================

默认情况下，InfluxDB以升序的顺序返回结果; 返回的第一个点具有最早的时间戳, ORDER BY time DESC反转该顺序

实例::

    > SELECT "water_level" FROM "h2o_feet" 
        WHERE "location" = 'santa_monica' 
        ORDER BY time DESC

    > SELECT MEAN("water_level") FROM "h2o_feet" 
        WHERE time >= '2015-08-18T00:00:00Z' AND time <= '2015-08-18T00:42:00Z'
        GROUP BY time(12m) ORDER BY time DESC

Time Zone子句
=============

例一：返回从UTC偏移到芝加哥时区的数据::

    > SELECT "water_level" FROM "h2o_feet" 
    WHERE time >= '2015-08-18T00:00:00Z' AND time <= '2015-08-18T00:18:00Z' tz('America/Chicago')

    name: h2o_feet
    time                       water_level
    ----                       -----------
    2015-08-17T19:00:00-05:00  2.064
    2015-08-17T19:06:00-05:00  2.116
    2015-08-17T19:12:00-05:00  2.028
    2015-08-17T19:18:00-05:00  2.126

rfc3399时间字符串::

    'YYYY-MM-DDTHH:MM:SS.nnnnnnnnnZ'    // .nnnnnnnnn是可选的，如果没有的话，默认是.00000000

正则表达式
==========

例一：在SELECT中使用正则表达式指定field key和tag key::

    > SELECT /l/ FROM "h2o_feet" LIMIT 1

    name: h2o_feet
    time                   level description      location       water_level
    ----                   -----------------      --------       -----------
    2015-08-18T00:00:00Z   between 6 and 9 feet   coyote_creek   8.12

例二：在SELECT中使用正则表达式指定函数里面的field key::

    > SELECT DISTINCT(/level/) FROM "h2o_feet" 
    WHERE time >= '2015-08-18T00:00:00.000000000Z' AND time <= '2015-08-18T00:12:00Z'

    name: h2o_feet
    time                   distinct_level description   distinct_water_level
    ----                   --------------------------   --------------------
    2015-08-18T00:00:00Z   below 3 feet                 2.064
    2015-08-18T00:00:00Z                                2.116
    2015-08-18T00:00:00Z                                2.028

例三：在FROM中使用正则表达式指定measurement::

    > SELECT MEAN("degrees") FROM /temperature/
    name: average_temperature
    time            mean
    ----            ----
    1970-01-01T00:00:00Z   79.98472932232272

    name: h2o_temperature
    time            mean
    ----            ----
    1970-01-01T00:00:00Z   64.98872722506226

例四：在WHERE中使用正则表达式指定tag value::

    // location的tag value包括m并且water_level大于3
    > SELECT MEAN(water_level) FROM "h2o_feet" 
    WHERE "location" =~ /[m]/ AND "water_level" > 3

    name: h2o_feet
    time                   mean
    ----                   ----
    1970-01-01T00:00:00Z   4.47155532049926

例五：在WHERE中使用正则表达式指定无值的tag::

    > SELECT * FROM "h2o_feet" WHERE "location" !~ /./

例六：在WHERE中使用正则表达式指定有值的tag::

    > SELECT MEAN("water_level") FROM "h2o_feet" WHERE "location" =~ /./

    name: h2o_feet
    time                   mean
    ----                   ----
    1970-01-01T00:00:00Z   4.442107025822523

例七：在WHERE中使用正则表达式指定一个field value::

    > SELECT MEAN("water_level") FROM "h2o_feet" 
    WHERE "location" = 'santa_monica' AND "level description" =~ /between/

    name: h2o_feet
    time                   mean
    ----                   ----
    1970-01-01T00:00:00Z   4.47155532049926














