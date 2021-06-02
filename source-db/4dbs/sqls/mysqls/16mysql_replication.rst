.. _mysql_replication:

16. 复制
########

:author: 新溪-gordon
:date: 2012-05-28





网站主页: http://dev.mysql.com/doc/refman/5.5/en/replication.html

* 复制是asynchronous——slave不需要一直连着master接收更新. 更新可能出现在long-distance连接甚至临时或间歇连接(如拨号服务). 根据配置的不同，你可以复制所有数据库或指定数据库或某数据库中的指定表

* 使用mysql replication的原因有::

    Scale-out solutions: 扩展解决方案，如主写分离(这种模型可以提高写的性能，而读的性能则可以通过增加slave的数量来实现)
    Data security: 数据安全(因数据已经复制到slave，slave可以暂停复制进程，然后运行备份服务而不用影响master上的数据)
    Analytics: 数据分析(数据的产生是在master上，slave可以在暂停复制进程，然后进行数据分析而不影响master)
    Long-distance data distribution(远程数据分布): 如果分支机构想使用主数据，可以通过复制给此分支机构以备份，而不用永久给他们master上的权限

* 在MySQL属性上只支持一种方式——异步复制(一台server做master，其余的为slave)。与此形成对比的是MySQL集群(``见17章MySQL集群``)的一个属性——同步复制
* 有好多可用的解决方案来設定两server间的复制，但最好的方法是根据当前的 **数据和引擎的类型** 来决定(``见16.1.1如何設定复制``)
* 复制的方法主要两类(``见16.1.2复制格式``)::

    Statement Based Replication (SBR)[默认格式]
    Row Based Replication (RBR)
    还有一种Mixed Based Replication(MBR)

* 复制通过一系列的不同的选项和变量进行控制!这些选项和变量控制着核心操作中的“复制”、超时、哪些数据库和过滤信息(``见16.1.3 复制与二进制选项和变量``)
* 可以通过复制解决一系列不同的问题——如性能问题、不同DB的备份、还可以作为减少系统失败大解决方案的一部分(``见16.3 复制解决方案``)
* 不同数据类型和語句在复制时如何处理的脚注(包含复制属性、版本兼容、升级、问题及处理方案，包含FAQ(``见 16.4 复制脚注``))
* “复制”实现的细节信息，复制的实现，二进制日志进程和内容，語句如何记录和复制后台线程和规则(``见16.2 复制的实现``)




.. _configure:

16.1 配置文件
===============


* master和slave都必需有一个统一的id(server-id选项).
* slave必须配置好

    * master host name
    * log file name
    * position within that file

* 这些也可以在 ``slave`` 上的MySQL session中用 ``change master to`` 语句来改变
* 这些被存储在 ``slave`` 的 ``master.info`` 文件中

* 本章描述了“复制”环境所需的安装、配置！包含一步步创建复制环境的指南！主要内容包括:

    * 为两台或多台服务器“复制操作”安装、配置的指南(见16.1.1 如何建立复制)——处理系统配置并提供在master与slaves间的拷贝
    * 在二进制日志下的事件是一系列格式的记录(SBR, RBR, MIXED)(见16.1.2 复制格式)
    * 不同配置选项和变量在“复制”中所产生的具体作用(见16.1.3 复制与二进制日志选项与变量)
    * 启动复制后，你需要很少的管理与监控，但你需要运行的常用任务(见16.1.4 复制常用的管理任务)





16.1.1 如何建立复制
==========================

大纲
-------
* 网址: http://dev.mysql.com/doc/refman/5.5/en/replication-howto.html
* 本章节主要告诉你如何为MySQL服务建立一个完全的复制。有一系统不同的方法！具体的方法根据你想建立怎样的复制以及在你master数据库中是否已经有数据
* 在复制建立时，的一些常用的基本工作:

    * 在master上，你要enable binary logging并配置一个唯一的server id(可能需要重启服务)[见 16.1.1.1 設定复制中master配置]
    * 在每个想连接到master的slave上，你一定要配置一个唯一的server id(可能需要重启服务)[见 16.1.1.2 設定复制中slave配置]
    * [非必需]创建一个单独的用户，专门用于你的slaves从master认证读取用于复制的二进制日志数据[见16.1.1.3 为复制创建用户]
    * 在创建数据snapshot或启动复制进程前，你应该记录master上二进制日志的位置！你会在配置slave时需要此信息(通过它slave才知道二进制日志从哪个点开始运行事件)[见 16.1.1.4 得到复制二进制日志位移]
    * 如果在你的master上已经有数据了，你需要把数据同步到slave上，这时你就要建立一个数据的snapshot: 1. 使用 ``mysqldump`` 命令创建(16.1.1.5) 2. 直接拷贝文件(16.1.1.6)
    * 你需要配置slave连接master，如host name, login credentials, binary log文件和位移[见 16.1.1.10 在slave上設定连接master的配置]

* 在你配置好基本的选项后，你需要按照如下的指令来继续你的复制設定(以下是一系列可选操作):

    * master无数据时，进行主从备份，你只需要修改配置文件[16.1.1.7 設定新的主从复制]
    * master有数据时，进行主从备份，[16.1.1.8 設定有数据时的主从复制]
    * 在已经建立主从的情况下，增加从，这种情况不影响从服务器.[16.1.1.9]

* 你想管理MySQL复制服务,你可能还需要察看[13.4.1 控制Master服务的SQL語句]、[13.4.2 控制slave服务的SQL語句]。还有[16.1.3 复制与二进制日志选项与变量]
* 注意: 复制时可能需要SUPER privilege，如果没有，可能导致失败

配置两个或多个用于复制的服务的安装手册。处理 **系统配置** 以及master与slave之间copy数据的方法。详见: 



目录:

    * :ref:`16.1.1.1 设定复制master配置文件 <setup_master>`
    * :ref:`16.1.1.2 设定复制配置文件 <setup_slave>`
    * :ref:`16.1.1.3 为复制创建一个用户 <setup_newuser>`
    * :ref:`16.1.1.4 得到复制Master二进制日志位移 <setup_binlog>`
    * :ref:`16.1.1.5 用mysqldump创建数据快照 <setup_snapshotdump>`
    * :ref:`16.1.1.6 用Raw Data文件创建数据快照 <setup_snapshotraw>`
    * :ref:`16.1.1.7 設定新Master和Slave的复制 <setup_new>`
    * :ref:`16.1.1.8 在存在的数据中設定复制 <setup_existdata>`
    * :ref:`16.1.1.9 介绍额外的Slaves到一个已存在环境中 <setup_additional>`
    * :ref:`16.1.1.10 在Slave上設定Master配置 <setup_masterconfonslave>`

.. _setup_master:

设定复制master配置文件
-------------------------

* 启动binary logging 并建立唯一的server ID, 需要重启::

    [mysqld]
    log-bin=mysql-bin
    server-id=1

* 注意: 若省略 ``server-id`` 或明确指定为0，这个master拒绝所有 ``slave`` 的连接
* 注意: 在用事务、存储引擎为 ``InnoDB`` 的复制建立时，为最大可能的持久性和一致性，你应该在 ``master`` 的 ``my.cnf`` 文件中使用::

    innodb_flush_log_at_trx_commit=1
    sync_binlog=1

* 注意: 要确保 ``skip-networking`` 选项在master节点上設定为enabled。如果网络断了，你的slave不能与master进行交流，复制就会失败。



.. _setup_slave:

設定复制时slave的配置文件
--------------------------

* 建立唯一的server ID。需要重启::

    [mysqld]
    server-id=2

* 注意: 若省略 ``server-id`` 或明确指定为0，这个slave拒绝连接master

* binary logging在slave下不是必需的，但可以做备份或其他用途

.. _setup_newuser:

为复制创建一个用户
---------------------

* 在master下要有一个具有 ``REPLICATION SLAVE`` 权限的用户。
* 这个用户会明文存放在 ``master.info`` 文件下(所以为了安全，你最好建立一个只用于复制的最小权限的用户)
* 实例: 建立一新用户 ``repl`` ，可以从任何主机名带 ``mydomain.com`` 域复制::

    mysql> CREATE USER 'repl'@'%.mydomain.com' IDENTIFIED BY 'slavepass';
    mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%.mydomain.com';

.. _setup_binlog:

得到复制Master二进制日志调整
-------------------------------

* 为在slave下配置复制，你必须在master的二进制日志下得到当前坐标。然后在slave下按照此二进制日志得到正确的坐标点。
* 若在master下存在数据，你需要在启动复制前同步下master与slave。
* 停止master下的进程语句执行、得到当前binary log坐标，把数据dump出来
* 命令如下::

    master>>FLUSH TABLES WITH READ LOCK; -- can be replaced by mysqldump --master-data
    master>>SHOW MASTER STATUS; -- in a different session
    
* 如果没有启动binary logging的话, 在 ``SHOW MASTER STATUS`` 或 ``mysqldump --master-data`` 命令下，the log file name and position value都是空。这种情况下，之后你指定slave的log file和positon是用空字符串('')和4.

* 启动slave，从binary log中读二进制日志，复制正式开始。

.. _setup_snapshotdump:

用mysqldump创建数据快照
------------------------

* 锁定表更新::

    mysql>> FLUSH TABLES WITH READ LOCK;

* 在另一session中，用 ``mysqldump`` 创建一个dump(所有数据库或指定的几个数据库)::

    shell> mysqldump --all-databases --lock-all-tables > dbdump.db
    or
    shell> mysqldump --all-databases --lock-all-tables > dbdump.db

* 解锁::

    UNLOCK TABLES;

.. _setup_snapshotraw:

用Raw Data文件创建数据快照
---------------------------

如果数据库很大，比起用mysqldump，直接copy raw 数据文件更有效。

* 注意: 如果master和slave的 ``ft_stopword_file`` 、 ``ft_min_word_len`` 或 ``ft_max_word_len`` 是不同的值或copy有全文索引的表时。用这种方法不可靠！
* 如果你用 **InnoDB** 表，你可以使用Mysql企业备份组件 ``mysqlbackup`` 来生成一致性快照！此命令记录日志名和到快照的offset corresponding，这些以后可以用在slave上。但企业备份是商业的！
* 如果不想花钱，可以使用冷备份！关闭Mysql服务，拷贝所有数据文件！
* 对创建 **MyISAM** 类型的表，你可以直接拷贝文件，对它来说每个表都有一个文件！(对 **InnoDB** ，想一个表占一个文件要加 ``innodb_file_per_table`` 选项)

* 命令步骤(用 ``InnoDB`` 格式)::

    1. 增加读锁并得到master的status
    2. 在另一session中，关闭master server
    shell> mysqladmin shutdown
    3. 做个拷贝
    tar cf /tmp/db.tar ./data
    or
    zip -r /tmp/db.zip ./data
    or
    rsync --recursive ./data /tmp/dbdata
    4. 重启master server

* 命令步骤(不用 ``InnoDB`` )::

    1. 增加读锁并得到master的status
    2. 做个拷贝
    tar cf /tmp/db.tar ./data
    or
    zip -r /tmp/db.zip ./data
    or
    rsync --recursive ./data /tmp/dbdata
    3. 解锁
    mysql> ULOCK TABLES;

.. _setup_new:

設定新Master和Slave的复制
--------------------------

1. 用必须的配置属性配置MySQL master:
    :ref:`设定复制master配置文件 <setup_master>`
2. 启动 MySQL master
3. 建立一用户:
    :ref:`为复制创建一个用户 <setup_newuser>`
4. 得到master状态信息:
    :ref:`得到复制Master二进制日志调整 <setup_binlog>`
5. 在master上，释放读锁::

    mysql> UNLOCK TABLES;

6. 在slave上，编辑MySQL配置文件:
    :ref:`设定复制配置文件 <setup_slave>`

7. 启动MySQL slave
8. 运行 ``CHANGE MASTER TO`` 语句来設定master复制服务配置:
    :ref:`在Slave上設定Master配置 <setup_masterconfonslave>`


.. _setup_existdata:

在存在的数据中設定复制
------------------------
1. 在master下mysql运行的情况下，增加一个用户用于slave连接master时复制:
    :ref:`为复制创建一个用户 <setup_newuser>`
2. 如果你没有在master服务器設定好server-id或enabled binary logging，你需要关闭这个配置选项:
    :ref:`设定复制master配置文件 <setup_master>`
3. 弄个快照和master服务器状态(见前面具体文档)
4. 更新slave下的配置文档
5. 这一步信赖于你之前如何在master上创建快照

    * 如果你用 ``mysqldump``

        * 用 ``--skip-slave-start`` 选项启动slave， 这样复制就不会启动
        * 导入dump文件::

            shell> mysql < fulldb.dump

    * 如果你用raw数据文件创建快照:

        * 解压数据文件到slave数据目录下，如::

            shell > tar xvf dbdump.tar

        * 用 ``--skip-slave-start`` 选项启动slave

6. 在slave上配置(用之前master下的复制坐标)。这会告诉slave在复制启动时所需的binary log file和position within the file。也需要在slave上配置登录认证和master的主机名。更多信息请察看:
    :ref:`在Slave上設定Master配置 <setup_masterconfonslave>`
7. 启动slave线程::

    mysql> START SLAVE;

   * 如果你忘记为master設定server-id,slave将不能连接
   * 如果你忘记为slave設定server-id,你会得到如下错误::

       Warning: You should set server-id to a non-0 value if master_host
       is set; we will force server id to 2, but this MySQL server will
       not act as a slave.

   * 你也有可能在slave的错误日志中发现因其他原因不能复制导致的错误信息。
   * 一但成功复制，你就可以在slave下的数据目录下得到两个文件 ``master.info`` 和 ``relay-log.info`` 。这个slave用这两个文件来记录master产生的二进制日志文件。除非你完全明白，否则不要移动或修改这两个文件。即使你完全理解，也最好是用语句 ``CHANGE MASTER TO`` 命令来改变复制参数。slave将用语句中对应的值来自动改变这些状态文件。

注意:  ``master.info`` 文件中的内容覆盖了一部分在命令行或 ``my.cnf`` 文件中的选项。 具体请察看:
http://dev.mysql.com/doc/refman/5.5/en/replication-options.html

此步骤可用于增加多个slave


.. _setup_additional:

介绍额外的Slaves到一个已存在的复制环境
----------------------------------------

本操作不用停止master。
1. 停止一个存在的slave::

    shell> mysqladmin shutdown

2. 拷贝已经存在的slave下的数据目录到新的slave下。记得要拷贝log文件和relay log文件
   在增加一个新的复制slave时，一种常见的问题是像如下一样的错误信息::

    071118 16:44:10 [Warning] Neither --relay-log nor --relay-log-index were used; so
    replication may break when this MySQL server acts as a slave and has his hostname
    changed!! Please use '--relay-log=new_slave_hostname-relay-bin' to avoid this problem.
    071118 16:44:10 [ERROR] Failed to open the relay log './old_slave_hostname-relay-bin.003525'
    (relay_log_pos 22940879)
    071118 16:44:10 [ERROR] Could not find target log during relay log initialization
    071118 16:44:10 [ERROR] Failed to initialize the master info structure

这种情况一般原因是: ``--relay-log`` 没有被指定，relay log文件把主机名作为它们文件名的一部分。
为避免这种情况，在两个slave间选项 ``--relay-log`` 用相同的值(如果这个选项中已存在的slave中没有明确指定，使用 ``existing_slave_hostname-relay-bin`` 选项)。如果这种方式不可行，拷贝slave的relay日志文件到新slave上并設定 ``--relay-log-index`` 选项来匹配已存在的slave的relay日志索引文件(如果这选项在已存在的slave中没有明确指定，使用 ``existing_slave_hostname-relay-bin.index``)。

另. 如果你在此session中，执行完如下剩余的步骤后，启动了一个新的slave，那么需要运行如下命令:

    * 如果你还没有完全做完，在新slave中 issue a STOP SLAVE.
      如果你已经重新启动了existing slave，在existing slave上也要issue a STOP SLAVE.
    * copy存在slave的relay日志索引文件到新的slave的relay 日志索引文件，确信覆盖已经存在的任何内容
    * 运行本节已经存在的步骤

3. 从存在的slave copy ``master.info`` 和 ``relay-log.info`` 文件到新的slave文件。这些文件保存着master的二进制日志和slave 的relay日志的当前log coordinates.
4. 启动存在的slave
5. 在一个新的slave下编辑配置文件，给这个slave一个唯一的server-id
6. 启动这个slave，这个slave会用 ``master.info`` 文件来启动复制进程

.. _setup_masterconfonslave:

在Slave上設定Master配置
-------------------------

为設定slave与master为复制进行交互。你必须要告诉些slave一些必须的连接信息。为做到这点，需要运行如下语句(替换你系统相关选项值)::

    mysql> CHANGE MASTER TO
    ->     MASTER_HOST='master_host_name',
    ->     MASTER_USER='replication_user_name',
    ->     MASTER_PASSWORD='replication_password',
    ->     MASTER_LOG_FILE='recorded_log_file_name',
    ->     MASTER_LOG_POS=recorded_log_position;

注意: 复制不能用Unix socket文件，你一定能用tcp/ip连接到master mysql服务器。
语句 ``CHANGE MASTER TO`` 也有其他选项。如，你可以用SSL来建立一个安全的复制。想了解全部的选项或这个string-valued选项的最大允许长度，请察看 http://dev.mysql.com/doc/refman/5.5/en/change-master-to.html





   
binary log中事件记录中的格式，有statement-based replication(SBR基于语句复制)、row-based replication(RBR基于行复制)还有第三种mixed-format replication(MIXED混合复制)。详见:
   
