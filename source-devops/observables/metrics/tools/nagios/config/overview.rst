.. _overview:

配置概述
=========

* 这儿是你用Nagios必须配置的地方，所以慢慢的、仔细的看。
* 注: 如果你按前面快速安装，配置文件就会被话在 ``/usr/local/nagios/etc/`` 中。
* 配置文件用图像表示如下:

    .. figure:: /images/monitors/nagios/tools_nagios_configoverview.png
       :width: 50%

主配置文件nagios.cfg
--------------------

* 主配置文件包含一系列影响Nagios守护进程操作的指令。这些配置文件会被Nagios守护进程和CGI使用到。
* 具体文档参看 `主配置文件 <./main.html>`_


资源文件resource.cfg
---------------------

* 资源文件用户存储用户定义的宏。主要目的是用资源文件存放敏感信息(如密码)，
* 你可以指定一个或多个可选配置文件(在主配置文件中設定[resource_file目录])

对象定义文件object/目录
-------------------------

* 对象定义文件用于定义hosts, services, hostgroups, contacts, contactgroups, commands等，这儿定义你要监控什么以及怎么监控
* 你可以在选择一个或多个对象定义文件(在主配置文件中設定[cfg_file文件或cfg_dir目录])
* 具体文件参看 `对象配置文件 <./object.html>`_

CFG配置文件cgi.cfg
-------------------

* CGI配置文件包含一系列影响CGI操作的目录。
* 它也包含与 **主配置文件** 相关的配置文件，因此CGI知道如何配置Nagios并且你对象定义存储到哪
* 具体文件参看 `CGI配置文件 <./cgi.html>`_
