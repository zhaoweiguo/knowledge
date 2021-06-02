其他MySQL相关
=================

* 当你使用多行输入时，如果打错想放弃输入使用命令 ``\c``::

    mysql> SELECT
       -> USER()
       -> \c
    mysql>

* 巧用linux管道，让mysql执行大量脚本文件::

    cat /sqldir/*.sql | mysql -u username -p 


获取MySQL自增ID的4种方法
------------------------------

* ::

    select max(id) from tablename;

* LAST_INSERT_ID 是与table无关的::

    SELECT LAST_INSERT_ID();

* @@identity 是表示的是最近一次向具有identity属性, 是系统定义的全局变量(一般系统定义的全局变量都是以@@开头，用户自定义变量以@开头)::

    select @@IDENTITY;

* 结果对应表名记录中有个Auto_increment字段::

    SHOW TABLE STATUS;


其他
---------
    
配置文件加载顺序::

    /etc/my.cnf /etc/mysql/my.cnf /usr/local/mysql/etc/my.cnf ~/.my.cnf 





