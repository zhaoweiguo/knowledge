配置文件相关参数
======================
::

    --  连接请求的变量
    max_connections   -- 最大连接数
    back_log      -- 等待队列大小。默认数值是50，可调优为128，对于Linux系统设置范围为小于512的整数
    interactive_timeout    -- 交互连接在被服务器在关闭前等待行动的秒数(默认数值是28800，可调优为7200)
    
    -- 缓冲区变量
    -- 1. 全局缓冲
    key_buffer_size     -- 指定索引缓冲区的大小，它决定索引处理的速度，尤其是索引读的速度
    query_cache_size    -- 查询缓冲大小
    -- 2. 每个连接的缓冲
    record_buffer_size    -- 每个进行一个顺序扫描的线程为其扫描的每张表分配这个大小的一个缓冲区(默认数值是128K,可改为16M)
    read_rnd_buffer_size   -- 随机读缓冲区大小
    sort_buffer_size      -- 每个需要进行排序的线程分配该大小的一个缓冲区
    join_buffer_size       -- 联合查询操作所能使用的缓冲区大小
    record_buffer_size，read_rnd_buffer_size，sort_buffer_size，join_buffer_size为每个线程独占，也就是说，如果有100个线程连接，则占用为16M*100
    table_cache    -- 表高速缓存的大小
    max_heap_table_size   -- 用户可以创建的内存表(memory table)的大小, 这个值用来计算内存表的最大行数值
    tmp_table_size        -- 一张临时表的大小,如果

    thread_cache_size    -- 
    thread_concurrency  -- 推荐设置为服务器 CPU核数的2倍
    wait_timeout    -- 指定一个请求的最大连接时间，对于4GB左右内存的服务器可以设置为5-10

    -- 配置InnoDB的几个变量
    innodb_buffer_pool_size
    innodb_flush_log_at_trx_commit
    innodb_log_buffer_size   -- log缓存大小,对于较大的事务，可以增大缓存大小
    innodb_additional_mem_pool_size     -- 
    innodb_thread_concurrency

