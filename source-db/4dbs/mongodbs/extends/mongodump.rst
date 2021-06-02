数据导入导出
############

mongodump
=========

::

    mongodump -u<user> -p<pwd> -h<host>:<port> -d <dbname> -o <path.bson>   # 导出

    mongorestore -u<user> -p<pwd> -h<host>:<port> --directoryperdb <path.bson>  # 把<path.bson>数据导入mongo

导出所有数据库::

    ./mongodump -u 用户名 -p 密码 -o /usr/local/server/mongodb/backup/

导出指定表::

    ./mongodump -u 用户名 -p 密码 -d <db> -c <collection> -o /usr/local/server/mongodb/backup/


mongorestore
============

常用命令格式::

    ./mongorestore -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 --drop 文件存在路径

实例::

    ./mongorestore -u 用户名 -p 密码 /usr/local/server/mongodb/backup/

mongoexport
===========

常用命令::

    ./mongoexport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 -f 字段 -q 条件导出 --type=csv -o 文件名


导出整张表::

    ./mongoexport -u 用户名 -p 密码 -d platform -c user --type=csv -f name,password -o /usr/local/server/mongodb/user.csv

mongoimport
===========

.. note:: 注意：如果导入的时候需要先删除掉原来的集合，可以再加上–drop

还原整表导出的非 csv 文件::

    ./mongoimport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 --upsert --file 文件名
    // –upsert 插入或者更新现有数据

还原部分字段的导出文件::

    ./mongoimport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 --upsertFields 字段 --file 文件名
    // –upsertFields 跟–upsert 一样，更新或者插入现有字段

还原导出的 csv 文件::

    ./mongoimport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 --type 文件类型 --headerline --upsert --file 文件名
    –type 表示文件类型
    –headline 表示不导入首行 (csv 文件的首行是表头)


还原导出的表数据::

    这里以数据库表 user 为例，将 user.csv 文件导入到数据库 user 表中
    ./mongoimport -u 用户名 -p 密码 -d platform -c user --type csv --headerline --upsert --file /usr/local/server/mongodb/user.csv --drop








