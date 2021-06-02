mysqldump--数据库备份程序
================================

* mysqldump一般是会创建一个dump文件，里面包含创建表、填充表！但它也可以用于生成CSV文件，其他限定的文本或XML格式！
* mysqldump命令权限说明:

    * dump table操作需要至少有一个 ``SELECT`` 权限来
    * dump views操作需要 ``SHOW VIEW`` 权限
    * 如果 ``--single-transaction`` 选项 **没有** 被用，需要 ``LOCK_TABLE`` 权限！
    * 其他的选项可以需要其他权限

* 如果表全是MyISAM表，建议使用 ``mysqlhotcopy`` 命令备份，因为这种方法会快速备份、快速恢复！
* 以下是三种使用 ``mysqldump`` 命令的方法::

    shell> mysqldump [options] db_name [tbl_name ...]
    shell> mysqldump [options] --databases db_name ...
    shell> mysqldump [options] --all-databases

* 说明如果db_name没有指定或使用后面两种方法，整个数据库都会被复制！
* mysqldump默认不会dump ``INFORMATTION——SCHEM`` 数据库！你必须在命令行使用  ``--skip-lock-tables`` 选项明确指定(在MySQL5.5之前即使你明确指定也会忽略这个DB)！
* mysqldump不会dump数据库performance_schema
* mysqldump也不会dump MySQL Cluster **ndbinfo** 信息数据库
* 一些选项是其他一组选项的集合:

    * --opt(默认带有些选项)::

        --add-drop-table
        --add-locks
        --addcreate-options
        --disable-keys
        --extended-insert
        --lock-tables
        --quick
        --set-charset

    * --compact::

        --skip-add-drop-table
        --skip-add-locks
        --skip-comments
        --skip-disable-keys
        --skip-set-charset

* 使用格式 ``--skip-xxx`` 来反转选项作用，如 ``--skip-opt`` 和 ``--skip-comact`` 选项
* 实例说明::

    --opt --skip-extended-insert --skip-quick
    --skip-opt --disable-keys --lock-tables

* mysqldump有两种方式dump数据:

    * 一行行的萃取并dump表内容(使用 ``--quick`` 命令)
    * 从一个表中萃取整个内容并且在dump数据前先把数据缓存到内存中(这种方法在大表时可能会出问题，使用 ``--skip-quick`` 选项)


* 其他选项列表参看:

    http://dev.mysql.com/doc/refman/5.5/en/mysqldump.html
