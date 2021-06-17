.. _plugins:

Nagios插件
===========

* 简介: 和其他监控工具不同的是，Nagios没有任何监控主机和服务的内部机制。而且信赖外部工具(插件)来实现这些乱七八糟的事情。
* 插件是可运行perl脚本或shell脚本等。
* 插件作为虚拟层，如下图:

    .. figure:: /images/monitors/nagios/tools_nagios_plugins.png
       :width: 60%

* Nagios根本不知道它在监控什么，监控什么取决于你写的插件，只要你能写出插件，你可以监控任何你想监控的
* Nagios个性化插件书写文档API见: `这儿 <http://nagios.sourceforge.net/docs/nagioscore/3/en/pluginapi.html>`_





摘自: http://nagios.sourceforge.net/docs/nagioscore/3/en/plugins.html
