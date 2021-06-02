较复杂的
###############

多project查询
-------------------
::

    LogStore与RDS联合查询
    Join语法

unnest语法
-------------
::

    处理数据时，一列数据通常为字符串或数字等primitive类型的数据。
    在复杂的业务场景下，日志数据的某一列可能会是较为复杂的格式，例如:
        数组（array）、对象(map)、JSON等格式
    对这种特殊格式的日志字段进行查询分析，可以使用unnest语法。

unnest语法结构::

    unnest( array) as table_alias(column_name)  
        表示把array类型展开成多行，行的名称为column_name。
    unnest(map) as table(key_name, value_name)  
        表示把map类型展开成多行，key的名称为key_name，value的名称为value_name

.. note::

    注意，由于unnest接收的是array或者map类型的数据，如果您的输入为字符串类型，那么要先转化成json类型，然后再转化成array类型或map类型，转化的方式为 cast(json_parse(array_column) as array(bigint))。

实例::

    __source__:  1.1.1.1
    __tag__:__hostname__:  vm-req-170103232316569850-tianchi111932.tc
    __topic__:  TestTopic_4
    array_column:  [1,2,3]
    double_column:  1.23
    map_column:  {"a":1,"b":2}
    text_column:  商品


遍历数组
------------

遍历数组每一个元素::

    使用SQL把array展开成多行：
    * | select  array_column, a   from log, 
        unnest( 
          cast( json_parse(array_column)   as array(bigint) ) 
        ) as  t(a)

统计数组中的每个元素的和::

    * | select   sum(a)    from log, 
        unnest( 
            cast( json_parse(array_column)   as array(bigint) ) 
        ) as  t(a)

按照数组中的每个元素进行group by计算::

    * | select   a, count(1)    from log, 
        unnest( 
            cast( json_parse(array_column)   as array(bigint) ) 
        ) as  t(a)     group by a


遍历Map
----------

遍历Map中的元素::

    * | select  map_column , a,b    from log, 
        unnest( 
            cast( json_parse(map_column)   as map(varchar, bigint) ) 
        ) as  t(a,b)

按照Map的key进行group by 统计::

    * | select   key,  sum(value)    from log, 
        unnest( 
            cast( json_parse(map_column)   as map(varchar, bigint) ) 
        ) as  t(key,value)    GROUP  BY  key


格式化显示histogram,numeric_histogram的结果
--------------------------------------------------

通常情况下histogram的结果为一串json数据，无法配置视图展示，例如::

    * | select histogram(method)

您可以通过unnest语法，把JSON展开成多行配置视图，例如::

    * | select  key , value  from( 
        select histogram(method) as his from log
    ) , unnest(his ) as t(key,value)

numeric_histogram语法是为了把数值列分配到多个桶中去，相当于对数值列进行group by::

    * | select numeric_histogram(10,Latency)

numeric_histogram的输出格式化展示::

    * |  select key,value from(
        select numeric_histogram(10, Latency) as his from log
    ) , unnest(his) as t(key,value)





实例::

    __source__:  1.1.1.1
    __tag__:__hostname__:  vm-req-170103232316569850-tianchi111932.tc
    __topic__:  TestTopic_4
    array_column:  [1,2,3]
    double_column:  1.23
    map_column:  {"a":1,"b":2}
    text_column:  商品


