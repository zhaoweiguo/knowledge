
shell操作mysql命令
-------------------
::

    -- 基本用法
    mysql -umysql -pxxx
    
    -- 解决Reading table information for completion of table and column names
    -- You can turn off this feature to get a quicker startup with -A
    mysql -umysql -pxxx -A    -- -A == --no-auto-rehash

    -- 管理操作
    mysqladmin -u root -p shutdown

    -- 导入导出
    mysqldump -uxxxx -pxxx --all-databases > xxxxx.sql
    mysql -uxxx -pxxx < xxxx.sql

