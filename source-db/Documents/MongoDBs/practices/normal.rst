常见实战例子
############

非阻塞式创建索引查看执行进度
----------------------------

可以通过db.currentOp()查看进度::

    mongo> db.currentOp()
    { 
      "inprog" : [
        ns: "api.$cmd",
        opid: "d-2ze15bc9e0a5c484:53962865",
        ...
        command: {
          createIndexes: "order",   // 要创建索引的表名
          $db: "api"        // db
          indexes: [          // 要创建的索引
            {
                key: {
                    order_id: 1,
                    created_time: 1,
                },
                name: "order_id_1_created_time_-1",
                background: true
            }
          ],
        },
        // 这儿查看进度百分比 
        "msg" : "Index Build (background) Index Build (background): 439475/1000804 43%",
        "progress" : {
            "done" : 439476.0,      // 已经执行的次数
            "total" : 1000804.0     // 需要执行的总次数
        }
      ], 
      "ok" : 1.0
    }

取消执行错误的命令
------------------

1. 先通过 ``db.currentOp()`` 查出指定进程的opid::

    mongo> db.currentOp()
    { 
      "inprog" : [
        ns: "api.$cmd",
        opid: "d-2ze15bc9e0a5c484:53962865",
        ...
      ]
    }

2. 杀掉此进程::

    mongo> db.killOp(99080)
    @todo 待验证
    mongo> db.killOp("d-2ze15bc9e0a5c484:53962865")












