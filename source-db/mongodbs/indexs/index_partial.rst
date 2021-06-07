局部索引
########

简介::

    局部索引(Partial Indexes)
    这是3.2.0版本以后新增的

    只会对Collections满足条件partialFilterExpression的文档进行索引
    使用该索引，会在一定程度上减少存储空间和创建索引和维护性能降低的成本

创建部分索引::

    db.restaurants.createIndex(
       { cuisine: 1, name: 1 },
       { partialFilterExpression: { rating: { $gt: 5 } } }
    )
    //查询情况分类
    db.restaurants.find( { cuisine: "Italian", rating: { $gte: 8 } } )   //(1)
    db.restaurants.find( { cuisine: "Italian", rating: { $lt: 8 } } )    //(2)
    db.restaurants.find( { cuisine: "Italian" } )                        //(3)


.. note:: 备注：3.2.0 版本后推荐使用Partial Indexes




