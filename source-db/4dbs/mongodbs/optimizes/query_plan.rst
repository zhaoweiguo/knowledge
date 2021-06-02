查询计划-Query Plans
####################


缓存的查询计划在以下条件下会清空并重新评估 [1]_ ::

    集合收到 1000 次写操作
    执行 reindex
    添加或删除索引
    mongod 进程重启
    查询时指定 explain ()

索引过滤器（Index Filters）::

    db.collection.explain () 方法的 indexFilterSet (boolean 类型) 字段

列出与集合 query shape 有关联的索引过滤器。语法格式如下 [2]_ ::

    > db.runCommand( { planCacheListFilters: <collection_name> } )
    {
       "filters" : [
          {
             "query" : <query>
             "sort" : <sort>,
             "projection" : <projection>,
             "indexes" : [
                <index1>,
                ...
             ]
          },
          ...
       ],
       "ok" : 1
    }


参考文档
========

* 你真的会用索引么？[Mongo]: https://zhuanlan.zhihu.com/p/77971681




.. [1] MongoDB 笔记 - 查询计划: http://imushan.com/2018/04/15/db/MongoDB%E7%AC%94%E8%AE%B0-%E6%9F%A5%E8%AF%A2%E8%AE%A1%E5%88%92/
.. [2] https://xuexiyuan.cn/article/detail/174.html

