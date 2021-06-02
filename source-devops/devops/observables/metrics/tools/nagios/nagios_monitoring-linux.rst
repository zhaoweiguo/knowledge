.. _nagios_monitoring-linux:

Linux/Unix机器监控
=====================

* 本文档描写如何监控Linux/Unix服务属性和私有服务如:

    * CPU load
    * Memory usage
    * Disk usage
    * Logged in users
    * Running processes
    * etc

* 本文档的前提是你用 `快速开始 <./quickstart>`_ 完成Nagios的安装
* Linux的公共服务(如:HTTP, FTP, SSH, SMTP, etc.), 我们会在 `监控公共可用服务 <./monitoring-publicservices>`_ 詳細介绍
* 监控远程Linux/Unix服务有几种方法:

    * 用共享的SSH keys和 ``check_by_ssh plugin`` 在远程服务器上运行插件，这种方法当运行数以千计的服务时会大量消耗监控机器的性能(由于过度建立和关闭ssh连接)，此种方法在此不进行討論
    * 另一个常用的方法是用 `NRPE插件 <./addons.html#nrpe>`_ 监控远程服务器。NRPE允许你在远程Linux/Unix主机运行插件。这在监控远程服务器本地资源(磁盘, CPU, 内存等)时非常有用。结构如下图:

.. figure:: /images/monitors/nagios/tools_nagios_nrpe.png
   :width: 80%

