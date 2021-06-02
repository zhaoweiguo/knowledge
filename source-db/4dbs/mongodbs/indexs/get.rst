查看索引
========

查看::

    db.wei64_gadget_info.getIndexes()

    // 查看集合中的索引大小
    db.COLLECTION_NAME.totalIndexSize()


查看索引是否生效::

    db.index_test.find({"sex":1}).explain("executionStats")

    相关结果:
    示例1：查询字段不包含索引字段:
    winningPlan.stage=COLLSCAN是全表扫描

    示例2：查询字段同时包含索引字段和非索引字段
    虽然 winningPlan.stage=FETCH以及winningPlan.inputStage.stage =IXSCAN，
    但是其totalKeysExamined和totalDocsExamined都比nReturned大，说明在查询的时候进行了一些没有必要的扫描。

    示例3：查询字段同时只包含索引字段:
    可以看到返回中的
    winningPlan.stage=FETCH(根据索引去检索指定document )
    winningPlan.inputStage.stage =IXSCAN(索引扫描)
    executionStats.nReturned=totalKeysExamined=totalDocsExamined=9表示该查询使用的根据索引去查询指定文档
    (nReturned:查询返回的条目,totalKeysExamined:索引扫描条目,totalDocsExamined:文档扫描条目)

索引与排序的设置对查询性能的影响::

     db.index_test.find({"age":20}).sort({"sex":-1}).explain()
     1. 返回中的winningPlan.stage=SORT 即查询后需要在内存中排序再返回
     2. winningPlan.stage变为了FETCH(使用索引)

查看数据库中所有索引::

    db.system.indexes.find()








