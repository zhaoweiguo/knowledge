explain命令
###############

基本命令
========

count函数的explain[1]_ ::

    > db.my_collection.explain().count()

    // 带条件的:
    > db.my_collection.explain().count({ 'items' : { '$gte' : 1 } })

find函数的explain::

    > db.getCollection("word").find({ strokes: 5 }).explain().queryPlanner.winningPlan

查看update的执行计划::

    > db.example.explain().update({id:1},{$set:{name:"robinson_0612"}})



* 命中索引并不一定会带来显著的性能提升，关键在于命中索引之后能否显著降低文档扫描数

支持下列操作返回查询计划::

    aggregate(); count(); distinct(); find(); group(); remove(); update() 
    cursor.explain(verbosity)   为一个游标返回其查询执行计划(Reports on the query execution plan for a cursor)
    cursor.explain(verbosity) 最通常的行式为db.collection.find().explain()。其中verbosity说明返回信息的粒度。





获取explain的支持的运算方法::

    > db.collection.explain().help()
    Explainable operations
            .aggregate(...) - explain an aggregation operation
            .count(...) - explain a count operation
            .distinct(...) - explain a distinct operation
            .find(...) - get an explainable query
            .findAndModify(...) - explain a findAndModify operation
            .group(...) - explain a group operation
            .remove(...) - explain a remove operation
            .update(...) - explain an update operation
    Explainable collection methods
            .getCollection()
            .getVerbosity()
            .setVerbosity(verbosity)

获取explain().find()支持的运算方法::

    > db.collection.explain().find().help()
    Explain query methods
            .finish() - sends explain command to the server and returns the result
            .forEach(func) - apply a function to the explain results
            .hasNext() - whether this explain query still has a result to retrieve
            .next() - alias for .finish()
    Explain query modifiers
            .addOption(n)
            .batchSize(n)
            .comment(comment)
            .count()
            .hint(hintSpec)
            .limit(n)
            .maxTimeMS(n)
            .max(idxDoc)
            .min(idxDoc)
            .readPref(mode, tagSet)
            .showDiskLoc()
            .skip(n)
            .snapshot()
            .sort(sortSpec)



executionStats 就是执行 queryPlanner.winningPlan 这个计划时的统计信息



原理 [1]_
=========



查询语句同时命中了两个索引：

strokes_1
strokes_1_pinyin_1
Mongo 会通过优化分析选择其中一种更好的方案放置到 winningPlan，最终的执行计划是 winningPlan 所描述的方式。其它稍次的方案则会被放置到 rejectedPlans 中，仅供参考


如果希望排除其它杂项的干扰，可以直接只返回 winningPlan 即可：
db.getCollection("word").find({ strokes: 5 }).explain().queryPlanner.winningPlan

winningPlan 中，总执行流程分为若干个 stage（阶段），一个 stage 的分析基础可以是其它 stage 的输出结果。从这个案例来说，首先是通过 IXSCAN（索引扫描）的方式获取到初步结果（索引得到的结果是所有符合查询条件的文档在磁盘中的位置信息），再通过 FETCH 的方式提取到各个位置所对应的完整文档。这是一种很常见的索引查询计划（explain 返回的是一个树形结构，实际先执行的是子 stage，再往上逐级执行父 stage）。

参考
====

* https://blog.csdn.net/leshami/article/details/53521990




.. [1] http://docs.mongodb.org/manual/reference/method/db.collection.explain/#db.collection.explain