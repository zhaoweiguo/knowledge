创建索引
########

.. warning:: 线上创建索引时一定要写{background: true}。否则会对线上造成影响

.. note:: 从3.0版本后使用 db.collection.createIndex()代替db.collection.ensureIndex(). ensureIndex() 还能用, 但只是 createIndex() 的别名

语法::

    db.collection.createIndex(keys, options)
    参数说明：
    1. keys: {字段名1：ascending,… 字段名n：ascending}: ascending 设为1 标识索引升序，-1降序
    2. options : 设置索引选项，如设置名称、设置成为唯一索引


基本::

    这种索引创建方式会阻塞数据库的所有读写操作，直到索引建立完成

    db.col.createIndex({"title":1}, {background: true})   // 1是升续 2是降续

    创建唯一索引:
    db.collection.createIndex({filed.subfield:1}, {unique:true, background: true});

    // 创建多列索引:
    db.collection.createIndex({field1:1, field2:1}, {background: true});

    // 创建子文档索引:
    db.collection.createIndex({filed.subfield:1}, {background: true});

后台创建方式::

    // {background: true}
    // Mongo提供两种建索引的方式foreground和background。
    // 前台操作，它会阻塞用户对数据的读写操作直到index构建完毕；
    // 后台模式，不阻塞数据读写操作，独立的后台线程异步构建索引，此时仍然允许对数据的读写操作
    db.col1.createIndex({name: 1},{unique:true, background: true})
    db.col2.createIndex({ appId: 1, version: 1 },{unique:true, background: true})





限制::

    被索引的字段值最大不能超过 1024 个字节，否则会得到一个 KeyTooLong 的错误
    （尽管可以通过配置参数解除限制，但尽量不要这么做）
    一个集合最多可以有 64 个索引。
    索引名称长度：包括数据库与集合名称总共不超过 125 字符。
    组合索引最多可以有 31 个字段参与。














