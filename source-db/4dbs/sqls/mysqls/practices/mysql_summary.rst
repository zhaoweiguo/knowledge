.. _mysql_summary:

MySQL知识汇总
#########################

MySQL慢查询
===================

查看配置变量操作(执行时间超过2s的为慢查询)::

    mysql> show variables like '%slow%';
    +---------------------+------------------------------+
    | Variable_name       | Value                        |
    +---------------------+------------------------------+
    | log_slow_queries    | ON                           |
    | slow_launch_time    | 2  (这个不是慢查询时间)      |
    | slow_query_log      | ON                           |
    | slow_query_log_file | /var/mysql/log/slowquery.log |
    +---------------------+------------------------------+

    mysql> show variables like 'long%';
    +-----------------+----------+
    | Variable_name   | Value    |
    +-----------------+----------+
    | long_query_time | 2.000000 |  // 这个才是慢查询时间
    +-----------------+----------+

查看现在的状态(系统显示有634个慢查询)::

    mysql> show global status like '%slow%';
    +---------------------+-------+
    | Variable_name       | Value |
    +---------------------+-------+
    | Slow_launch_threads | 0     |
    | Slow_queries        | 634   |
    +---------------------+-------+

在配置文件中增加慢查询日志::

    log-slow-queries= /var/mysql/log/slowquery.log

MySQL连接数
===================

::

    mysql> show variables like 'max_connections';
    +-----------------+-------+
    | Variable_name   | Value |
    +-----------------+-------+
    | max_connections | 500   |
    +-----------------+-------+

    mysql> show global status like 'max_used_connections';
    +----------------------+-------+
    | Variable_name        | Value |
    +----------------------+-------+
    | Max_used_connections | 98    |
    +----------------------+-------+

比较理想的设置是::

    max_used_connections / max_connections * 100% ≈ 85%
    # 如果发现比例在10%以下，mysql服务器连接数上限设置的过高了

key_buffer_size
=========================
key_buffer_size是对myisam表性能影响最大的一个参数

::

    show variables like 'key_buffer_size';
    +-----------------+-------+
    | Variable_name   | Value |
    +-----------------+-------+
    | key_buffer_size | 16384 |
    +-----------------+-------+

    show global status like 'key_read%';
    +-------------------+-------+
    | Variable_name     | Value |
    +-------------------+-------+
    | Key_read_requests | 303   |
    | Key_reads         | 185   |
    +-------------------+-------+

共303个索引读取請求, 有185个請求在内存中没有找到直接从硬盘读取索引, 计算索引未命中的概率::

    key_cache_miss_rate ＝ key_reads / key_read_requests * 100%

* key_cache_miss_rate在0.1%以下都很好
* 如果key_cache_miss_rate在0.01%以下的话，key_buffer_size分配的过多，可以适当减少

``key_blocks_*`` 参数::

    mysql> show global status like 'key_blocks_u%';
    +-------------------+-------+
    | Variable_name     | Value |
    +-------------------+-------+
    | Key_blocks_unused | 13    |
    | Key_blocks_used   | 8     |
    +-------------------+-------+

* ``key_blocks_unused`` 表示未使用的缓存簇(blocks)数
* ``key_blocks_used`` 表示曾经用到的最大的blocks数

比较理想的设置::

    key_blocks_used / (key_blocks_unused + key_blocks_used) * 100% ≈ 80%

临时表
==============
::

    mysql> show global status like 'created_tmp%';
    +-------------------------+-------+
    | Variable_name           | Value |
    +-------------------------+-------+
    | Created_tmp_disk_tables | 256   |
    | Created_tmp_files       | 68    |
    | Created_tmp_tables      | 944   |
    +-------------------------+-------+

* 每次创建临时表，created_tmp_tables增加
* 如果是在磁盘上创建临时表，created_tmp_disk_tables也增加
* created_tmp_files表示mysql服务创建的临时文件文件数

比较理想的配置是::

    created_tmp_disk_tables / created_tmp_tables * 100% <= 25%

::
    
    mysql> show variables where variable_name in ('tmp_table_size', 'max_heap_table_size');
    +---------------------+-----------+
    | Variable_name       | Value     |
    +---------------------+-----------+
    | max_heap_table_size | 16777216  |
    | tmp_table_size      | 209715200 |
    +---------------------+-----------+

* 只有16mb以下的临时表才能全部放内存, 超过的就会用到硬盘临时表

open table情况
==================
::

    show global status like 'open%tables%';
    +---------------+-------+
    | Variable_name | Value |
    +---------------+-------+
    | Open_tables   | 4     |
    | Opened_tables | 1418  |
    +---------------+-------+

* open_tables表示打开表的数量
* opened_tables表示打开过的表数量
* 如果opened_tables数量过大，说明配置中table_open_cache(5.1.3之前这个值叫做table_cache)值可能太小

服务器table_cache值::

    mysql> show variables like 'table_open_cache';
    +------------------+-------+
    | Variable_name    | Value |
    +------------------+-------+
    | table_open_cache | 4     |
    +------------------+-------+

比较合适的值为::

    open_tables / opened_tables * 100% >= 85%
    open_tables / table_cache * 100% <= 95%


进程使用情况
====================
::

    mysql> show global status like 'thread%';
    +-------------------+-------+
    | Variable_name     | Value |
    +-------------------+-------+
    | Threads_cached    | 0     |
    | Threads_connected | 58    |
    | Threads_created   | 118   |
    | Threads_running   | 1     |
    +-------------------+-------+

* 如果我们在mysql服务器配置文件中设置了thread_cache_size, 当客户端断开之后, 服务器处理此客户的线程将会缓存起来以响应下一个客户而不是销毁(前提是缓存数未达上限)
* threads_created表示创建过的线程数
* 如果发现threads_created值过大的话，表明mysql服务器一直在创建线程，这也是比较耗资源，可以适当增加配置文件中thread_cache_size值

查询服务器thread_cache_size配置::

    mysql> show variables like 'thread_cache_size';
    +-------------------+-------+
    | Variable_name     | Value |
    +-------------------+-------+
    | thread_cache_size | 0     |
    +-------------------+-------+

查询缓存(query cache)
============================
::

    mysql> show global status like 'qcache%';
    +-------------------------+-------+
    | Variable_name           | Value |
    +-------------------------+-------+
    | Qcache_free_blocks      | 0     |
    | Qcache_free_memory      | 0     |
    | Qcache_hits             | 0     |
    | Qcache_inserts          | 0     |
    | Qcache_lowmem_prunes    | 0     |
    | Qcache_not_cached       | 0     |
    | Qcache_queries_in_cache | 0     |
    | Qcache_total_blocks     | 0     |
    +-------------------------+-------+

* qcache_free_blocks：缓存中相邻内存块的个数。数目大说明可能有碎片。flush query cache会对缓存中的碎片进行整理，从而得到一个空闲块
* qcache_free_memory：缓存中的空闲内存
* qcache_hits：每次查询在缓存中命中时就增大
* qcache_inserts：每次插入一个查询时就增大, 命中次数除以插入次数就是不中比率
* qcache_lowmem_prunes：缓存出现内存不足并且必须要进行清理以便为更多查询提供空间的次数。这个数字最好长时间来看；如果这个数字在不断增长，就表示可能碎片非常严重，或者内存很少。（上面的 free_blocks和free_memory可以告诉您属于哪种情况
* qcache_not_cached：不适合进行缓存的查询的数量，通常是由于这些查询不是 select 语句或者用了now()之类的函数
* qcache_queries_in_cache：当前缓存的查询（和响应）的数量
* qcache_total_blocks：缓存中块的数量

查询一下服务器关于query_cache的配置::

    mysql> show variables like 'query_cache%';
    +------------------------------+---------+
    | Variable_name                | Value   |
    +------------------------------+---------+
    | query_cache_limit            | 1048576 |
    | query_cache_min_res_unit     | 4096    |
    | query_cache_size             | 0       |
    | query_cache_type             | ON      |
    | query_cache_wlock_invalidate | OFF     |
    +------------------------------+---------+

* query_cache_limit：超过此大小的查询将不缓存
* query_cache_min_res_unit：缓存块的最小大小
* query_cache_size：查询缓存大小
* query_cache_type：缓存类型，决定缓存什么样的查询，示例中表示不缓存 select sql_no_cache 查询
* query_cache_wlock_invalidate：当有其他客户端正在对myisam表进行写操作时，如果查询在query cache中，是否返回cache结果还是等写操作完成再读表获取结果。
* query_cache_min_res_unit的配置是一柄”双刃剑”，默认是4kb，设置值大对大数据查询有好处，但如果你的查询都是小数据查询，就容易造成内存碎片和浪费。

查询缓存碎片率::

    qcache_free_blocks / qcache_total_blocks * 100%

* 如果查询缓存碎片率超过20%，可以用flush query cache整理缓存碎片，或者试试减小query_cache_min_res_unit，如果你的查询都是小数据量的话

查询缓存利用率::

    (query_cache_size - qcache_free_memory) / query_cache_size * 100%

* 查询缓存利用率在25%以下的话说明query_cache_size设置的过大，可适当减小
* 查询缓存利用率在80％以上而且qcache_lowmem_prunes > 50的话说明query_cache_size可能有点小，要不就是碎片太多

查询缓存命中率::

    (qcache_hits - qcache_inserts) / qcache_hits * 100%


排序使用情况
=====================

::

    mysql> show global status like 'sort%';
    +-------------------+-------+
    | Variable_name     | Value |
    +-------------------+-------+
    | Sort_merge_passes | 85    |
    | Sort_range        | 0     |
    | Sort_rows         | 38519 |
    | Sort_scan         | 534   |
    +-------------------+-------+

* sort_merge_passes 包括两步
* 首先会尝试在内存中做排序，使用的内存大小由系统变量 ``sort_buffer_size`` 决定
* 如果它的大小不够把所有的记录都读到内存中，mysql 就会把每次在内存中排序的结果存到临时文件中，等 mysql 找到所有记录之后，再把临时文件中的记录做一次排序。这再次排序就会增加 sort_merge_passes
* 实际上，mysql 会用另一个临时文件来存再次排序的结果，所以通常会看到 sort_merge_passes 增加的数值是建临时文件数的两倍
* 因为用到了临时文件，所以速度可能会比较慢，增加 sort_buffer_size 会减少 sort_merge_passes 和 创建临时文件的次数
* 但盲目的增加 sort_buffer_size 并不一定能提高速度,见 `how fast can you sort data with mysql(貌似被墙) <http://qroom.blogspot.com/2007/09/mysql-select-sort.html>`_
* 另外，增加read_rnd_buffer_size(3.2.3是record_rnd_buffer_size)的值对排序的操作也有一点的好处，参见: http://www.mysqlperformanceblog.com/2007/07/24/what-exactly-is-read_rnd_buffer_size/

文件打开数(open_files)
==============================

::

    mysql> show global status like 'open_files';
    +---------------+-------+
    | Variable_name | Value |
    +---------------+-------+
    | Open_files    | 3     |
    +---------------+-------+

    mysql> show variables like 'open_files_limit';
    +------------------+-------+
    | Variable_name    | Value |
    +------------------+-------+
    | open_files_limit | 2500  |
    +------------------+-------+

* 比较合适的设置：open_files / open_files_limit * 100% <= 75%

表锁情况
=================

::

    mysql> show global status like 'table_locks%';
    +-----------------------+-------+
    | Variable_name         | Value |
    +-----------------------+-------+
    | Table_locks_immediate | 17746 |
    | Table_locks_waited    | 2     |
    +-----------------------+-------+

* table_locks_immediate表示立即释放表锁数
* table_locks_waited表示需要等待的表锁数
* 如果table_locks_immediate / table_locks_waited > 5000，最好采用innodb引擎，因为innodb是行锁而myisam是表锁，对于高并发写入的应用innodb效果会好些


表扫描情况
================

::

    mysql> show global status like 'handler_read%';
    +-----------------------+-----------+
    | Variable_name         | Value     |
    +-----------------------+-----------+
    | Handler_read_first    | 9205      |
    | Handler_read_key      | 6126402   |
    | Handler_read_last     | 0         |
    | Handler_read_next     | 117528    |
    | Handler_read_prev     | 0         |
    | Handler_read_rnd      | 2574      |
    | Handler_read_rnd_next | 689232285 |
    +-----------------------+-----------+

* 各字段解释参见 http://hi.baidu.com/thinkinginlamp/blog/item/31690cd7c4bc5cdaa144df9c.html 

调出服务器完成的查询请求次数::

    mysql> show global status like 'com_select';
    +---------------+-------+
    | Variable_name | Value |
    +---------------+-------+
    | Com_select    | 16848 |
    +---------------+-------+

计算表扫描率::

    handler_read_rnd_next / com_select

* 如果表扫描率超过4000，说明进行了太多表扫描，很有可能索引没有建好，增加read_buffer_size值会有一些好处，但最好不要超过8mb



