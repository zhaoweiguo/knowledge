service命令
###########

.. note:: init.d 初始化脚本称之为 System V 风格初始化，是 System V 系统传统之一，后来成为一些 Unix 系统的共同特性的源头。值得一提的是，在 /etc 目录下可能还包含 rc#.d 目录，这也是 System V 风格，# 为数字 0 到 6，为系统的运行级别 runlevel。可见 System V 风格影响深远。



相关目录::

    /etc/init.d/


实战::

    service start nginx
    等同于
    /etc/init.d/nginx start







