Emqtt配置基础
=================



::

  etc/emq.conf  EMQ Broker Config
  etc/acl.conf  The default ACL File
  etc/plugins/*.conf  EMQ Plugins’ Config

配置文件历史变更::

  1.erlang专用配置文件
  2.rebar配置文件
  3.k/v配置文件


OS Environment Variables::

  EMQ_NODE_NAME Erlang node name
  EMQ_NODE_COOKIE Cookie for distributed erlang node
  EMQ_MAX_PORTS Maximum number of opened sockets
  EMQ_TCP_PORT  MQTT TCP Listener Port, Default: 1883
  EMQ_SSL_PORT  MQTT SSL Listener Port, Default: 8883
  EMQ_WS_PORT MQTT/WebSocket Port, Default: 8083
  EMQ_WSS_PORT  MQTT/WebSocket/SSL Port, Default: 8084