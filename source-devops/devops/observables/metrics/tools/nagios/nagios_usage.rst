.. _nagios_start:

Nagios的使用
=============

验证配置文件
-------------

在启动前，首先验证配置文件::

    /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg



启动Nagios
-------------

* 初使化脚本::

    /etc/rc.d/init.d/nagios start

* 手工启动::

    /usr/local/nagios/bin/nagios -d /usr/local/nagios/etc/nagios.cfg

重启Nagios
-----------

* 脚本重启::

    /etc/rc.d/init.d/nagios reload

* 通过web接口重启
* 手工重启::

    kill -HUP <nagios_pid>

停止Nagios
------------

* 脚本停止::

    /etc/rc.d/init.d/nagios stop

* web接口停止
* 手工停止::

    kill <nagios_pid>
