数组相关操作 [1]_
#####################


数组查询
========

::

    // 查询字段是数组
    db.time_info.find({"begin_time":{$size:1}})
    // 方法2
    db.time_info.find({ "begin_time.0": {$exists:1} })

    // 数组大小是某个范围(要求数组大小小于3)
    db.time_info.find({ $where: "this.begin_time.length < 3" })
    //数组大小小于1，就意味着num[0]不存在
    db.time_info.find({ "begin_time.0": {$exists:0} })


实战
====

数据插入::

  db.users.insertMany(
    [
       {
         _id: 1,
         name: "sue",
         age: 19,
         type: 1,
         status: "P",
         favorites: { artist: "Picasso", food: "pizza" },
         finished: [ 17, 3 ],
         badges: [ "blue", "black" ],
         points: [
            { points: 85, bonus: 20 },
            { points: 85, bonus: 10 }
         ]
       },
       {
         _id: 2,
         name: "bob",
         age: 42,
         type: 1,
         status: "A",
         favorites: { artist: "Miro", food: "meringue" },
         finished: [ 11, 25 ],
         badges: [ "green" ],
         points: [
            { points: 85, bonus: 20 },
            { points: 64, bonus: 12 }
         ]
       },
       {
         _id: 3,
         name: "ahn",
         age: 22,
         type: 2,
         status: "A",
         favorites: { artist: "Cassatt", food: "cake" },
         finished: [ 6 ],
         badges: [ "blue", "red" ],
         points: [
            { points: 81, bonus: 8 },
            { points: 55, bonus: 20 }
         ]
       },
       {
         _id: 4,
         name: "xi",
         age: 34,         
         type: 2,         
         status: "D",
         favorites: { artist: "Chagall", food: "chocolate" },
         finished: [ 5, 11 ],
         badges: [ "red", "black" ],
         points: [
            { points: 53, bonus: 15 },
            { points: 51, bonus: 15 }
         ]
       },
       {
         _id: 5,
         name: "xyz",
         age: 23,
         type: 2,
         status: "D",
         favorites: { artist: "Noguchi", food: "nougat" },
         finished: [ 14, 6 ],
         badges: [ "orange" ],
         points: [
            { points: 71, bonus: 20 }
         ]
       },
       {
         _id: 6,
         name: "abc",
         age: 43,
         type: 1,
         status: "A",
         favorites: { food: "pizza", artist: "Picasso" },
         finished: [ 18, 12 ],
         badges: [ "black", "blue" ],
         points: [
            { points: 78, bonus: 8 },
            { points: 57, bonus: 7 }
         ]
       }
    ]
  )


数组元素模糊匹配::

  //如下示例，数组字段badges每个包含该元素black的文档都将被返回
  > db.users.find({badges:"black"},{"_id":1,badges:1})
  { "_id" : 1, "badges" : [ "blue", "black" ] }
  { "_id" : 4, "badges" : [ "red", "black" ] }
  { "_id" : 6, "badges" : [ "black", "blue" ] }

数组元素精确(全)匹配::

  //如下示例，数组字段badges的值为["black","blue"]的文档才能被返回(数组元素值和元素顺序全匹配)
  > db.users.find({badges:["black","blue"]},{"_id":1,badges:1})
  { "_id" : 6, "badges" : [ "black", "blue" ] }

通过数组下标返回指定的文档::

  数组的下标从0开始，指定下标值则返回对应的文档
  //如下示例，返回数组badges中第一个元素值为black的文档
  > db.users.find({"badges.1":"black"},{"_id":1,badges:1})
  { "_id" : 1, "badges" : [ "blue", "black" ] }
  { "_id" : 4, "badges" : [ "red", "black" ] }

范围条件任意元素匹配查询::

  //查询数组finished的元素值既大于15，又小于20的文档
  > db.users.find( { finished: { $gt: 15, $lt: 20}},{"_id":1,finished:1})
  { "_id" : 1, "finished" : [ 17, 3 ] }
  { "_id" : 2, "finished" : [ 11, 25 ] }
  { "_id" : 6, "finished" : [ 18, 12 ] }

  //下面插入一个新的文档，仅包含单个数组元素
  > db.users.insert({"_id":7,finished:[19]})
  WriteResult({ "nInserted" : 1 })

  //再次查询，新增的文档也被返回
  > db.users.find( { finished: { $gt: 15, $lt: 20}},{"_id":1,finished:1})
  { "_id" : 1, "finished" : [ 17, 3 ] }
  { "_id" : 2, "finished" : [ 11, 25 ] }
  { "_id" : 6, "finished" : [ 18, 12 ] }
  { "_id" : 7, "finished" : [ 19 ] }

数组内嵌文档查询::

  //查询数组points元素1内嵌文档键points的值小于等于55的文档(精确匹配)
  > db.users.find( { 'points.0.points': { $lte: 55}},{"_id":1,points:1})
  { "_id" : 4, "points" : [ { "points" : 53, "bonus" : 15 }, { "points" : 51, "bonus" : 15 } ] }

  //查询数组points内嵌文档键points的值小于等于55的文档，此处通过.成员的方式实现
  > db.users.find( { 'points.points': { $lte: 55}}, {"_id":1,points:1})
  { "_id" : 3, "points" : [ { "points" : 81, "bonus" : 8 }, { "points" : 55, "bonus" : 20 } ] }
  { "_id" : 4, "points" : [ { "points" : 53, "bonus" : 15 }, { "points" : 51, "bonus" : 15 } ] }

数组元素操作符$elemMatch::

  作用：数组值中至少一个元素满足所有指定的匹配条件
  语法：  { <field>: { $elemMatch: { <query1>, <query2>, ... } } }
  说明：  如果查询为单值查询条件，即只有<query1>，则无需指定$elemMatch

  //如下示例,为无需指定$elemMatch情形
  //查询数组内嵌文档字段points.points的值为85的文档
  > db.users.find( { "points.points": 85},{"_id":1,points:1})
  { "_id" : 1, "points" : [ { "points" : 85, "bonus" : 20 }, { "points" : 85, "bonus" : 10 } ] }
  { "_id" : 2, "points" : [ { "points" : 85, "bonus" : 20 }, { "points" : 64, "bonus" : 12 } ] }

  > db.users.find( { points:{ $elemMatch:{points:85}}}, {"_id":1,points:1})
  { "_id" : 1, "points" : [ { "points" : 85, "bonus" : 20 }, { "points" : 85, "bonus" : 10 } ] }
  { "_id" : 2, "points" : [ { "points" : 85, "bonus" : 20 }, { "points" : 64, "bonus" : 12 } ] }

  //单数组查询($elemMatch示例)
  > db.scores.insertMany(
  ... [{ _id: 1, results: [ 82, 85, 88 ] },
  ... { _id: 2, results: [ 75, 88, 89 ] }])
  { "acknowledged" : true, "insertedIds" : [ 1, 2 ] }
  > db.scores.find({ results: { $elemMatch: { $gte: 80, $lt: 85 } } })
  { "_id" : 1, "results" : [ 82, 85, 88 ] }

  //数组内嵌文档查询示例($elemMatch示例)
  //查询数组内嵌文档字段points.points的值大于等于70，并且bonus的值20的文档(要求2个条件都必须满足)
  //也就是说数组points的至少需要一个元素同时满足以上2个条件，这样的结果文档才会返回
  //下面的查询数组值{ "points" : 55, "bonus" : 20 }满足条件
  > db.users.find( { points: { $elemMatch: { points: { $lte: 70 }, bonus: 20}}},{"_id":1,points:1})
  { "_id" : 3, "points" : [ { "points" : 81, "bonus" : 8 }, { "points" : 55, "bonus" : 20 } ] }

数组元素操作符$all::

  作用：数组值中满足所有指定的匹配条件，不考虑多出的元素以及元素顺序问题
  语法：{ <field>: { $all: [ <value1> , <value2> ... ] } }

  > db.users.find({badges:{$all:["black","blue"]}},{"_id":1,badges:1})
  { "_id" : 1, "badges" : [ "blue", "black" ] }  //此处查询的结果不考虑元素的顺序
  { "_id" : 6, "badges" : [ "black", "blue" ] }  //只要包含这2个元素的集合都被返回

  等价的操作方式
  > db.users.find({$and:[{badges:"blue"},{badges:"black"}]},{"_id":1,badges:1})
  { "_id" : 1, "badges" : [ "blue", "black" ] }
  { "_id" : 6, "badges" : [ "black", "blue" ] }


数组元素操作符$slice::

  作用：用于返回指定位置的数组元素值的子集(是数值元素值得一部分，不是所有的数组元素值)
  示例：db.collection.find( { field: value }, { array: {$slice: count } } );        

  //创建演示文档
  > db.blog.insert(
  ... {_id:1,title:"mongodb unique index",
  ... comment: [
  ... {"name" : "joe","content" : "nice post."},
  ... {"name" : "bob","content" : "good post."},
  ... {"name" : "john","content" : "greatly."}]}
  ... )
  WriteResult({ "nInserted" : 1 })

  //通过$slice返回集合中comment数组第一条评论
  > db.blog.find({},{comment:{$slice:1}}).pretty()
  {
          "_id" : 1,
          "title" : "mongodb unique index",
          "comment" : [
                  {
                          "name" : "joe",
                          "content" : "nice post."
                  }
          ]
  }

  //通过$slice返回集合中comment数组最后一条评论
  > db.blog.find({},{comment:{$slice:-1}}).pretty()
  {
          "_id" : 1,
          "title" : "mongodb unique index",
          "comment" : [
                  {
                          "name" : "john",
                          "content" : "greatly."
                  }
          ]
  }

  //通过$slice返回集合中comment数组特定的评论(可以理解为分页)
  //如下查询，返回的是第2-3条评论，第一条被跳过
  > db.blog.find({},{comment:{$slice:[1,3]}}).pretty()
  {
          "_id" : 1,
          "title" : "mongodb unique index",
          "comment" : [
                  {
                          "name" : "bob",
                          "content" : "good post."
                  },
                  {
                          "name" : "john",
                          "content" : "greatly."
                  }
          ]
  }

$占位符，返回数组中第一个匹配的数组元素值(子集)::

  使用样式：
    db.collection.find( { <array>: <value> ... },
                        { "<array>.$": 1 } )
    db.collection.find( { <array.field>: <value> ...},
                        { "<array>.$": 1 } )

  使用示例
  > db.students.insertMany([
    { "_id" : 1, "semester" : 1, "grades" : [ 70, 87, 90 ] },
    { "_id" : 2, "semester" : 1, "grades" : [ 90, 88, 92 ] },
    { "_id" : 3, "semester" : 1, "grades" : [ 85, 100, 90 ] },
    { "_id" : 4, "semester" : 2, "grades" : [ 79, 85, 80 ] },
    { "_id" : 5, "semester" : 2, "grades" : [ 88, 88, 92 ] },
    { "_id" : 6, "semester" : 2, "grades" : [ 95, 90, 96 ] }])                                          

  //通过下面的查询可知，仅仅只有第一个大于等于85的元素值被返回
  //也就是说$占位符返回的是数组的第一个匹配的值，是数组的子集
  > db.students.find( 
      { semester: 1, grades: { $gte: 85 } },
      { "grades.$": 1 } )
  { "_id" : 1, "grades" : [ 87 ] }
  { "_id" : 2, "grades" : [ 90 ] }
  { "_id" : 3, "grades" : [ 85 ] }


  > db.students.drop()

  //使用新的示例数据
  > db.students.insertMany([
          { "_id" : 7, semester: 3, "grades" : [ 
             { grade: 80, mean: 75, std: 8 },
             { grade: 85, mean: 90, std: 5 },
             { grade: 90, mean: 85, std: 3 } ] },
      { "_id" : 8, semester: 3, "grades" : [ 
             { grade: 92, mean: 88, std: 8 },
             { grade: 78, mean: 90, std: 5 },
             { grade: 88, mean: 85, std: 3 } ] }])

  //下面的查询中，数组的元素为内嵌文档，同样如此，数组元素第一个匹配的元素值被返回
  > db.students.find(
  ...    { "grades.mean": { $gt: 70 } },
  ...    { "grades.$": 1 })
  { "_id" : 7, "grades" : [ { "grade" : 80, "mean" : 75, "std" : 8 } ] }
  { "_id" : 8, "grades" : [ { "grade" : 92, "mean" : 88, "std" : 8 } ] }











.. [1] `MongoDB 数组查询 <https://blog.csdn.net/leshami/article/details/55049891>`_

