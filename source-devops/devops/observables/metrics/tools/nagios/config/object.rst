.. _object:

对象配置
==========

* 对象类型有如下几种:

    * Services
    * Service Groups
    * Hosts
    * Host Groups
    * Contacts
    * Contact Groups
    * Commands
    * Time Periods
    * Notifications Escalations
    * Notification and Execution Dependencies

* 对象配置文件在主配置文件中用 ``cfg_file`` 或 ``cfg_dir`` 指定
* 快速安装后，对象配置文件安装在 ``usr/local/nagios/etc/objects/`` 下
* 如何定义对象:

    * 基本定义: http://nagios.sourceforge.net/docs/nagioscore/3/en/objectdefinitions.html
    * 继承定义: http://nagios.sourceforge.net/docs/nagioscore/3/en/objectinheritance.html
    * 高级属性: http://nagios.sourceforge.net/docs/nagioscore/3/en/objecttricks.html

对象说明
---------

* Host，一个最重要的监控逻辑:

    * 网络中的物理设备(服务器、工作站、路由器、交換机、打印机等)
    * 一种地址(IP或MAC)
    * 一个或多个相关服务
    * 和其他主机间有父子关系，常用来实时展现网络连接，被用在 `这儿 <http://nagios.sourceforge.net/docs/nagioscore/3/en/networkreachability.html>`_

* Host Groups: 监控服务器组
* Service:

    * 主机属性: CPU、磁盘、开机时间等
    * 主机提供的服务: HTTP、POP3、FTP、SSH等
    * 主机相关的其他信息: DNS记录等

* Service Groups: 服务组
* Contacts: 通知进程相关的人

    * 一个或多个通知方法: 电话、寻机、邮件、短信等
    * 发送相关信息到指定联系方式

* Contact Groups: 联系组
* Timeperiods:

    * 何时监控主机或服务
    * 何時给联系人发送消息

* Commands:

    * Host and service checks
    * Notifications
    * Event handlers
    * and more...


摘自: http://nagios.sourceforge.net/docs/nagioscore/3/en/configobject.html
