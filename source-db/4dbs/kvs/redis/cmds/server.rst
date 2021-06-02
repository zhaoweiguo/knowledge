Redis 服务器命令
====================

server::

    shutdown:从客户端同步的把redis中的数据存入到磁盘并关闭服务端
    save:手动的把redis中的数据同步到磁盘上
    monitor:实时监听所有服务端请求，可以用这个命令来查看redis有没有问题,它是一个调试时用到的命令，输出整个redis服务端接到的请求
    lastsave:得到最后一次成功将数据保存到磁盘的unix时间戳，单位是秒
    info:得到redis的一些基本的信息

        <1>used_memory:redis实际用到的内存
        <2>used_memory_rss:用top、ps看到redis所占内存。(这儿<1>与<2>的比例可以看成是“内存碎片比例”)
        <3>changes_since_last_save:上次存储到磁盘后修改的记录数(上次save或bgsave调用后，产生数据改变的操作数)
        <4>allocation_stats:展示了一定大小分配数据的直方图(最大256)[holds a histogram containing the number of allocations of a certain size (up to 256).]它提供了在redis运行时期测量分配类型的执行的工具。

    flushdb:清除当前数据库中所有的键
    flushall:清除所有数据库中所有的键
    debug segfault:让服务端崩溃，服务端在崩溃前会打印一些日志信息
    debug object "key":得到键"key"的调试信息
    dbsize:返回数据库中的键的数量
    config resetstat:重置被info命令返回的统计
    config set "param" "value":把一个配置参数赋值给一个给定的值
    config get "param":得到这个配置参数的值
    bgsave:异步存储数据到磁盘
    bgrewriteaof:异步重写只添加文件


删除所有Key::

    //删除当前数据库中的所有Key
    flushdb
    //删除所有数据库中的key
    flushall







