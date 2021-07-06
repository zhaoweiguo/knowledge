.. _mysql_practice_replication:

实践MySQL复制
====================

没有数据建立主从比较容易，有数据的时候建立主从可以使用如下步骤:

* 准备好主配置文件--> ``master.cnf``::

    [mysqld]
    log-bin=master-bin
    server-id=1
    innodb_flush_log_at_trx_commit=1
    sync_binlog=1
    skip-networking=enabled
    # skip replication DB
    binlog-ignore-db = mysql
    binlog-ignore-db = test


* 准备好从配置文件--> ``slave.cnf``::

    [mysqld]
    log-bin=slave-bin
    server-id=2
    # 一般配置
    master-host=<master-host>
    master-user=<master-user>
    master-password=<master-password>
    master-port=3306
    master-connect-retry=60
    # 
    relay_log=mysql-relay-bin
    read_only=1
    # skip replication DB
    replicate-ignore-db = mysql
    replicate-ignore-db = test

* 其他一些参数::

    replicate-do-table=tablename        #只复制某个表
    replicate-wild-do-table=tablename%  #只复制某些表(可用匹配符)
    replicate-do-db=dbname              #只复制某个库
    replicte-wild-do-db=dbname%         #只复制某些库
    replicate-ignore-table=tablename    #不复制某个表




* 在主机上建立一个具有 REPLICATION SLAVE 权限的用户 ``rep``::

    CREATE USER 'rep'@'%' IDENTIFIED BY 'q1w2e3r4';
    GRANT REPLICATION SLAVE ON *.* TO 'rep'@'%';

* 把 ``master.cnf`` 文件复制到 ``主机`` 的 ``/etc/my.cnf`` 中
* 重启主机 MySQL::

    service mysql restart

* 在主机上连接 MySQL客户端::

    mysql -h<host> -uroot -p

* 加读锁::

    FLUSH TABLES WITH READ LOCK;

* 把数据导出::

    mysqldump -hhostname -uusername -ppassword \
        --single-transaction --all-databases --lock-all-tables > backup_date_master_slave.sql

* 察看MySQL的 ``bin_log`` 和偏移::

    mysql> SHOW MASTER STATUS;
    +------------------+----------+--------------+------------------+
    | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
    +------------------+----------+--------------+------------------+
    | mysql-bin.000011 |     1160 |              | mysql,test       |
    +------------------+----------+--------------+------------------+
    1 row in set (0.01 sec)

* 释放读锁::

    UNLOCK TABLES;

* 把 ``slave.cnf`` 文件复制到 ``从机`` 的 ``/etc/my.cnf`` 中, 进入从机
* 启动从机MySQL服务
* 导入数据::

    mysql -hhostname -uusername -ppassword databasename < backup_date_master_slave.sql

* 根据前面的 ``bin_log`` 与偏移設定好主从::

    mysql> CHANGE MASTER TO
    ->     MASTER_HOST='master_host_name',
    ->     MASTER_USER='replication_user_name',
    ->     MASTER_PASSWORD='replication_password',
    ->     MASTER_LOG_FILE='recorded_log_file_name',
    ->     MASTER_LOG_POS=recorded_log_position;

* 开启从MySQL的slave线程::

    START SLAVE;

* 查看运行情况::

    show processlist;     //Master查看下进程是否Sleep太多::
    show master status;   //Master查看状态::
    //Slave查看状态
    show slave status;
    // 主要看Seconds_Behind_Master是否为0，直到为0时就已经同步了
    // Slave_IO_Running ,Slave_SQL_Running都为yes表示从库的I/O,Slave_SQL线程都正确开启

