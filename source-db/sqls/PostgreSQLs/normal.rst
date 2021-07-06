常用
####

* 官网: https://www.postgresql.org/
* git: https://git.postgresql.org/


安装
====

::

    安装 PostgreSQL 客户端:
    sudo apt-get install postgresql-client
    安装 PostgreSQL 服务器:
    sudo apt-get install postgresql
    安装图形管理界面:
    sudo apt-get install pgadmin3


* 端口: ``5432``


添加新用户和新数据库
====================

默认::

    初次安装后，默认生成:
    一个名为 postgres 的数据库
    一个名为 postgres 的数据库用户
    一个名为 postgres 的 Linux 系统用户

第一种方法，使用 PostgreSQL 控制台::

    新建一个 Linux 新用户:
    sudo adduser dbuser

    切换到 postgres 用户:
    sudo su - postgres

    使用 psql 命令登录 PostgreSQL 控制台:
    $ psql

    使用 \password 命令，为 postgres 用户设置一个密码:
    psql> \password postgres

    创建数据库用户 dbuser:
    psql> CREATE USER dbuser WITH PASSWORD 'password';

    创建用户数据库，这里为 exampledb，并指定所有者为 dbuser:
    psql> CREATE DATABASE exampledb OWNER dbuser;

    将 exampledb 数据库的所有权限都赋予 dbuser:
    psql> GRANT ALL PRIVILEGES ON DATABASE exampledb to dbuser;

第二种方法，使用 shell 命令行::

    创建数据库用户 dbuser，并指定其为超级用户:
    sudo -u postgres createuser --superuser dbuser

    登录数据库控制台，设置 dbuser 用户的密码，完成后退出控制台:
    $ sudo -u postgres psql
    psql> \password dbuser
    psql> \q

    在 shell 命令行下，创建数据库 exampledb，并指定所有者为 dbuser:
    $ sudo -u postgres createdb -O dbuser exampledb


登录数据库
==========

::

    $ psql -U dbuser -d exampledb -h 127.0.0.1 -p 5432
    // -U 指定用户，-d 指定数据库，-h 指定服务器，-p 指定端口


    $ psql exampledb
    // 使用默认 host 和默认 port

    $ psql
    // 使用当时系统用户名对应的同名数据库

控制台命令
==========

::

    \h:                   查看 SQL 命令的解释，比如 \h select
    \?:                   查看 psql 命令列表
    \l:                   列出所有数据库
    \c [database_name]:   连接其他数据库
    \d:                   列出当前数据库的所有表格
    \d [table_name]:      列出某一张表格的结构
    \du:                  列出所有用户
    \e:                   打开文本编辑器
    \conninfo:            列出当前数据库和连接的信息

数据库操作
==========

::

    # 创建新表
    CREATE TABLE user_tbl(name VARCHAR(20), signup_date DATE);

    # 插入数据
    INSERT INTO user_tbl (name, signup_date) VALUES (' 张三 ', '2013-12-22');

    # 选择记录
    SELECT * FROM user_tbl;

    # 更新数据
    UPDATE user_tbl set name = ' 李四 ' WHERE name = ' 张三 ';

    # 删除记录
    DELETE FROM user_tbl WHERE name = ' 李四 ' ;

    # 添加栏位
    ALTER TABLE user_tbl ADD email VARCHAR(40);

    # 更新结构
    ALTER TABLE user_tbl ALTER COLUMN signup_date SET NOT NULL;

    # 更名栏位
    ALTER TABLE user_tbl RENAME COLUMN signup_date TO signup;

    # 删除栏位
    ALTER TABLE user_tbl DROP COLUMN email;

    # 表格更名
    ALTER TABLE user_tbl RENAME TO backup_tbl;

    # 删除表格
    DROP TABLE IF EXISTS backup_tbl;









