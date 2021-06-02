MySQL高级错误
####################



Host 'host_name' is blocked
----------------------------------
::

    mysql_log: Cannot connect to database server 192.168.0.4: (1129) 
    Host '192.168.0.6' is blocked because of many connection errors; 
    unblock with 'mysqladmin flush-hosts'

原因::

    The value of the max_connect_errors system variable determines how many successive interrupted 
        connection requests are permitted. (See Section 5.1.4, “Server System Variables”.) 
    After max_connect_errors failed requests without a successful connection, mysqld assumes that
        something is wrong (for example, that someone is trying to break in), 
        and blocks the host from further connections until you issue a FLUSH HOSTS statement 
        or execute a mysqladmin flush-hosts command.

    By default, mysqld blocks a host after 10 connection errors. 
    You can adjust the value by setting max_connect_errors at server startup:

解决方案::

    shell> mysqld_safe --max_connect_errors=10000 &
    mysql> SET GLOBAL max_connect_errors=10000;
    或者在my.cnf文件中增加max_connect_errors选项

注意:

    If you get the Host 'host_name' is blocked error message for a given host, you should first verify that there is nothing wrong with TCP/IP connections from that host. If you are having network problems, it does you no good to increase the value of the max_connect_errors variable.

查找连接出错的具体原因
----------------------

* bug邮件内容: http://bugs.mysql.com/bug.php?id=24761

* 察看警告配置::

    mysql> show variables like '%warn%';
    +---------------+-------+
    | Variable_name | Value |
    +---------------+-------+
    | log_warnings  | 2     |
    | sql_warnings  | OFF   |
    | warning_count | 0     |


* 察看被拒绝的次数::

    mysql> show global status like '%abort%';
    +------------------+-------+
    | Variable_name    | Value |
    +------------------+-------+
    | Aborted_clients  | 3     |
    | Aborted_connects | 4     |

* 在错误日志中出现Aborted connections messages可能原因有(每次发生``Aborted_clients``会加1)::

    * 客户端在关闭前没有调用 ``mysql_close()``
    * 客户端had been sleeping more than ``wait_timeout`` or ``interactive_timeout`` 
        seconds without issuing any requests to the server
    * 客户端程序在数据传输时意外中止

* 当出现如下4种情况时，服务器 ``Aborted_connects`` 状态变量加1::

    * client没有权限连接到server
    * client输入错误密码
    * connection packet没有包含正确信息(?)
    * 用超过 ``connect_timeout`` 秒得到一个connect packet，见Section 5.2.3, “System Variables”.

* 使用如下命令会增加一次 ``Aborted_connects`` ::

    telnet localhost 3306

Unknown/unsupported table type: INNODB
--------------------------------------------
::

   Plugin 'InnoDB' registration as a STORAGE ENGINE failed.
   Unknown/unsupported table type: INNODB

* 解决办法1(不使用innodb数据库了)::

    找到
    default-storage-engine=INNODB
    把该设置改为
    default-storage-engine=MYISAM

* 解决办法2(使用innodb):

    删除文件 ``ib_logfile0``

Mysql主从不同步问题
-----------------------------
* 首先在Master上用::

    show processlist;   查看下进程是否Sleep太多。发现很正常。
    show master status; 也正常

* Slave上查看::

    show slave status\G

* 错误提示::

    Slave_IO_Running: Yes
    Slave_SQL_Running 为 NO
    Seconds_Behind_Master 为 (null)

* 说明io同步没问题, sql执行有问题. 可能的原因:

    * 程序可能在slave上进行了写操作
    * slave机器重起后，事务回滚造成的

* 解决办法1::

    stop slave;
    set global sql_slave_skip_counter =<N> ; // 用来跳过几个错误事件
    start slave;

* 解决方法2(如上操作无用)::

    mysql> change master to 
    > master_host='master_ip',
    > master_user='user', 
    > master_password='pwd', 
    > master_port=3307, 
    > master_log_file='mysql-bin.000020', 
    > master_log_pos=135617781;

* 检查, 主要看::

    Slave_IO_Running: Yes
    Slave_SQL_Running: Yes
    Seconds_Behind_Master是否为0，0就是已经同步了



Mysql主从不同步问题2
---------------------------

* 网络的延迟::

    由于mysql主从复制是基于binlog的一种异步复制, 通过网络传送binlog文件, 理所当然网络延迟是主从不同步的绝大多数的原因, 
    特别是跨机房的数据同步出现这种几率非常的大, 所以做读写分离, 注意从业务层进行前期设计

* 主从两台机器的负载不一致::

    由于mysql主从复制是主数据库上面启动1个io线程, 而从上面启动1个sql线程和1个io线程, 
    当中任何一台机器的负载很高, 忙不过来, 导致其中的任何一个线程出现资源不足, 都将出现主从不一致的情况

* ``max_allowed_packet`` 设置不一致::

    主数据库上面设置的max_allowed_packet比从数据库大, 当一个大的sql语句, 能在主数据库上面执行完毕, 
    从数据库上面设置过小, 无法执行, 导致的主从不一致

* key自增键开始的键值跟自增步长设置不一致引起的主从不一致
* mysql异常宕机情况下, 如果未设置 ``sync_binlog=1`` 或者 ``innodb_flush_log_at_trx_commit=1`` 很有可能出现 ``binlog`` 或者 ``relaylog`` 文件出现损坏, 导致主从不一致
* mysql本身的bug引起的主从不同步
* 版本不一致, 特别是高版本是主, 低版本为从的情况下, 主数据库上面支持的功能, 从数据库上面不支持该功能:

* 基于以上情况，先保证 ``max_allowed_packet``, 自增键开始点和增长点设置一致, 再者牺牲部分性能在主上面开启 ``sync_binlog``, 对于采用innodb的库，推荐配置下面的内容::

    1. innodb_flush_logs_at_trx_commit = 1
    2. innodb-support_xa = 1 # Mysql 5.0 以上
    3. innodb_safe_binlog      # Mysql 4.0

* 同时在从数据库上面推荐加入下面两个参数::

    1. skip_slave_start
    2. read_only


MySQL延迟时间
-----------------------

一般很短在几十ms间,不可能没有延迟, 具体的延迟时间主要和网速和sql的执行时间有关,最少延迟时间为sql的执行时间.

Mysql主从不同步问题3
--------------------

特点::

    Slave_IO_Running和Slave_SQL_Running均yes

命令::

    mysql> show slave status

错误日志::

    071128 14:54:52 [ERROR] Failed to open the relay log './dev4-relay-bin.003594' (relay_log_pos 235)
    071128 14:54:52 [ERROR] Could not find target log during relay log initialization

原因::

    hostname改变了

操作方法1步骤::

    * 恢复老数据(?):
        mysqlbinlog oldhostname-relay-bin.003594 --start-position=235 | mysql -u root -ppassword;

    * 修改索引日志，使slave日志指向新日志(?如何修改法?):
        emacs  relay-log.info

操作方法2步骤::

    * 删除掉oldhostname-relay-bin*的文件和relay-log.info文件

之后操作::

    Start slave;
    Show slave status;


mysql update safe model问题
----------------------------------

在做数据库实验的时候对mysql表进行UPDATE操作时，mysql给了我一个错误::

    Error Code: 1175. You are using safe update mode and you tried to 
    update a table without a WHERE that uses a KEY column To disable safe mode

原来mysql有个叫SQL_SAFE_UPDATES的变量。上面这么说::

    MySQL will refuse to run the UPDATE or DELETE query if executed without 
    the WHERE clause or LIMIT clause. MySQL will also refuse the query which 
    have WHERE clause but there is no condition with the KEY column

* SQL_SAFE_UPDATES有两个取值：0和1。SQL_SAFE_UPDATES = 1时，不带where和limit条件的update和delete操作语句是无法执行的，即使是有where和limit条件但不带key column的update和delete也不能执行。SQL_SAFE_UPDATES = 0时，update和delete操作将会顺利执行。那么很显然，此变量的默认值是1。

* 你可以执行::

    set SQL_SAFE_UPDATES = 0;
    delete from <table> where name in ("gordon", "hurry")

MySQL占CPU多的情况解决方法
--------------------------

最简单的情况是 ``tmp_table_size`` 太小,在配置文件中增加::

    tmp_table_size=200M


ERROR 1040 (HY000):Too many connections
-----------------------------------------------

检查连接MySQL客户端数::

    linux >> netstat -anp  | grep mysql | wc -l
    or
    mysql >> show processlist;

解决方案::

    修改 ``my.cnf`` 文件在 ``[mysqld]`` 中增加
    > max_connections=N
    or
    mysql> SET GLOBAL max_connections = 300;

另外, wait_timeout默认为8小时,show processlist发现有很多sleep, 说明该参数设置偏大(设置10分钟内该连接没有请求就断开)::

    * 配置文件下修改(需要重新启动):
        wait_timeout = 600
        interactive_timeout = 600

    * 命令修改(无需重启):
        set global wait_timeout = 3600;
        set global interactive_timeout = 3600;



命令操作时中文乱码解决办法
--------------------------

查看操作::

  show variables like '%char%';

使用命令::

    set names utf8[gbk]
    or
    set character_set_client=utf8;
    set character_set_results=utf8;
    set character_set_connection=utf8;

配置文件修改::

    default-character-set=utf8

启用skip-name-resolve模式时出现Warning的处理办法
------------------------------------------------

在优化MYSQL配置时, 加入 ``skip-name-resolve``, 有警告信息::

    120726 11:57:22 [Warning] 'user' entry 'root@localhost.localdomain'
    ignored in --skip-name-resolve mode.  www.2cto.com

原因:

    * ``skip-name-resolve`` 是禁用dns解析，避免网络DNS解析服务引发访问MYSQL的错误，一般应当启用
    * 启用后，在mysql的授权表中就不能使用主机名了，只能使用IP ，出现此警告是由于mysql 表中已经存在有 localhost.localdomain 帐号信息


解决::

    mysql>use mysql;
    mysql> delete  from user where HOST='localhost.localdomain';
    Query OK, 2 rows affected (0.00 sec)

InnoDB: Error: page 213054 log sequence number <xxx>is in the future! 
-------------------------------------------------------------------------

详情::
   
   InnoDB: Error: page 213054 log sequence number <xxx>is in the future!
   InnoDB: Current system log sequence number<xxx>
   InnoDB: Your database may be corrupt or you may have copied the InnoDB
   InnoDB: tablespace but not the InnoDB log files. See
   InnoDB: http://dev.mysql.com/doc/refman/5.5/en/forcing-innodb-recovery.html
   InnoDB: for more information.

原因::

   1. 删除ib_logfile文件

解决方案(待验证)::

  将参数修改为innodb_force_recovery = 4
  http://dev.mysql.com/doc/refman/5.5/en/forcing-innodb-recovery.html
  


