使用聚合
########

统计笔画数为 10 的字有多少个::

    db.getCollection("word").aggregate([{
        $match: {
            strokes: 10
        }
    }, {
        $group: {
            _id: 1,
            count: {
                $sum: 1
            }
        }
    }])


实例
====

一个集合::

    {
        from: "user_1",
        to: "user_2",
        text: "毕竟西湖六月中",
        time: ISODate("2018-10-01T00:02:12.000")
    }
    {
        from: "user_2",
        to: "user_1",
        text: "风光不与四时同",
        time: ISODate("2018-10-01T10:12:33.000")
    }
    {
        from: "user_2",
        to: "user_3",
        text: "车遥遥，马憧憧，君游东山东复东",
        time: ISODate("2018-10-01T19:44:21.000")
    }


.. note:: 在使用聚合时，每个管道默认允许占用的内存不超过 100M，否则会抛出错误。

指定使用磁盘来缓存结果::

    // 这只是一个容错的方案，并非一个好的方案
    db.collection.aggregate(pipelines, { allowDiskUse: true })



两个用户之间最近一个月的聊天时间分布情况::

    早上 5 点 30 分到晚上 7 点为白天，其余时间为夜晚
    按照这两个区间分别统计白天和夜晚的聊天数

    db.getCollection("chat").aggregate([{
        // 第一个管道匹配出最近一个月两个人的所有聊天记录，可以覆盖索引
        $match: {
            from: {
                $in: ["user_1", "user_2"]
            },
            to: {
                $in: ["user_1", "user_2"]
            },
            time: {
                $gte: ISODate("2018-10-01T00:00:00.000")
            }
        }
    }, {
        $project: {
            date: {
                // 将 time 字段转换为类似于 2018-10-01 的形式
                $dateToString: {
                    format: "%Y-%m-%d", date: "$time"
                }

            },
            hourAndMinute: {
              // 提取时间的时分两个值，转换为类似于 14:20 的形式
              $dateToString: {
                    format: "%H:%M", date: "$time"
                }
            }
        }
    }, {
      $group: {
          _id: "$date",
          daytime: {
              $sum: {
                  $cond: {
                    if: { 
                      $and: [{
                        $gte: ["$hourAndMinute", "05:30"]
                      }, {
                        $lte: ["$hourAndMinute", "19:00"]
                      }]
                    }, then: 1, else: 0
                }
              }
          },
          night: {
              $sum: {
                  $cond: {
                    if: { 
                      $and: [{
                        $gte: ["$hourAndMinute", "05:30"]
                      }, {
                        $lte: ["$hourAndMinute", "19:00"]
                      }]
                    }, then: 0, else: 1
                }
              }
          }
      }
    }])













