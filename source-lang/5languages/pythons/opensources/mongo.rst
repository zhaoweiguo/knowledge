.. _python_mongo:

pymongo
#######

http://api.mongodb.org/python/current/tutorial.html


::

    from pymongo import * # 导包
    con = Connection(...) # 链接
    db = con.<database> # 链接数据库
    db.authenticate('username', 'password') # 登录
    db.drop_collection('users') #删除表
    db.logout() # 退出
    db.collection_names() # 查看所有表
    db.users.count() # 查询数量
    db.users.find_one({'name' : 'xiaoming'}) # 单个对象
    db.users.find({'age' : 18}) # 所有对象
    db.users.find({'id':64}, {'age':1,'_id':0}) # 返回一些字段 默认_id总是返回的 0不返回 1返回
    db.users.find({}).sort({'age': 1}) # 排序
    db.users.find({}).skip(2).limit(5) # 切片
    db.users.find({}, {}, 10, 20) # 第二种写法 切片 未测试




