groupby
=======

::


    以用户表(users, {_id, uid, groupid, create_time})为例
    db.users.aggregate ([{"$group": {"_id": "$groupid", count: {"$sum":1}}}])
    但这样只能显示部分数据，想要显示全部数据可以把结果导出到一个临时表里
    
    导出数据到临时表 （将查询结果导出到user_tmp表中）
    db.users.aggregate ([{"$group": {"_id": "$uid", count: {"$sum":1}}}, {"$out": "user_tmp"}])

    这样你就可以随时调用了:
    1. 查询groupid为110的个数
    db.user_tmp.find({"_id":"110"})
    { "_id" : "110", "count" : 163 }
    2. 随便查3条
    db.user_tmp.find({}).limit(3)
    { "_id" : "110", "count" : 163 }
    { "_id" : "111", "count" : 63 }
    { "_id" : "112", "count" : 13 }

    最后用完了，记得删除临时表
    db.user_tmp.drop()





