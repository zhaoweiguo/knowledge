表(集合)相关
############


表的使用::

    // 特殊表名使用
    db.getCollection("3 test").find()
    db.getCollection("3-test").find()
    db.getCollection("stats").find()

    //To format the printed result, you can add the.pretty() 
    db.myCollection.find().pretty()

    print()
    print(tojson(<obj>)) 
    printjson()


删除表(集合)::

    db.collection.drop()


固定集合 Capped Collections
===========================

事先创建固定大小的集合::

    db.createCollection("log", { capped : true, size : 5242880, max : 5000 } )
    ​
    capped：是否固定
    size：集合大小，单位KB
    max：文档数量

判断是否为固定集合::

    db.log.isCapped();

将已存在的集合转为固定集合::

    db.runCommand({"convertToCapped":"log",size:10000})

排序::

    db.log.find().sort( { $natural: -1 } )

特性::

    类似环形队列，如果空间不足，会把老数据删除，为新的数据提供空间；
    当指定文档数量上限时，必须同时指定大小；
    淘汰机制只有在容量还没有满时才会依据文档数量来工作；
    要是容量满了，淘汰机制会依据容量来工作；

优点::

    写入速度提升
        固定集合中的数据被顺序写入磁盘上的固定空间，不会因为其他集合的一些随机性的写操作而“中断”
        其写入速度非常快（不建立索引，性能更好）；
         
    固定集合会自动覆盖掉最老的文档
        因此不需要再配置额外的工作来进行旧文档删除。
        设置Job进行旧文档的定时删除容易形成性能的压力毛刺；
        
    按照插入顺序的查询输出速度极快；
    能够在插入最新数据时,淘汰最早的数据；
    固定集合非常实用与记录日志等场景；

缺点::

    固定集合创建之后就不可以改变，只能将其删除重建（不安全）；

    创建固定集合，为固定集合指定文档数量，必须同时指定固定集合的大小，不管先达到哪一个限制，之后插入的新文档都会把最老的文档移除集合；

    用convertToCapped将普通集合转换固定集合时:
    ⚠️原有索引会丢失，需手动创建
    并且此转换命令没有限制文档数量的参数；
    普通集合可以使用convertToCapped转换固定集合，但固定集合不可以转换为普通集合；

    ⚠️不可以对固定集合进行分片。

    对固定集合中的文档可以进行更新操作，但更新不能导致文档的Size增长或缩小，否则更新失败:
        如果要更新这个一个key 对应的value，更新后的值也必须为100个字节，大于100个字节不可以，小于100个字节也不可以。

    不可以对固定集合执行删除文档操作，只能删除整个集合。

    对集合估算size时，不要依据集合的storageSize ，而是依据集合的size。
    storageSize是wiredTiger存储引擎采用高压缩算法压缩后的








