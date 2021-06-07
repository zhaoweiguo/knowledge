.. _redis_slave:

redis主从配置
====================

* Redis主从配置::

    ${base_home}/lib/redis-server ${base_home}/conf/master_redis.conf
    ${base_home}/lib/redis-server ${base_home}/conf/slave_redis.conf

* 启动成功后可以通过 ``./redis-cli -p 6379 info`` 查看状态

* Master ：master_redis.conf::

    daemonize yes
    pidfile /home/admin/redis-2.0.4/run/master_redis.pid
    port 6379
    timeout 300
    loglevel verbose
    logfile /home/admin/redis-2.0.4/logs/master_redis.log
    databases 16
    save 900 1
    save 300 10
    save 60 10000
    rdbcompression yes
    dbfilename /home/admin/redis-2.0.4/data/master_dump.rdb
    dir /home/admin/redis-2.0.4/
    appendonly no
    appendfsync everysec
    vm-enabled no
    vm-swap-file /tmp/redis.swap
    vm-max-memory 0
    vm-page-size 32
    vm-pages 134217728
    vm-max-threads 4
    glueoutputbuf yes
    hash-max-zipmap-entries 64
    hash-max-zipmap-value 512
    activerehashing yes

* Slave ：master_redis.conf::

    daemonize yes
    pidfile /home/admin/redis-2.0.4/run/slave_redis.pid
    port 7289
    timeout 300
    loglevel verbose
    logfile /home/admin/redis-2.0.4/logs/slave_redis.log
    databases 16
    save 900 1
    save 300 10
    save 60 10000
    rdbcompression yes
    dbfilename /home/admin/redis-2.0.4/data/slave_dump.rdb
    dir /home/admin/redis-2.0.4/
    slaveof search041135.sqa.cm4 6379
    appendonly no
    appendfsync everysec
    vm-enabled no
    vm-swap-file /tmp/redis.swap
    vm-max-memory 0
    vm-page-size 32
    vm-pages 134217728
    vm-max-threads 4
    glueoutputbuf yes
    hash-max-zipmap-entries 64
    hash-max-zipmap-value 512
    activerehashing yes


