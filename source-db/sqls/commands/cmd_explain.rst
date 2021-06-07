explain命令相关
-----------------
::

    Show命令
    慢查询日志


    1. explain分析查询
    explain <sql>;  -- SQL语句的查询执行计划(QEP)。这条命令的输出结果能够让我们了解MySQL 优化器是如何执行sql语句的
    analyze table <tab>;   //

    2. profiling分析查询
    mysql> SET profiling = 1;
    mysql> xxxxx(sql语句);
    mysql> SHOW PROFILES\G


    MySQL数据库是常见的两个瓶颈是CPU和I/O的瓶颈, 如果应用分布在网络上，那么查询量相当大的时候那么平瓶颈就会出现在网络上


EXPLAIN字段::

    ØTable：显示这一行的数据是关于哪张表的
    Øpossible_keys：显示可能应用在这张表中的索引。如果为空，没有可能的索引。可以为相关的域从WHERE语句中选择一个合适的语句
    Økey：实际使用的索引。如果为NULL，则没有使用索引。MYSQL很少会选择优化不足的索引
         此时可以在SELECT语句中使用USE INDEX（index）来强制使用一个索引或者用IGNORE INDEX（index）来强制忽略索引
    Økey_len：使用的索引的长度。在不损失精确性的情况下，长度越短越好
    Øref：显示索引的哪一列被使用了，如果可能的话，是一个常数
    Ørows：MySQL认为必须检索的用来返回请求数据的行数
    Øtype：这是最重要的字段之一，显示查询使用了何种类型。从最好到最差的连接类型为system、const、eq_reg、ref、range、index和ALL

    system > const > eq_ref > ref > fulltext > ref_or_null > index_merge
        > unique_subquery > index_subquery > range > index > ALL

        nsystem、const：可以将查询的变量转为常量.  如id=1; id为 主键或唯一键.
        neq_ref：访问索引,返回某单一行的数据.(通常在联接时出现，查询使用的索引为主键或惟一键)
        nref：访问索引,返回某个值的数据.(可以返回多行) 通常使用=时发生
        nrange：这个连接类型使用索引返回一个范围中的行，比如使用>或<查找东西，并且该字段上建有索引时发生的情况(注:不一定好于index)
        nindex：以索引的顺序进行全表扫描，优点是不用排序,缺点是还要全表扫描
        nALL：全表扫描，应该尽量避免

    ØExtra：关于MYSQL如何解析查询的额外信息，主要有以下几种

        nusing index：只用到索引,可以避免访问表. 
        nusing where：使用到where来过虑数据. 不是所有的where clause都要显示using where. 如以=方式访问索引.
        nusing tmporary：用到临时表
        nusing filesort：用到额外的排序. (当使用order by v1,而没用到索引时,就会使用额外的排序)
        nrange checked for eache record(index map:N)：没有好的索引.

