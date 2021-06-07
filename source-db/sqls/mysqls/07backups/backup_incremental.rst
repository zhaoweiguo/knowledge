.. _backup_incremental:

7.5 使用Binary Log工具恢复按时间点增量备份
============================================

* 按时间点恢复是从给定的时间点恢复数据。一般是从全备份恢复后，再增量恢复时！

* 按时间点恢复基于如下几个原则:

    * 使用此增量备份是使用在全文备份后的binary log files。因为服务必须要以 ``--log-bin`` 选项开启二进制日志。

        * 要想使用二进制日志重新存储数据，你必须知道当前二进制日志文件的名字与位置
        * 查看所有二进制日志文件列表，使用如下語句::

            mysql> SHOW BINARY LOGS;

        * 查看当前是哪个二进制日志文件::

            mysql> SHOW MASTER STATUS;

    * 使用 ``mysqlbinlog`` 工具把二进制文件中的事件从二进制格式转化为文本格式::

        shell> mysqlbinlog binlog_files | mysql -u root -p

    * 察看二进制文件中事件::

        shell> mysqlbinlog binlog_files | more

    * 如果有多个二进制文件进行增量恢复时，最好是在一个连接上执行:

        * 这个方法就不安全::

            shell> mysqlbinlog binlog.000001 | mysql -u root -p # DANGER!!
            shell> mysqlbinlog binlog.000002 | mysql -u root -p # DANGER!!

        * 不安全的原因是，第一个连接时可能会建立临时表，第二次连接时可能会用到这个临时表
        * 解决方案一::

            shell> mysqlbinlog binlog.000001 binlog.000002 | mysql -u root -p

        * 解决方案二::

            shell> mysqlbinlog binlog.000001 >  /tmp/statements.sql
            shell> mysqlbinlog binlog.000002 >> /tmp/statements.sql
            shell> mysql -u root -p -e "source /tmp/statements.sql"


.. _bakcup_incremental_times:

使用Event Times时间点恢复
--------------------------

* 在命令 ``mysqlbinlog`` 中使用 ``--start-datetime`` 和 ``--stop-datatime`` 选项
* 重新执行从某一日期到这段二进制日志最后备份，运行如下命令::

    shell> mysqlbinlog --stop-datetime="2005-04-20 9:59:59" \
         /var/log/mysql/bin.123456 | mysql -u root -p

* 重新执行下从这段二进制日志开始到某一日期间的备份，运行如下命令::

    shell> mysqlbinlog --start-datetime="2005-04-20 10:01:00" \
         /var/log/mysql/bin.123456 | mysql -u root -p

* 可以把这段时间段内的二进制数据记录察看::

    shell> mysqlbinlog /var/log/mysql/bin.123456 > /tmp/mysql_restore.sql

.. _backup_incremental_positions:

使用Event Positions时间点恢复
--------------------------------

* 在上面的基础上可以实现的更精确的操作
* 先用上面的方法查到 **log_pos** ，然后使用::

    shell> mysqlbinlog --stop-position=368312 /var/log/mysql/bin.123456 \
         | mysql -u root -p

