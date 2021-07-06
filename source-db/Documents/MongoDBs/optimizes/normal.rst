常用
####

格式::

    db.collection.find().explain(verbose)



explain 支持三种分析模式(参数verbose)::

    queryPlanner(仅给出执行计划，默认)
        MongoDB运行查询优化器对当前的查询进行评估并选择一个最佳的查询计划
    executionStats(给出执行计划并执行)
        mongoDB运行查询优化器对当前的查询进行评估并选择一个最佳的查询计划进行执行
        在执行完毕后返回这个最佳执行计划执行完成时的相关统计信息
        对于写操作db.collection.explain()返回关于更新和删除操作的信息，但是并不真修改数据
        对于那些被拒绝的执行计划，不返回其统计信息
    allPlansExecution(前两种的结合)
        该模式是前2种模式的更细化，即会包括上述2种模式的所有信息
        即按照最佳的执行计划执行以及列出统计信息，而且还会列出一些候选的执行计划
        如果有多个查询计划   ，executionStats信息包括这些执行计划的部分统计信息


explain返回字段说明::

    nReturned：执行返回的文档数
    executionTimeMillis： 执行时间（ms）
    totalKeysExamined：索引扫描条数
    totalDocsExamined：文档扫描条数
    executionStages：执行步骤



Mongo 常见的执行步骤stage::

    COLLSCAN 文档扫描(Collection Scan)即:未命中索引,全表扫描
    IXSCAN 索引扫描
    FETCH 根据索引去检索指定 document
    SORT 内存排序(表明在内存中进行了排序)

    COUNT 进行了 count 运算
    COUNT_SCAN: count 使用了 Index 进行 count 时的 stage 返回
    COUNTSCAN: count 不使用 Index 进行 count 时的 stage 返回

    PROJECTION: 字段映射(限定返回字段时候 stage 的返回)

    OR $or 查询子句全部命中索引时出现
    LIMIT 结果集条数限制(使用 limit 限制返回数)
    SKIP 从结果集中跳过部分条目(使用 skip 进行跳过)

    IDHACK: 针对_id 进行查询

    SINGLE_SHARD:   数据在一个shard中
    SHARD_MERGE:    数据分布在多个shard中，合并各分片结果
    SHARDING_FILTER: 通过 mongos 对分片数据进行查询

    TEXT: 使用全文索引进行查询时候的 stage 返回

    SUBPLA: 未使用到索引的 $or 查询的 stage 返回

stage 的组合(查询的时候尽可能用上索引)::

    Fetch+IDHACK
    Fetch+ixscan
    Limit+（Fetch+ixscan）
    PROJECTION+ixscan
    SHARDING_FITER+ixscan
    COUNT_SCAN






