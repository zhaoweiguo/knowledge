.. _configmain:

主配置文件
===========

* 创建或编辑配置文件时的注意事項:

    * 以 ``#`` 字符开头是注释
    * 变量名必须在这一行的开始，前面不能有空格
    * 变量名大小写敏感

* 配置文件实例::

    /usr/local/nagios/etc/nagios.cfg

日志文件
---------

* 格式: log_file=<file_name>
* 实例: log_file=/usr/local/nagios/var/nagios.log
* 这是首先要做的事

对象配置文件
------------

* 格式: cfg_file=file_name>
* 实例:

    * cfg_file=/usr/local/nagios/etc/hosts.cfg
    * cfg_file=/usr/local/nagios/etc/services.cfg
    * cfg_file=/usr/local/nagios/etc/commands.cfg

* 用于指定Nagios要监控的对象定义。对象配置文件包含: hosts, host groups, contacts, contact groups, services, commands等。

对象配置目录
--------------

* 格式: cfg_dir=<directory_name>
* 实例: 

    cfg_dir=/usr/local/nagios/etc/commands
    cfg_dir=/usr/local/nagios/etc/services
    cfg_dir=/usr/local/nagios/etc/hosts

* Nagios用于监控的对象配置文件目录

对象缓存文件
----------------

* 格式: object_cache_file=<file_name>
* 实例: object_cache_file=/usr/local/nagios/var/object.cache
* 缓存文件

预缓存对象文件
---------------

* 格式: precache_object_file=<file_name>
* 实例: precache_object_file=/usr/local/nagios/var/object.precache

资源文件
--------

* 格式: resource_file=<file_name>
* 实例: resource_file=/usr/local/nagios/etc/resource.cfg
* 这是包含 ``$USERn$`` 宏定义的可选资源文件。宏 ``$USERn$`` 在存储用户名、密码和常用命令定义(象目录地址)。
* CGI不应该读这些资源文件，因此你可以把你那些敏感信息增加限制权限(如: 600或660)
* 你可以通过在主配置文件中增加多个resource_file statements。

临时文件
---------

* 格式: temp_file=<file_name>
* 实例: temp_file=/usr/local/nagios/var/nagios.tmp

临时目录
---------

* 格式: temp_path=<dir_name>
* 实例: temp_path=/tmp


状态文件
---------

* 格式: status=<file_name>
* 实例: stauts=/usr/local/nagios/var/status.dat
* Nagios用于存储当前状态、评论和故障时间信息。本文件用于让CGI通过web接口读取当前状态信息

状态文件更新间隔
-----------------

* 格式: status_update_interval=<second>
* 实例: status_update_interval=15
* 最小是1秒

Nagios用户
-----------

* 格式: nagios_user=<username/UID>
* 实例: nagios_user=nagios
* 用于設定Nagios用户运行的有效用户。

。。。 。。。


以后查看: http://nagios.sourceforge.net/docs/nagioscore/3/en/configmain.html


