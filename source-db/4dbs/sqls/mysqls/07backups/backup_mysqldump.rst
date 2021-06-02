.. _backup_mysqldump:

7.4 使用mysqldump命令备份
==========================

* 本章描述如何使用 ``mysqldump`` 命令来产生dump文件，或重载这些文件！
* dump文件有以下几种方式:

    * 备份以防数据丢失
    * 作为数据源用于設定replication slaves
    * 用于实践的数据源

        * 在不改变源始数据的情况下，对DB作个拷贝
        * 测试潜在升级兼容性

* 依据是否有选项 ``tab`` mysqldump会生成两种类型的输出:

    * 没有 ``--tab``:
       mysqldump会写入标准的输出！这个输出包含create、insert的数据！

    * 有 ``--tab``:
       mysqldump会写出两个文件，一个是tbl_name.sql，一个是tbl_name.txt！


.. _backup_mysqldump_dumpsql:

7.4.1 使用mysqldump命令dump SQL格式的数据
------------------------------------------

* 如果想让生成的dump数据，执行时，每次都删除原来的数据库之后再重新创建它,需要使用如下选项::

    --add-drop-database
* 备份一个数据库有两种方法::

    shell> mysqldump --databases test > dump1.sql
    or
    shell> mysqldump test > dump2.sql

* 说明:
  这两种方法的不同是，第一种方法是有 ``CREATE DATABASE`` 和 ``USE`` 語句。

.. _backup_mysqldump_reloadsql:

7.4.2 使用mysqldump命令重新载入SQL格式的数据
---------------------------------------------
* 普通方法::

    shell> mysql < dump.sql

* source方法::

    mysql> source dump.sql

.. _backup_mysqldump_dumptext:

7.4.3 使用mysqldump命令dump限定文本格式的数据
----------------------------------------------

* 命令::

    shell> mysqldump --tab=/tmp db1

* 在目录/tmp下，数据库db1下，每个数据表生成两个文件(table.sql和table.txt)

    * table.sql: 创建生成表的sql語句
    * table.txt: 表中数据，每行一条数据！字段间用“换行符”分隔

* 注意:

    使用 ``--tab`` 选项时，最好是在本地执行。如果在远程执行，注意指定的path在本地和远程都有这个目录。最后table.sql会生成到本地而table.txt则会生成到远程目录。

* 各选项说明:

    * --fields-terminated-by=str: 字段间的分隔符(默认是“制表符”)
    * --fields-enclosed-by=char: 包围字段值的字符(默认是空字符)
    * --fields-optionally-enclosed-by=char: 包围字段值中非数字值的字符(默认为空字符)
    * --fields-escaped-by=char: 
    * --lines-terminated-by=str: 行结束符(默认是一新行)

* 实例1::

    hell> mysqldump --tab=/tmp 

* 結果1(table.txt文件内容)::

    1   1111111
    2   2222222
    3   33333333
    4   4444444

* 实例2::

    shell> mysqldump --tab=/tmp --fields-terminated-by=,
         --fields-enclosed-by='"' --lines-terminated-by=0x0d0a db1

* 結果2(table.txt文件内容)::

    "1","1111111"
    "2","2222222"
    "3","33333333"
    "4","4444444"


.. _backup_mysqldump_reloadtext:

7.4.4 使用mysqldump命令重新载入限定文本格式的数据
------------------------------------------------------

* 使用命令 ``mysqldump --tab`` 会生成两个文件.sql文件与.txt文件！
* 还原时，有以下两种方法:

    * shell脚本方法::

        shell> mysql db1 < t1.sql
        shell> mysqlimport db1 t1.txt

    * mysql方法::

        mysql> USE db1;
        mysql> LOAD DATA INFILE 't1.txt' INTO TABLE t1;

* 如果在备份时使用了其他选项，则在还原的时候也要使用这些选项:

    * shell脚本方法::

        shell> mysqlimport --fields-terminated-by=,
         --fields-enclosed-by='"' --lines-terminated-by=0x0d0a db1 t1.txt

    * mysql方法::

        mysql> USE db1;
        mysql> LOAD DATA INFILE 't1.txt' INTO TABLE t1
            -> FIELDS TERMINATED BY ',' FIELDS ENCLOSED BY '"'
            -> LINES TERMINATED BY '\r\n';

.. _backup_mysqldump_tip:

7.4.5 mysql标注
-----------------

* 拷贝一个数据库:

    * 命令::

        shell> mysqldump db1 > dump.sql
        shell> mysqladmin create db2
        shell> mysql db2 < dump.sql


    * 注意:
      不要使用 ``--databases`` 选项！因为它生成的.sql文件有 ``USE db1`` 命令，不会写入db2中。

* 把一个数据库从一个服务器拷贝到另一个服务器:

    1. 在服务器1上执行::

        shell> mysqldump --databases db1 > dump.sql

    2. 拷贝到服务器2上
    3. 在服务器2上执行::

        shell> mysql < dump.sql

    * 注意:
      记得加选项 ``--databases`` 如果不加，记得自己手工创建数据库

* Dumping存储的programs(存储过程、函数、事件与触发器)

    * 以下几个选项与存储programs相关:

        * ``--events``: dump出事件选项
        * ``--routines``: dump出存储过程与函数
        * ``--triggers``: 为表dump出触发器
        * 注意: --triggers默认是启用的，所以默认下表dump出来的时候，触发器也dump出来！

* 分别dump出表定义与内容

    * 只dump出定义::

        shell> mysqldump --no-data test > dump-defs.sql

    * 只dump出数据::

        shell> mysqldump --no-create-info test > dump-data.sql

   * 一个只dump定义，增加 ``--routines`` 和 ``--events`` 选项::

       shell> mysqldump --no-data --routines --events test > dump-defs.sql

* 使用 **mysqldump** 来测试升级的可兼容性:

    * 首先导出表结构::

        -- 在生产服务器上
        shell> mysqldump --all-databases --no-data --routines --events > dump-defs.sql
        -- 在升级的服务器上:
        shell> mysql < dump-defs.sql

    * 再导出表数据::

        -- 在生产服务器上
        shell> mysqldump --all-databases --no-create-info > dump-data.sql
        -- 在升级的服务器上:
        shell> mysql < dump-data.sql


MySQL的Import and Export
-------------------------------

**导出操作**

    * 导出整个数据库::

        mysqldump -umysql -psa dataBaseName > fileName.sql

    * 导出一个表::

        mysqldump -umysql -psa dataBaseName tablename > fileName.sql

    * 仅仅备份数据库结构::

        mysqldump --no-data --databases databasename1 databasename2 databasename3 > fileName.sql

    * 备份服务器上所有数据库::

        mysqldump --all-databases > fileName.sql

    * 

**导入数据**

    * 把sql文件导入到指定数据库下(命令行方式)::

        mysql -hhostname -uusername -ppassword databasename < fileName.sql

    * 把sql文件导入到指定数据库下(sql命令行方式)::

        mysql -u root -psa
        mysql> use dataBaseName;
        mysql> source /path/to/fileName.sql

    * 其他::

        use /Users/venmos/backup.sql //导入/Users/venmos/目录的backup.sql数据库


