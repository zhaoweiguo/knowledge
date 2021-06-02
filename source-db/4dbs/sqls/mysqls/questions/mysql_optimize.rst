MySQL优化相关
=====================

MySQL在远程访问时非常慢的解决skip-name-resolve 并且出现Reading from net
--------------------------------------------------------------------------------
::

   [mysqld]
   skip-name-resolve

unauthenticated user 解决办法
---------------------------------
::

   mysql>show processlist;
   | 20681949 | unauthenticated user | A.B.C.D:52497 | NULL | Connect | | Reading from net | NULL |
   | 20681948 | unauthenticated user | W.X.Y.Z:52495 | NULL | Connect | | Reading from net | NULL |
   // 由一个客户端发起的连接，但是这个客户端用户还没有被认证
   // 这种情况一般在系统负载比较高或者mysql比较繁忙的时候遇到
   How to repeat:
   This issue happens when the database size is more than 1GB and are connected to the busy web application powered by PHP engine.

   http://dev.mysql.com/doc/refman/5.1/en/show-processlist.html


   
MySQL导出的SQL语句在导入时有可能会非常慢问题
-------------------------------------------------

在处理百万级数据的时候，可能导入要花几小时。在导出时合理使用几个参数，可以大大加快导 入的速度::

    --max_allowed_packet=XXX 客户端/服务器之间通信的缓存区的最大大小;
    --net_buffer_length=XXX TCP/IP和套接字通信缓冲区大小,创建长度达net_buffer_length的行。
    // 注意：max_allowed_packet 和 net_buffer_length 不能比目标数据库的设定数值 大，否则可能出错
    // 首先确定目标数据库的参数值
    mysql> show variables like 'max_allowed_packet';
    mysql> show variables like 'net_buffer_length';

    // 实例
    # mysqldump -uroot -p123 21andy -e --max_allowed_packet=16777216 --net_buffer_length=16384 > 21andy.sql


