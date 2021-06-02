.. _mysql_user:

用户使用命令
===============

增加管理员用户命令::

    mysqladmin -h hostname -u root -p password 1234 //修改用户的密码

新增用户(前提:用root用户进入mysql客户端):
-------------------------------------------

方法一::

    use mysql;//进入mysql数据库
    INSERT INTO user (Host,User,Password) VALUES('%','新用户名',PASSWORD('新密码'));
    flush privileges;//更新权限

方法二(给主机为localhost增加用户)::

    insert into mysql.user(Host,User,Password) values("localhost","新用户名",password("新密码"));
    flush privileges;//更新权限

方法三(给域名为'%.mydomain.com'增加用户)::

    INSERT INTO user (Host,User,Password) VALUES('%.mydomain.com','myname',PASSWORD('mypass'));

mysql5.7新规则::

    //password字段改为authentication_string
    CREATE USER '<username>'@'<host>' IDENTIFIED BY '<password>';
    如:
    CREATE USER 'puer'@'%' IDENTIFIED BY 'Q!W@e3r4';

创建用户同时授权::

    grant all privileges on mq.* to test@localhost identified by '1234';

修改用户密码:
--------------

方法一(mysql5.7通用)::

    use mysql;//进入mysql数据库
    SET PASSWORD FOR 'user'@'hostname' = PASSWORD('passwordhere');
    flush privileges;//更新权限

方法二::

    update mysql.user set password=password('新密码') where User="用户名" and Host="localhost";
    flush privileges;

删除用户
----------

方法::

     DELETE FROM user WHERE User="用户名" and Host="localhost";
     flush privileges;

为用户授权
-----------

方法一::

    create database 新DB;
    grant select,update on 新DB.* to 用户名@localhost identified by '1234'; %% 指定部分权限给一用户
    flush privileges; %% 刷新系统权限表

方法二::

    GRANT 许可权限 ON 库名.表名 TO 新用戶名@主机名 IDENTIFIED BY ‘密码‘;
    -- 全部许可权限用:all
    -- 全部库的全部表用:*.*
    -- 用户abc的所有主机名用:abc@'%'
    grant all on dataBaseName.* to userName@localhost identified by ‘passwd‘;

    //赋予复制权限
    grant replication slave on *.* to 'replication'@'%';

    // 可以将自己拥有的权限授权给别人
    grant all privileges on *.* to jack@'localhost' identified by "jack" with grant option;




权限列表::

    select  # 查询 数据库中所有表数据的权利
    update      # 插入 
    insert  # 更新
    delete      # 删除 数据库中所有表数据的权利
    create  # 创建 MySQL 数据表结构
    drop    # 删除 MySQL 数据表结构
    alter       # 修改 MySQL 数据表结构
    references  # 操作 MySQL 外键权限
    create temporary tables# 操作 MySQL 临时表权限
    index       # 操作 MySQL 索引权限
    create view     # 操作 MySQL 视图
    show view       # 查看视图源代码
    create routine  # 操作 MySQL 存储过程、函数 权限
    alter  routine
    execute
    all privileges    # 关键字 “privileges” 可以省略
    replication

取消用户授权
-----------------

方法一::

    revoke all on *.* from sss@localhost ;

查看 MySQL 用户权限
-------------------------

查看当前用户（自己）权限::

    show grants;

查看其他 MySQL 用户权限::

    show grants for dba@localhost;

