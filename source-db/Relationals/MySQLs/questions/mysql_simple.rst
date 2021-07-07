MySQL简单错误
####################

MySQL数据库无法远程连接
--------------------------
::

   /usr/local/webserver/mysql/bin/mysql -u root -h 172.29.141.112  -p -S /tmp/mysql.sock
   Enter password:
   ERROR 2003 (HY000): Can't connect to MySQL server on '172.29.141.112' (113)
   
* 没有授予相应的权限(不是用户和密码问题，因为那会报别的error)
* 防火墙禁止了3306端口或DB没有使用3306端口
* 修改MySQL的配置文件 ``/etc/mysql/my.cnf`` ::

    # bind-address = 127.0.0.1

* my.cnf 配置文件中 skip-networking 被配置::

    skip-networking 这个参数，导致所有TCP/IP端口没有被监听,也就是说除了本机
    其他客户端都无法用网络连接到本mysql服务器
    所以需要把这个参数注释掉

除了以上原因还有::

  1. 可能网络连接问，远程ping xxx.xxx.xxx.xx，使用ping命令测试
  2. 排查DNS解析问题,检查是否设置了： skip_name_resolve。 这个情况肯定不可能，因为我用的是ip,不是主机名
     [mysqld]
     skip_name_resolve
  3. MySQL port不是默认3306
    


root用户不能给新用户赋值权限
---------------------------------
::

    // 给此用户指定DB的权限
    ERROR 1044 (42000): Access denied for user 'root'@'localhost' to database '<DB>'
    // 给此用户全部DB的权限
    ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)

    // 原因
    root用户没有with grant option权限
    给user表的grant_priv值赋为Y,然后flush privilege;


debian机器在直接拷贝MySQL数据文件后启动问题
-----------------------------------------------
::

   error: 'Access denied for user 'debian-sys-maint'@'localhost' (using password: YES)
   操作:
   使用/etc/init.d/mysql restart时不起作用
   原因:
   使用apt-get安装MySQL时会自动生成debian-sys-maint用户，此用户用于debian中mysql的重启工作
   重启服务会使用/etc/mysql/debian.cnf里的配置



