其他
====

查询表数据条数::

    # 查询此表的数据条数
    db.<tableName>.count()
    # 查询此表按条件的数据条数
    db.<tableName>.find({<key> : <value>}).count()

limit, skip, sort::

    # 查询出限定条数的数据
    db.<tableName>.find({<key> : <value>}).limit(<count>)

    # 排序
    db.<tableName>.find().sort(<key>, -1)    # 降序
    db.<tableName>.find().sort(<key>, 1)     # 升序

    # 忽略前<count>个匹配的文档,如果匹配的小于<count>则不返回任何文档
    db.<tableName>.find().skip(<count>)

like模糊查询::

    mongoDB 支持正则表达式
    1. select * from users where name like "%hurry%";
    db.users.find({name:/hurry/}); 
    2. select * from users where name like "hurry%";
    db.users.find({name:/^hurry/}); 

$in, $and复杂查询::

    db.getCollection('wei64_gadget_info').find({
        $and : [
          {"time_created": {
              "$gte" : ISODate("2019-01-02"), "$lt" : ISODate("2019-07-03")
          }},
          {"gadget_type_id": {"$in" : [200001, 200007, 200020, 200022, 200024, 200026, 200027, 200028]} }
        ]
      }).count()





