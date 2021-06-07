oracle的简单使用
#######################

* 默认端口: 1521


* sqlplus 连接远程数据库系统::

   方式一：简易连接，不用进行网络配置，其实就是tnsname.ora文件,但只支持oracle10G以上。
   命令：sqlplus 用户名/密码@ip地址[:端口]/service_name [as sysdba]
   示例：sqlplus sys/pwd@ip:1521/test as sysdba 
   备注：使用默认1521端口时可省略输入









