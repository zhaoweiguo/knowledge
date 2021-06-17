Emqtt用户指南 (User Guide)
============================

MQTT 认证设置::

  EMQ 消息服务器认证由一系列认证插件(Plugin)提供，系统支持按用户名密码、ClientID 或匿名认证
  系统默认开启匿名认证(anonymous)，通过加载认证插件可开启的多个认证模块组成认证链:
             ----------------           ----------------           ------------
  Client --> | Username认证 | -ignore-> | ClientID认证 | -ignore-> | 匿名认证 |
             ----------------           ----------------           ------------
                    |                         |                         |
                   \|/                       \|/                       \|/
              allow | deny              allow | deny              allow | deny




开启匿名认证::

  Anonymous:
  mqtt.allow_anonymous = true

Username/Password（用户名密码认证）::

  > ./bin/emqttd_ctl plugins load emq_auth_username
  > cat etc/plugins/emq_auth_username.conf
  auth.user.$N.username = admin
  auth.user.$N.password = public
  > $ ./bin/emqttd_ctl users add <Username> <Password>

MQTT ClientId（ClientId 认证）::

  > cat etc/plugins/emq_auth_clientid.conf
  auth.client.$N.clientid = clientid
  auth.client.$N.password = passwd
  > ./bin/emqttd_ctl plugins load emq_auth_clientid

  ...
  http://emqtt.com/docs/v2/guide.html







