TTL索引
#######

和普通索引的创建方法一样，只是会多加一个expireAfterSeconds的属性::

    格式:
    db.collection.createIndex( {<普通索引>},{ expireAfterSeconds: time})

    实例:
    db.eventlog.createIndex( { "updateDate": 1 }, { expireAfterSeconds: 3600 } )

原理::

    TTL 索引，是根据索引的 date 值进行判断的，通过一个定时运行的后台线程，来定期的进行扫描
    如果发现当前时间大于 date+expire 的时间值，则进行删除

    注:
    1. date 必须设置，并且如果设置错误，会导致超时删除错误
    2. 后台线程是定时运行的，定时精度取决于定时时间，因此可能会存在误差，如果后台线程一分钟运行一次，则最大误差为一分钟


说明::

    当指定时间到了过期的阈值数据就会过期并删除；
    如果字段是数组，并且索引中有多个日期值，MongoDB使用数组中最低（即最早）的日期值来计算到期阈值；

    注:
    如果文档(document)中的索引字段不是日期或包含日期值的数组，则文档(document)将不会过期；
    如果文档(document)不包含索引字段，则文档(document)不会过期。

TTL索引特有限制::

    TTL 索引必须单列索引，组合索引不能是 TTL 索引
    TTL 索引字段必须是 bson 的时间格式
    索引精度取决于后台线程清理周期，一般是一分钟
    capped 集合不能设置 TTL 索引

    _id属性不支持TTL索引
    无法在上限集合上创建TTL索引，因为MongoDB无法从上限集合中删除文档
    不能使用createIndex()方法来更改现有索引的expireAfterSeconds值
        而是将collMod数据库命令与索引集合标志结合使用
        否则，要更改现有索引的选项的值，必须先删除索引并重新创建
    如果字段已存在非TTL单字段索引，则无法在同一字段上创建TTL索引，因为无法在相同key创建不同类型的的索引

作用::

    MongoDB可以使用它在一定时间后或在特定时钟时间自动从集合中删除文档
    这用来保存一些诸如session会话信息的时候非常有用，或者存储缓存数据使用


实例
====

MongoDB 设置记录超时自动删除::

    原理:
    MongoDB 中使用 TTL 索引来实现，命令中字段 expireAfterSeconds 来实现超时自动删除
    单位为秒，索引字段必须是 bson 的时间类型

    > db.test.createIndex({"date": 1}, {expireAfterSeconds: 60})

    数据格式:
    db.test.insert({"name": "testexpire", "date": new Date()})

与「稀疏索引」接合::

    删除确实是一个很重的操作，每条删除的数据都会导致全部相关的索引做变更，因此速度不会太快
    可用下面的方法来「异步删除」

    1. 创建ttl索引，并指定isDeleted为true才索引
    db.foo.createIndex({
        expire: 1
    }, {
        partialFilterExpression: {
            isDeleted: true
        },
        expireAfterSeconds: 0   // 马上过期
    })

    2. 在操作删除时，只需要更新isDeleted和expire字段就好了：
    db.foo.update({...}, {$set: {isDeleted: true, expire: new Date()}});
















