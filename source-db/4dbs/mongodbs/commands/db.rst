DB相关
#############

使用MongoDB客户端::

    mongo            # 启动客户端
    mongo --host 127.0.0.1:27017
    mongo 192.168.1.200:27017/test -u user -p password


    show dbs         # 察看db列表
    use <dbName>     # 使用<dbName>数据库
    db               # 查看当前所在数据库
    show collections   # 查看此数据库的表列表
    show tables

    //指定编辑器
    export EDITOR=vim
    mongo


数据库::

    说明:
    1.DB不需要明确创建，使用use <db>，然后新增一条记录就自动创建
    2.Collection不需要明确创建，新增一条记录自动创建

    // 明确创建表
    db.createCollection()


查看运动的命令列表::

    db.runCommand({listCommands: 1})

查看host信息::

    db.hostInfo()


删除DB::

    > db.dropDatabase()
    { "dropped" : "runoob", "ok" : 1 }








