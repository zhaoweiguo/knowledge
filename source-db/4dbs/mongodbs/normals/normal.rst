基本
####


MongoDB Atlas::

  a cloud-hosted service for provisioning, running, monitoring, 
    and maintaining MongoDB deployments.


::

  The maximum BSON document size is 16 megabytes.


Data Directories and Permissions::

  数据存储: /var/lib/mongo        对应配置:storage.dbPath
  日志文件: /var/log/mongodb      对应配置:systemLog.path
  配置文件: /etc/mongod.conf


常用知识
========

_id 字段其值为一个 12 字节的 ObjectId 类型::

    ObjectId = 4 个字节的 unix 时间戳 + 3 个字节的机器信息 + 2 个字节的进程 id + 3 个字节的自增随机数

    实例:
    5b72c9169db571c8ab7ee374
    前4个字节为: 5b72c916
    16进制转10进制后为: 1,534,249,238
    timestamp转为日期为: 2018/8/14 20:20:38

find、getMore 特性::

    find 命令，会返回第一批满足条件的 batch（默认 101 条记录）以及一个 cursor
    getMore 根据 find 返回的 cursor 继续遍历，每次遍历默认返回不超过 4MB 的数据

MongoDB 的索引是基于采样代价模型，一个索引对采样的数据集更优，并不意味着其对整个数据集也最优 [1]_ ::

    MongoDB 一个查询第一次执行时，如果有多个执行计划，会根据模型选出最优的，并缓存起来，以提升效率
    当 MongoDB 发生集合创建 / 删除索引时，会将缓存的执行计划清空掉，并重新选择
    MongoDB 在执行的过程中，也会根据执行计划的表现重新选择最优计划
        比如一个执行计划，很多次迭代都没遇到符合条件的文档，
        就会考虑这个执行计划是否最优了，会触发重新构建执行计划的逻辑

        这时在执行计划里会包含 {replanned: 1} 
        说明是重新构建了执行计划；
        当它发现这个执行计划实际执行起来效果更差时，最终还是会会到更优的执行计划上。

查看数据库和表的信息
====================

db.help() [2]_ ::

    db.adminCommand(nameOrDocument)// 切换到'admin'数据库,并且运行命令
    db.AddUser(username,password[, readOnly=false])  //添加用户  
    db.auth(usrename,password)     // 设置数据库连接验证  
    db.cloneDataBase(fromhost)     // 从目标服务器克隆一个数据库  
    db.commandHelp(name)           // returns the help for the command  
    db.copyDatabase(fromdb,todb,fromhost)  // 复制数据库fromdb---源数据库名称，todb---目标数据库名称，fromhost---源数据库服务器地址  
    db.createCollection(name,{size:3333,capped:333,max:88888})  // 创建一个数据集，相当于一个表  
    db.createView(name, viewOn, [ { $operator: {...}}, ... ], { viewOptions } ) // 创建视图
    db.createUser(userDocument)    // 创建用户
    db.currentOp()                 // 取消当前库的当前操作  
    db.dropDataBase()              // 删除当前数据库  
    db.eval(func,args)             // (已过时) run code server-side  
    db.fsyncLock()                 // 将数据保存到硬盘并且锁定服务器备份
    db.fsyncUnlock() unlocks server following a db.fsyncLock()
    db.getCollection(cname)        // 取得一个数据集合，同用法：db['cname'] or db.cname
    db.getCollenctionNames()       // 取得所有数据集合的名称列表  
    db.getLastError()              // 返回最后一个错误的提示消息  
    db.getLastErrorObj()           // 返回最后一个错误的对象  
    db.getLogComponents()
    db.getMongo()                  // 取得当前服务器的连接对象get the server  
    db.getMondo().setSlaveOk()     // allow this connection to read from then nonmaster membr of a replica pair  
    db.getName()                   // 返回当操作数据库的名称  
    db.getPrevError()              // 返回上一个错误对象  
    db.getProfilingLevel()         // 获取profile level  
    db.getReplicationInfo()        // 获得重复的数据  
    db.getSisterDB(name)           // get the db at the same server as this onew  
    db.killOp()                    // 停止（杀死）在当前库的当前操作 
    db.listCommands()              // lists all the db commands
    db.loadServerScripts()         // loads all the scripts in db.system.js
    db.logout()
    db.printCollectionStats()      // 返回当前库的数据集状态  
    db.printReplicationInfo()      // 打印主数据库的复制状态信息  
    db.printSlaveReplicationInfo() // 打印从数据库的复制状态信息  
    db.printShardingStatus()       // 返回当前数据库是否为共享数据库  
    db.removeUser(username)        // 删除用户  
    db.repairDatabase()            // 修复当前数据库  
    db.resetError()  
    db.runCommand(cmdObj)          // run a database command. if cmdObj is a string, turns it into {cmdObj:1}  
    db.runCommand(cmdObj)          // run a database command.  if cmdObj is a string, turns it into { cmdObj : 1 }
    db.serverStatus()
    db.setLogLevel(level, <component>)
    db.setProfilingLevel(level, <slowms>)    // 设置profile level 0=off,1=slow,2=all 
    db.setWriteConcern( <write concern doc> ) // sets the write concern for writes to the db
    db.unsetWriteConcern( <write concern doc> ) // unsets the write concern for writes to the db
    db.setVerboseShell(flag)       // display extra information in shell output
    db.shutdownServer()            // 关闭当前服务程序  
    db.stats()                     // 返回当前数据库的状态信息
    db.version()                   // 返回当前程序的版本信息




.. [1] https://developer.aliyun.com/article/230069
.. [2] https://blog.csdn.net/qq_21460229/article/details/70935170