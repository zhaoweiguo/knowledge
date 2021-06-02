.. _backup_method:

7.2 数据库备份方法
===================

* 使用拷贝表文件的方式备份:

    为了一致性，使用如下方法加一读锁::

        FLUSH TABLES tbl_list WITH READ LOCK;

    你可以使用命令 ``mysqlhotcopy`` 进行热备份。(此方法对InnoDB不生效，因为InnoDB不一定会把表数据存储到数据库目录中，还有就是，即使服务不主动更新数据，InnoDB依然有在内存中修改但还没有flush到磁盘上的数据)

