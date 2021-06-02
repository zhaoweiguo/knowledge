.. _mysql-proxy_config:

MySQL代理配置
#######################

::

    --daemon 采用daemon方式启动
    --admin-address=:4401 指定mysql proxy的管理端口，在这里，表示本机的4401端口
    --proxy-address=:3307 指定mysql proxy的监听端口，也可以用 127.0.0.1:3307 表示
    --proxy-backend-addresses=:3306 指定mysql主机的端口
    --proxy-read-only-backend-addresses=192.168.1.1:3306 指定只读的mysql主机端口
    --proxy-read-only-backend-addresses=192.168.1.2:3306 指定另一个只读的mysql主机端口
    --proxy-lua-script=/usr/local/share/mysql-proxy/rw-splitting.lua 指定lua脚本，在这里，使用的是rw-splitting脚本，用于读写分离



MySQL配置文件实例
-----------------------

.. literalinclude:: /files/mysqls/mysql_mysql-proxy.cnf
    :language: sh
    :linenos:
