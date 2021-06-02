数据插入
############


数据插入::

    //格式:
    db.<tableName>.insert(<value>)      # 插入数据
    db.<tableName>.save(<value>)

    //实例:
    db.<tableName>.insert({"bar" : "baz"})
    db.<tableName>.insertMany([
        { item: "journal", qty: 25, status: "A",
           size: { h: 14, w: 21, uom: "cm" }, tags: [ "blank", "red" ] },
        ...
    ])











