日期查询
========

::

    // 大于指定时间
    db.getCollection('wei64_user_line').find({
        "time_created":{$gt:ISODate("2018-08-02T11:21:00.000Z")}
    }).sort({"time_created": 1}).limit(30)

    // 大于指定时间且指定用户
    db.getCollection('wei64_user_line').find({
        $and : [
            {"user_id":"8e96652473d485d7f6f28e37cebc2a89"}, {"time_created":{$gt:ISODate("2018-01-02")}}
        ]
    }).sort({"time_created": -1}).limit(300)

    db.getCollection('wei64_user_line').find({
        "time_created": {
            "$gte" : ISODate("2018-01-23T00:00:00Z"), 
            "$lt" : ISODate("2018-01-24T00:00:00Z")
        }
    })






