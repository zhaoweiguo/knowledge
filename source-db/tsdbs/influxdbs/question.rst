常见问题 [1]_
################

partial write: points beyond retention policy dropped=1
----------------------------------------------------------------

如:
存储2天前的数据，存储策略存储1天

时区问题
--------

说明::

    influx的时间是utc时间,但查询要用当地时区

解决::

    // 增加选项: TZ('Asia/Beijing')
    如:
    influx -precision rfc3339 -execute="
      SELECT count(*) FROM "win_cpu"
      WHERE (time >= now() - 15d)
      GROUP BY IP,host TZ('Asia/Beijing')"  // 指定东八区
      -database=telegraf -format=csv

* 参考: https://github.com/influxdata/influxdb/issues/14137

GROUP BY(1w)按周查询问题
------------------------

* 默认是从周四开始(即周四为第1天)
* 如果想从周一开始则使用 ``GROUP BY time(7d, 4d)`` or ``GROUP BY time(1w, 4d)`` or ``GROUP BY time(1w, -3d)``
* 如果想从周三开始则使用 ``GROUP BY time(1w, 6d)`` or ``GROUP BY time(1w, -1d)``
* 本质就是从周四到周x有几天(为正), 周x到周四有几天(为负)

* 参考1: https://github.com/influxdata/influxdb/issues/9130
* 参考2: https://github.com/influxdata/influxdb/issues/7594
* https://docs.influxdata.com/influxdb/v1.0/query_language/data_exploration/#advanced-group-by-time-syntax

GROUP BY(1M)按月查询问题
------------------------

* 未解决: https://github.com/influxdata/influxdb/issues/3991


查询返回结果为空的问题
----------------------

1. 在SELECT语句中只查询tag没有数据::
   
    一个查询在SELECT子句中至少需要一个field key来返回数据。
    如果SELECT子句仅包含单个tag key或多个tag key，则查询返回一个空的结果。
    SELECT子句中必须至少有一个field。

2. 无引号或双引号tag value或field value的查询将不会返回任何数据，并且在大多数情况下不会返回错误::
    
    > SELECT "water_level" FROM "h2o_feet" WHERE "location" = santa_monica
    > SELECT "water_level" FROM "h2o_feet" WHERE "location" = "santa_monica"
    > SELECT "water_level" FROM "h2o_feet" WHERE "location" = 'santa_monica'
    说明:
      前2条都无数据，第3条正常返回
      注意: where的值一定要是单引号

INTO子句的共同问题
------------------

1. 问题一：丢数据::
    
    INTO查询在SELECT子句中包含tag key，则查询将当前measurement中的tag转换为目标measurement中的字段
    这可能会导致InfluxDB覆盖以前由tag value区分的点

    注: 要将当前measurement的tag保留在目标measurement中的tag中
      GROUP BY相关tag key或INTO查询中的GROUP BY *

为啥是从周四开始
----------------

为啥不从周一或周日开始::

    So why not start from Monday or Sunday?
    Is there any special reason?

    It's because the epoch was a Thursday (1 January 1970). 
    Influx only cares about epoch (a.k.a. unix) time. Which is also why you can't group by month.










.. [1] https://docs.influxdata.com/influxdb/v1.7/troubleshooting/errors
