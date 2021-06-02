.. _nagios_addons:

Nagios插件
===========

* 插件作用:

    * 通过一个web接口管理配置文件
    * 监控远程主机
    * 从远程主机提交被动检查
    * 简化/扩展通知逻辑
    * 其他



NRPE
-----

NRPE允许你运行远程Linux/Unix主机的插件。用于在远程主机监控本地资源(如:磁盘、CPU、内存等)。也可以通过 ``check_by_ssh`` 插件来实现(但它占资源大)。

    .. figure:: /images/monitors/nagios/tools_nagios_nrpe.png
       :width: 80%

NSCA
------

NSCA允许你从远程Linux/Unix主机往运行在监控服务器的Nagios守护进程发送passive check結果。这在disributed或redundant/failover监控安装时非常有用。

    .. figure:: /images/monitors/nagios/tools_nagios_nsca.png
       :width: 80%

NDOUtils
---------

NDOUtils允许你通过Nagios存储MYSQL数据库上的所有状态信息。Nagios多实例可以把他们的信息存放在一个中心DB集中汇报。未来有可能为Nagios增加一个基于PHP的WEB接口。

    .. figure:: /images/monitors/nagios/tools_nagios_ndoutils.png
       :width: 80%


come from: http://nagios.sourceforge.net/docs/3_0/addons.html
