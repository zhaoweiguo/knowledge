数组修改
#########


数组修改器1( ``$push`` 的使用)::

    # 初始数据
    db.games.insert({"game" : "pinball"})
    # 增加一个属性user, 值是一个数组里面有一个值:gordon
    db.games.update(({"game" : "pinball"}, {"$push" : {"users" : "gordon"}})
    # 往users字段中再增加一个用户leo
    db.games.update(({"game" : "pinball"}, {"$push" : {"users" : "leo"}})

数组修改器2( ``$pop`` 的使用)::

    # 从数组末尾删除一个元素
    db.game.update({"game" : "pinball"}, {"$pop" : {"users" : 1}})
    # 从数组开头删除一个元素
    db.game.update({"game" : "pinball"}, {"$pop" : {"users" : -1}})

数据修改器3( ``$pull`` 的使用)::

    # 把user中值为"gordon"的从列表中删除
    db.game.update({"game" : "pinball"}, {"$pull" : {"user" : "gordon"} } )

往数组增加数据时使用 ``$addToSet`` 可以避免重复::

    db.games.update({}, {"$addToSet" : {"user" : "gordon"}})   # 这条数据因为数据表里有数据而执行无效



组合使用::

    //使用 ``$addToSet`` 和 ``$each`` 组合起来,可以添加多个不同的值:
    db.games.update(
       {"game" : "pinball"},     # 限定条件
       {"$addToSet" : {"users" :
          {"$each" : ["gordon", "joe", "andor"]}   # 要新增的列表
       } }
    )

    //其他:
    $ne





