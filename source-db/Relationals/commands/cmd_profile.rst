profiling分析查询
----------------------

::

    select @@profiling;
    //以下为使用方法
    set profiling = 1;
    xxxxx   // sql操作
    show profiles\G
    set profiling = 0; // 关闭操作


