数据删除/修改
##################

::

    //格式:
    db.<tableName>.remove(<value>)      # 删除对应数据

    //实例:
    db.mailing.list.remove({"opt-out" : true})


数据更新::

    //格式:
    db.<tableName>.update(<condition>, <newValue>)     # 更新一条数据

    //文档替换:
    db.user.update({"_id" : ObjectId("4217490312794ifdj344")},
        {"book" : "Learning Python and Mongo"})

"$set"修改器::

    # 添加一本书——"Learning Python and Mongo"
    db.users.update({"_id" : ObjectId("4217490312794ifdj344")}, 
        {"$set" : {"book" : "Learning Python and Mongo"} })
    # 修改书名——"Effective Python Programming"
    db.users.update({"_id" : ObjectId("4217490312794ifdj344")},
        {"$set" : {"book" : "Effective Python Programming"} })
    # 删除书的信息
    db.users.update({"_id" : ObjectId("4217490312794ifdj344")},
        {"$unset" : {"book" : 1}}

"$inc"增加和减少::

    # 初始数据
    db.games.insert({"game" : "pinball", "user" : "gordon"})
    # 设定得分基数50
    db.games.update({"game" : "pinball", "user" : "gordon"}, {"$inc" : {"score" : 50}})
    # 得分增加100
    db.games.update({"game" : "pinball", "user" : "gordon"}, {"$inc" : {"score" : 100}})









