redis几种数据导出导入方式
#############################

一、redis-dump方式
===========================

安装redis-dump工具::

    $ yum install ruby rubygems ruby-devel -y
    $ gem sources --add http://gems.ruby-china.org/ --remove http://rubygems.org/
    $ gem install redis-dump -V

redis-dump导出::

    $ redis-dump -u :password@172.20.0.1:6379 > 172.20.0.1.json

redis-load导入::

    $ cat 172.20.0.1.json | redis-load -u :password@172.20.0.2:6379


二、aof导入方式
========================

生成aof数据::

    $ redis-cli -h 172.20.0.2 -a password flushall      // 删除所有数据库中的所有数据
    OK
    // 源实例开启aof功能，将在dir目录下生成appendonly.aof文件
    $ redis-cli -h 172.20.0.1 -a password config set appendonly yes
    OK

    // ...(这儿执行的各种输入修改操作都会存储到appendonly.aof)

目标实例导入aof数据::

    $ redis-cli -h 172.20.0.2 -a password --pipe < appendonly.aof
    All data transferred. Waiting for the last reply...
    Last reply received from server.
    errors: 0, replies: 5

    // 源实例关闭aof功能
    $ redis-cli -h 172.20.0.1 -a password config set appendonly no
    OK

三、源实例db0迁移至目标实例db1
=======================================

::

    $ cat redis_mv.sh
    #!/bin/bash
    redis-cli -h 172.20.0.1 -p 6379 -a password -n 0 keys "*" | while read key
    do
        redis-cli -h 172.20.0.1 -p 6379 -a password -n 0 --raw dump $key | perl -pe 'chomp if eof' | redis-cli -h 172.20.0.2 -p 6379 -a password -n 1 -x restore $key 0
        echo "migrate key $key"
    done

四、rdb文件迁移方式
==========================

原理: 复制rdb文件，然后让要迁移的redis加载这个rdb文件就ok了

源redis操作::

    $ vim from.conf
    ...
    dbfilename /var/rdb/dump6379.rdb
    ...
    // 将数据用save命令固化到rdb文件中
    redis> save
    OK
    // 杀掉当前redis的进程，否则下一步的复制rdb文件，rdb处于打开的状态，复制的文件，会占用同样的句柄:
    redis> quit
    $ pkill -9 redis
    $ ls /var/rdb/dump6379.rdb
    -rw-r--r--   1 zhaoweiguo  staff    56B Aug  5  2018   dump6379.rdb

目的redis操作::

    $ vim to.conf
    ...
    appendonly no    # 关闭redis的aof日志功能
    dbfilename /var/rdb/dump6379.rdb
    ...

    $ redis-server ./to.conf
    $ redis-cli
    ...









