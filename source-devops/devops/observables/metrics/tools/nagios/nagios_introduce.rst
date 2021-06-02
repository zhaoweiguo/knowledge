.. _nagios_introduce:

nagios简介
============


简介
----

    * 开源、监控系统与网络应用、它可用于监控主机与服务，当出问题或问题解决之时提醒你
    * 它实例被设计运行在linux下，但在大多数unix下都运行的很好

Nagios Core包含的一些特性:
---------------------------

    * 监控网络服务 (SMTP, POP3, HTTP, NNTP, PING, etc.)
    * 监控其他资源 (processor load, disk usage, etc.)
    * 简单的插件设计、允许用户开发他们自己的服务插件
    * 并行化服务检查
    * 能够用“父”主机来定义分层网络主机，允许探测和区别挂掉的主机和不可到达的主机
    * 当主机或服务出问题或问题解决后，给联系人发通知 (via email, pager, or user-defined method)
    * 在服务或主机事件中，能够定义事件句柄来做预处理错误解决方案[Ability to define event handlers to be run during service or host events for proactive problem resolution]
    * 自动日志文件rotation[循环]
    * 支持实现冗余监控主机[Support for implementing redundant monitoring hosts]
    * 可选择监控当前网络状态、事件和错误历史、日志文件等

System Requirements
----------------------

    * 必需有网络权限和一个C编译器(如果源码安装)
    * A web server (preferrably Apache)
    * Thomas Boutell’s gd library version 1.6.3 or higher (required by the statusmap and trends CGIs)

新手注意事項
-------------

想要熟练的按照你自己的想法配置，还需要大量的工作

    * 需要花费大量时间: 主要原因一是nagios需要配置的地方很多，二是你需要知道你应该监控什么
    * 使用快速手册: 你可以很快的安装并监控你本地系统
    * 使用文档: 当你理解它的原理后，你可以很灵活的配置；但如果你不理解，你几乎不知道如何做。一定要仔细读文档(特别是 "Configuring Nagios" and "The Basics")。当你了解最基本的配置后，再进行高级设置
    * 寻求其他帮助: `察看网址 <http://www.nagios.org/support/>`_

源码地址
----------------

* git://github.com/ageric/nagios.git(c)
* git://github.com/nagios-plugins/nagios-plugins.git(c)
* git://github.com/lingej/pnp4nagios.git(php)

    PNP is an addon to Nagios which analyzes performance data provided by plugins and stores them automatically into RRD-databases.

文档
-------

* nagios插件文档: http://nagiosplugins.org/man
* <the nagios book>: http://nagiosbook.org/html/index.html



最新下载地址 
--------------

    * 最新下载地址: http://www.nagios.org/download.
    * 网站主页: http://www.nagios.org
    * 文档地址:http://www.nagios.org/documentation
