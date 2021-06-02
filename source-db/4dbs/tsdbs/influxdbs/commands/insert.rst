插入
####

::

    INSERT weather,location=us-midwest temperature=82 1465839830100400200

    SELECT mean("website") AS "mean_website",mean("phone") AS "mean_phone"
          INTO "a_year"."downsampled_orders"


    select gadget_id as gadget_id, value as value FROM device_active_day 
    where time > now() -4d into abc

INTO子句
========

语法::

    SELECT_clause INTO <measurement_name> FROM_clause [WHERE_clause] [GROUP_BY_clause]


例一：重命名数据库::

    tag将作为field存储在目标数据库(NewDB)
    > SELECT * INTO "NewDB"."autogen".:MEASUREMENT 
    FROM "DB"."autogen"./.*/ GROUP BY *

    当移动大量数据时，我们建议在WHERE子句中顺序运行不同measurement的INTO查询并使用时间边界。
    这样可以防止系统内存不足。下面的代码块提供了这些查询的示例语法
    SELECT * 
    INTO <destination_database>.<retention_policy_name>.<measurement_name> 
    FROM <source_database>.<retention_policy_name>.<measurement_name>
    WHERE time > now() - 100w and time < now() - 90w GROUP BY *

    SELECT * 
    INTO <destination_database>.<retention_policy_name>.<measurement_name> 
    FROM <source_database>.<retention_policy_name>.<measurement_name>} 
    WHERE time > now() - 90w  and time < now() - 80w GROUP BY *

    SELECT * 
    INTO <destination_database>.<retention_policy_name>.<measurement_name> 
    FROM <source_database>.<retention_policy_name>.<measurement_name>
    WHERE time > now() - 80w  and time < now() - 70w GROUP BY *

例二：将查询结果写入到一个measurement::

    > SELECT "water_level" INTO "h2o_feet_copy_1" FROM "h2o_feet" 
    WHERE "location" = 'coyote_creek'


例三：将查询结果写入到一个完全指定的measurement中::


    > SELECT "water_level" INTO "where_else"."autogen"."h2o_feet_copy_2" 
    FROM "h2o_feet" WHERE "location" = 'coyote_creek'

例四：将聚合结果写入到一个measurement中(采样)::

    > SELECT MEAN("water_level") INTO "all_my_averages" FROM "h2o_feet" 
    WHERE time >= '2015-08-18T00:00:00Z' AND time <= '2015-08-18T00:30:00Z' 
    GROUP BY time(12m)

例五：将多个measurement的聚合结果写入到一个不同的数据库中(逆向引用采样)::

    > SELECT MEAN(*) INTO "where_else"."autogen".:MEASUREMENT FROM /.*/ 
    WHERE time >= '2015-08-18T00:00:00Z' AND time <= '2015-08-18T00:06:00Z' 
    GROUP BY time(12m)







