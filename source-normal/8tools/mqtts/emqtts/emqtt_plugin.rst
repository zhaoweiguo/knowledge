Emqtt插件
=================

The EMQ broker could be extended by plugins. Users could develop plugins to customize authentication, ACL and functions of the broker, or integrate the broker with other systems.

::

  A plugin is just a normal Erlang application which has its own configuration file: ‘etc/<PluginName>.conf|config’.

  emq_plugin_template
  模板文件

  Plugin Development Guide:
  https://github.com/emqtt/emq-plugin-template

emq_dashboard: Dashboard 插件::

  插件项目地址: https://github.com/emqtt/emqttd_dashboard




from: http://docs.emqtt.com/en/latest/plugins.html