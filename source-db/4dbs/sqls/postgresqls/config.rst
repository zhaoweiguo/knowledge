配置文件
########

查看配置文件的位置::

    postgres=# select name, setting from pg_settings where category='File Locations';
           name        |                 setting                 
    -------------------+-----------------------------------------
     config_file       |/var/lib/pgsql/<version>/data/postgresql.conf
     data_directory    | /var/lib/pgsql/<version>/data
     external_pid_file | 
     hba_file          | /var/lib/pgsql/<version>/data/pg_hba.conf
     ident_file        | /var/lib/pgsql/<version>/data/pg_ident.conf

关键的设置::

    postgres=# select name,context,unit,setting,boot_val,reset_val from pg_settings 
        where name in('listen_addresses','max_connections','shared_buffers',
            'effective_cache_size','work_mem','maintenance_work_mem')
        order by context, name;
             name         | context   | unit | setting |boot_val  | reset_val 
    ----------------------+------------+------+---------+-----------+-----------
     listen_addresses     | postmaster |      | *      | localhost | *
     max_connections      | postmaster |      | 100    | 100       | 100
     shared_buffers       | postmaster | 8kB  | 16384  | 1024      | 16384
     effective_cache_size | user       | 8kB | 524288  | 524288    | 524288
     maintenance_work_mem | user       | kB  | 65536   | 65536     | 65536
     work_mem             | user       | kB  | 4096    | 4096      | 4096
    (6 rows)




选项
====

2.1. 连接与认证
---------------

2.1.1 连接设置
''''''''''''''

.. option:: listen_addresses (string)

    这个参数只有在启动数据库时，才能被设置。
    它指定数据库用来监听客户端连接的 TCP/IP 地址。
    默认是值是 * ，表示数据库在启动以后将在运行数据的机器上的所有的 IP 地址上监听用户请求。
    可以写成机器的名字，也可以写成 IP 地址，不同的值用逗号分开，例如，’server01’, ’140.87.171.49, 140.87.171.21’。
    如果被设成 localhost，表示数据库只能接受本地的客户端连接请求，不能接受远程的客户端连接请求。



2.2 资源消耗
------------


.. option:: share_buffers

    用于缓存最近访问过的数据页的内存区大小，所有用户会话均可共享此缓存区。
    一般来说越大越好，至少应该达到系统总内存的 25%，但不宜超过 8GB，因为超过后会出现 “边际收益递减” 效应。
    不能小于 128KB。默认值是 1024，每个数据块的大小是 8KB
    默认单位是数据块的个数:
    1. 如果把它的值设成 8，因为每个数据块的大小是 8KB，则数据缓冲区的大小是 8*8=64KB
    2. 如果将它的值设成 128MB，则数据缓冲区的大小是 128MB
    需重启 postgreSQL 服务

.. option:: effective_cache_size

    一个查询执行过程中可以使用的最大缓存，包括操作系统使用的部分以及 PostgreSQL 使用部分，系统并不会根据这个值来真实地分配这么多内存，但是规划器会根据这个值来判断系统能否提供查询执行过程中所需的内存。如果将此设置设得过小，远远小于系统真实可用内存量，那么可能会给规划器造成误导，让规划器认为系统可用内存有限，从而选择不使用索引而是走全表扫描（因为使用索引虽然速度快，但需要占用更多的中间内存）。

    在一台专用于运行 PostgreSQL 数据库服务的服务器上，建议将 effective_cache_size 的值设为系统总内存的一半或者更多。
    此设置可动态生效，执行重新加载即可。
    单位是 KB，默认值是 16384。

.. option:: work_mem

    此设置指定了用于执行排序，哈希关联，表扫描等操作的最大内存量。
    此设置可动态生效，执行重新加载即可。
    单位是 KB，默认值是 1024。

.. option:: mintenance_work_mem

    此设置指定可用于 vaccum 操作（即清空已标记为 “被删除” 状态的记录）这类系统内部维护操作的内存总量。
    其值不应大于 1GB。
    此设置可动态生效，执行重新加载即可。

.. option:: effective_cache_size

    它影响系统何时启动一个检查点操作。
    设置单个查询可以使用的数据缓冲区的大小。
    默认值是 128MB。





2.3 事务日志
------------

.. option:: full_page_writes

    这个参数只能在 postgresql.conf 文件中被设置。
    默认值是 on。
    打开这个参数，可以提高数据库的可靠性，减少数据丢失的概率，但是会产生过多的事务日志，降低数据库的性能。




2.4 检查点
----------

.. option:: checkpoint_segments

    如果上次检查点操作结束以后，系统产生的事务日志文件的个数超过 checkpoint_segments 的值，系统就会自动启动一个检查点操作。
    增大这个参数会增加数据库崩溃以后恢复操作需要的时间。
    默认值是 3。
    这个参数只能在 postgresql.conf 文件中被设置。

.. option:: checkpoint_timeout

    它影响系统何时启动一个检查点操作。
    如果现在的时间减去上次检查点操作结束的时间超过了 checkpoint_timeout 的值，系统就会自动启动一个检查点操作。
    增大这个参数会增加数据库崩溃以后恢复操作需要的时间。
    这个参数只能在 postgresql.conf 文件中被设置。
    单位是秒，默认值是 300。

.. option:: checkpoint_completion_target

    不要轻易地改变这个参数的值，使用默认值即可。 这个参数只能在 postgresql.conf 文件中被设置。
    这个参数控制检查点操作的执行时间
    合法的取值在 0 到 1 之间，默认值是 0.5。

2.5 归档模式
------------

.. option:: archive_mode

    这个参数只有在启动数据库时，才能被设置。
    默认值是 off。
    它决定数据库是否打开归档模式。

2.6 优化器参数
--------------

2.6.1 存取方法参数
''''''''''''''''''

下列参数控制查询优化器是否使用特定的存取方法。除非对优化器特别了解，一般情况下，使用它们默认值即可。

.. option:: enable_bitmapscan (boolean)

    打开或者关闭 bitmap-scan 。默认值是 on。

2.7 数据库运行日志配置参数
--------------------------

.. option:: log_directory (string)

    这个参数只能在 postgresql.conf 文件中被设置。
    它决定存放数据库运行日志文件的目录。
    默认值是 pg_log。可以是绝对路径，也可是相对路径（相对于数据库文件所在的路径）。

2.8 数据库运行统计参数
----------------------

下面的参数控制是否搜集特定的数据库运行统计数据：

.. option:: track_activities (boolean)

    是否收集每个会话的当前正在执行的命令的统计数据，包括命令开始执行的时间。
    默认值是 on。只有超级用户才能修改这个参数。

2.9 自动垃圾收集相关参数
------------------------

下面的参数控制自动垃圾收集的行为：

.. option:: autovacuum (boolean)

    控制是够打开数据库的自动垃圾收集功能。
    默认值是 on。
    如果 autovacuum 被设为 on，参数 track_counts 也要被设为 on，自动垃圾收集才能正常工作。

    注意，即使这个参数被设为 off，如果事务 ID 回绕即将发生，数据库会自动启动一个垃圾收集操作。
    这个参数只能在文件 postgresql.conf 中被设置。

2.10 锁管理参数
---------------

.. option:: deadlock_timeout(integer)

    设置死锁超时检测时间。
    单位是微秒，默认值是 1000。
    死锁检测是一个消耗许多 CPU 资源的操作。
    这个参数的值不能太小。在数据库负载比较大的情况下，应当增大这个参数的值。

2.11 系统预设参数
-----------------

这些参数系统启动后会自动设置，用户只能查询它们的值，不能用任何方式修改这些参数。

.. option:: block_size (integer)
  
    报告数据库文件数据块的大小。

2.12 其它参数
-------------

.. option:: default_with_oids (boolean)
  
    该参数控制 CREATE TABLE 和 CREATE TABLE AS 命令是否给新建的表添加一个系统列 OID。
    默认值是 off。
    如果它的值是 on:
    CREATE TABLE 和 CREATE TABLE AS 命令
    在没有指定 WITH OIDS 和 WITHOUT OIDS 子句的情况下，
    新建的表将包含系统列 OID，
    同时 SELECT INTO 命令也会将系统列 OID 添加到新建的表中去。




操作命令
========

修改参数命令::

    Alter system set work_mem=8192;

设置重新加载命令::

    Select pg_reload_conf();

配置文件的重新加载::

    /usr/pgsql-9.6/bin/pg_ctlreload -D /var/lib/pgsql/9.6/data/ 
    systemctlreload postgresql-9.6.service 
    selectpg_reload_conf();



参考
====

* PostgreSQL 数据库配置文件之 postgresql.conf 全部参数详解: https://blog.csdn.net/prettyshuang/article/details/50495347





