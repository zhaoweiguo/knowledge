.. _chkconfig:

chkconfig命令
================

* 简介

    更新、查询系统服务的runlevel information

* 概述(synopsis)::

    chkconfig --list [name]
    chkconfig --add name
    chkconfig --del name
    chkconfig [--level levels] name <on|off|reset|resetpriorities>
    chkconfig [--level levels] name

* 实例::

    chkconfig --add nginx //增加nginx服务
    chkconfig --list nginx //列出nginx的服务启动情况
    chkconfig --level 35 sshd on  //这样sshd服务会在系统运行级3和5下自动启动

* 其他::

    ntsysv //图形化界面,要在这个界面中看到对应的服务需要执行完 chkconfig --add nginx



