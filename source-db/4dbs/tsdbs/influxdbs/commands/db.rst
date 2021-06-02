DB级,表级
#########

创建数据库::

    > CREATE DATABASE "NOAA_water_database"
    // 创建一个有特定保留策略的数据库
    > CREATE DATABASE "NOAA_water_database" WITH DURATION 3d REPLICATION 1 SHARD DURATION 1h NAME "liquid"

删除数据库::

    DROP DATABASE <database_name>

用DROP从索引中删除series::

    DROP SERIES FROM <measurement_name[,measurement_name]> WHERE <tag_key>='<tag_value>'
    1. 从单个measurement删除所有series：
    > DROP SERIES FROM "h2o_feet"
    2. 从单个measurement删除指定tag的series：
    > DROP SERIES FROM "h2o_feet" WHERE "location" = 'santa_monica'
    3. 从数据库删除有指定tag的所有measurement中的所有数据：
    > DROP SERIES WHERE "location" = 'santa_monica'

用DELETE删除series::

    > DELETE FROM "h2o_feet"
    > DELETE FROM "h2o_quality" WHERE "randtag" = '3'
    > DELETE WHERE time < '2016-01-01'

删除measurement::
    
    DROP MEASUREMENT <measurement_name>

删除shard::

    DROP SHARD <shard_id_number>

schema的语法
============

::

    SHOW DATABASES
    SHOW RETENTION POLICIES
    SHOW SERIES
    SHOW MEASUREMENTS
    SHOW TAG KEYS
    SHOW TAG VALUES
    SHOW FIELD KEYS

1. 显示时间线::

    show series 

    > SHOW SERIES ON NOAA_water_database

    > USE NOAA_water_database
    > SHOW SERIES
    $ curl -G "http://localhost:8086/query?db=NOAA_water_database&pretty=true" --data-urlencode "q=SHOW SERIES"

2. 显示rp::

    > SHOW RETENTION POLICIES ON NOAA_water_database

    > USE NOAA_water_database
    > SHOW RETENTION POLICIES

    $ curl -G "http://localhost:8086/query?db=NOAA_water_database&pretty=true" --data-urlencode "q=SHOW RETENTION POLICIES"

3. # 显示度量::

    show measurements

    > SHOW MEASUREMENTS ON NOAA_water_database

    > USE NOAA_water_database
    > SHOW MEASUREMENTS

    $ curl -G "http://localhost:8086/query?db=NOAA_water_database&pretty=true" --data-urlencode "q=SHOW MEASUREMENTS"

    // 运行有多个子句的SHOW MEASUREMENTS(1)
    > SHOW MEASUREMENTS ON DB WITH MEASUREMENT =~ /h2o.*/ LIMIT 2 OFFSET 1
    结果:
    name: measurements
    name
    ----
    h2o_pH
    h2o_quality

    // 运行有多个子句的SHOW MEASUREMENTS(2)
    > SHOW MEASUREMENTS ON NOAA_water_database WITH MEASUREMENT =~ /h2o.*/ 
        WHERE "randtag"  =~ /\d/
    结果:
    name: measurements
    name
    ----
    h2o_quality


4. # 显示Tag的Key::

    show tag keys
    show tag keys from metrics
    
    > SHOW TAG KEYS ON "DB"
    
    > USE DB
    > SHOW TAG KEYS

    $ curl -G "http://localhost:8086/query?db=NOAA_water_database&pretty=true" --data-urlencode "q=SHOW TAG KEYS"

    // 运行带有多个子句的SHOW TAG KEY
    > SHOW TAG KEYS ON "DB" FROM "h2o_quality" LIMIT 1 OFFSET 1

    name: h2o_quality
    tagKey
    ------
    randtag

5. SHOW TAG VALUES::

    > SHOW TAG VALUES ON "DB" WITH KEY = "randtag"

    > USE NOAA_water_database
    > SHOW TAG VALUES WITH KEY = "randtag"

    $ curl -G "http://localhost:8086/query?db=NOAA_water_database&pretty=true" --data-urlencode 'q=SHOW TAG VALUES WITH KEY = "randtag"'

    # 运行带有多个子句的SHOW TAG VALUES
    > SHOW TAG VALUES ON "NOAA_water_database" WITH KEY IN ("location","randtag") 
    WHERE "randtag" =~ /./ LIMIT 3
    结果:
    name: h2o_quality
    key        value
    ---        -----
    location   coyote_creek
    location   santa_monica
    randtag       1

6. 显示数据字段的Key::

    show field keys
    show field keys from metrics

    > SHOW FIELD KEYS ON "NOAA_water_database"

    > USE NOAA_water_database
    > SHOW FIELD KEYS

    $ curl -G "http://localhost:8086/query?db=NOAA_water_database&pretty=true" --data-urlencode 'q=SHOW FIELD KEYS'




