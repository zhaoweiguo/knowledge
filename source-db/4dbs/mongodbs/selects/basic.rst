数据查询
########

::

    # 查出所有数据
    db.<tableName>.find().limit(30)
    # 等于
    db.<tableName>.find({"key" : <value>})
    # 不等于
    db.<tableName>.find({"key" :{$ne: <value>}})
    # 多条件and
    db.<tableName>.find({"key1" : <value1>, "key2" : <value2>})
    # 多条件or
    db.<tableName>.find({$or : [{"key1" : <value1>}, {"key2" : <value2>}]})

    # 查出一条数据
    db.<tableName>.findOne()
    # 查出满足条件的一条数据
    db.<tableName>.findOne({<key>, <value>})
    # Match an Embedded Document
    db.inventory.find( { size: { h: 14, w: 21, uom: "cm" } } )
    db.inventory.find( { "size.uom": "in" } )
    # 根据数组字段部分匹配
    # "red"是tags字段中的其中一个element
    db.inventory.find( { tags: "red" } )
    # 数组的完全匹配
    db.inventory.find( { tags: ["red", "blank"] } )



指定返回的键::

    # 只取出表中字段为<key1>和<key2>的值
    db.<tableName>.find({}, {<key1> : 1, <key2> : 1})
    # 取出除字段<key>之外的表的数据
    db.<tableName>.find({}, {<key> : 0})

查询条件( ``$lt``, ``$lte``, ``$gt``, ``$gte`` 的使用 )::

    db.<tableName>.find({<key> : {"$gte" : <value1>, "$lte" : <value2>} } )

``$or``, ``$in`` 进行OR查询::

    # $in
    db.<tableName>.find({<key> : {"$in" : [<value1>, <value2>]}})
    # $or
    db.<tableName>.find({"$or" : [{<key1>:<value1>}, {<key2>:<value2>}]})

``$not`` 是元条件句, 即可以用在任何其他条件之上