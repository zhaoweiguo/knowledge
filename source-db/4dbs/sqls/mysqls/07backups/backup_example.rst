.. _backup_example:

7.3 备份与恢复机制实例
=======================

* 以下几种类型崩溃后需要进行备份恢复:

    * 操作系统崩溃
    * 电源断开
    * 文件系统崩溃
    * 硬件问题(硬件驱动、主板等)

* 以InnoDB来说，出现如下崩溃，MySQL会自动恢复::

    InnoDB: Database was not shut down normally.
    InnoDB: Starting recovery from log files...
    InnoDB: Starting log scan based on checkpoint at
    InnoDB: log sequence number 0 13674004
    InnoDB: Doing recovery: scanned up to log sequence number 0 13739520
    InnoDB: Doing recovery: scanned up to log sequence number 0 13805056
    InnoDB: Doing recovery: scanned up to log sequence number 0 13870592
    InnoDB: Doing recovery: scanned up to log sequence number 0 13936128
    ...
    InnoDB: Doing recovery: scanned up to log sequence number 0 20555264
    InnoDB: Doing recovery: scanned up to log sequence number 0 20620800
    InnoDB: Doing recovery: scanned up to log sequence number 0 20664692
    InnoDB: 1 uncommitted transaction(s) which must be rolled back
    InnoDB: Starting rollback of uncommitted transactions
    InnoDB: Rolling back trx no 16745
    InnoDB: Rolling back of trx no 16745 completed
    InnoDB: Rollback of uncommitted transactions completed
    InnoDB: Starting an apply batch of log records to the database...
    InnoDB: Apply batch completed
    InnoDB: Started
    mysqld: ready for connections


.. _backup_example_policy:

建立一个备份机制
-----------------

* 备份操作:

    * 命令::

        shell> mysqldump --single-transaction --all-databases > backup_date_1_pm.sql

    * 选项 ``--single-transaction``:
      对InnoDB来说，一致性读，确保由 ``mysqldump`` 看到的数据不会改变(其他客户端引起的改变不会被 ``mysqldump`` 看到)。
      对非事务性表来说(如MyISAM)，一致性需要在备份的过程中不能修改。对MyISAM类型表来说，对MySQL帐号一定不能有管理性改变。


* 全局备份是必要的，但有时不方便。它会生成很大的备份文件而且执行时间很长。最好的方法是做一个初使化的全备份、然后其余的做增量备份。

* 每次重启服务器时都会生成一个新的binary log file。
* 如下命令可以让服务器在不中断的情况下，生成新的binary log file::

    mysql> flush logs;
    or
    shell> mysqladmin flush-logs
    or
    shell> mysqldump --flush-logs... ...

* 二进制日志文件列表::

    -rw-rw---- 1 guilhem  guilhem   1277324 Nov 10 23:59 gbichot2-bin.000001
    -rw-rw---- 1 guilhem  guilhem         4 Nov 10 23:59 gbichot2-bin.000002
    -rw-rw---- 1 guilhem  guilhem        79 Nov 11 11:06 gbichot2-bin.000003
    -rw-rw---- 1 guilhem  guilhem       508 Nov 11 11:08 gbichot2-bin.000004
    -rw-rw---- 1 guilhem  guilhem 220047446 Nov 12 16:47 gbichot2-bin.000005
    -rw-rw---- 1 guilhem  guilhem    998412 Nov 14 10:08 gbichot2-bin.000006
    -rw-rw---- 1 guilhem  guilhem       361 Nov 14 10:07 gbichot2-bin.index

* 说明:

    每次gbichot2-bin.xxxxxxxx文件都会增加一个

* 二进制日志文件占用空间很大，有时需要删除日志文件::

    shell> mysqldump --single-transaction --flush-logs --master-data=2 \
         --all-databases --delete-master-logs > backup_sunday_1_PM

* 注意:
    使用命令 ``mysqldump --delete-master-logs`` 删除是非常危险的事！一定要小心！

.. _backup_example_recovery:

使用备份文件恢复
-----------------

* 把最后一次全备份恢复::

    shell> mysql < backup_sunday_1_PM.sql

* 进行多次增量备份恢复::

    shell> mysqlbinlog gbichot2-bin.000007 gbichot2-bin.000008 | mysql

.. _backup_example_summary:

备份机制总结
--------------

* 一定在运行mysql服务时加上 ``--log-bin`` 选项、甚至加上 ``--log-bin=log_name`` 选项(如果你有可靠的介质)！
* 使用命令 ``mysqldump`` 命令进行定期的全文备份
* 通过刷新日志的方式定期进行增量备份(使用命令 ``FLUSH LOGS`` or ``mysqladmin flush-logs``)
