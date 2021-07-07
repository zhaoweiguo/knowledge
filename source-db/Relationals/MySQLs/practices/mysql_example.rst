.. _mysql_example:

MySQL实例
#################





最大连接数(max_connections)
================================
* 默认是 ``100``, 建议 ``500`` (注意系统的ulimit)
* 查詢現在的max connections設定::

    select VARIABLE_VALUE from information_schema.GLOBAL_VARIABLES 
    where VARIABLE_NAME='MAX_CONNECTION';

* 查詢現在已經使用的connections數目::

    select count(*) from information_schema.PROCESSLIST;

* 配置文件修改::

    max_connections=N

* 命令修改::

    mysql> SET GLOBAL max_connections = N;

connection的逾期時間(wait_timeout and interactive_timeout)
===========================================================================
* 默认是8小时, 建议修改为10分钟，即600秒
* 配置文件下修改(需要重新启动)::

    wait_timeout = 600
    interactive_timeout = 600

* 命令修改(无需重启)::

    set global wait_timeout = 3600;
    set global interactive_timeout = 3600;



