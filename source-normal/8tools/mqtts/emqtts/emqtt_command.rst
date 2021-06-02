Emqtt使用命令
===================


基本命令::

  ./bin/emqttd console
  ./bin/emqttd start
  ./bin/emqttd stop

  ./bin/emqttd_ctl status
  ./bin/emqttd_ctl list

broker::

  //查询服务器基本信息，启动时间，统计数据与性能数据
  ./bin/emqttd_ctl broker
  ./bin/emqttd_ctl broker pubsub
  ./bin/emqttd_ctl broker stats
  ./bin/emqttd_ctl broker metrics

cluster::

  ./bin/emqttd_ctl cluster join emq@s1.emqtt.io
  ./bin/emqttd_ctl cluster status
  ./bin/emqttd_ctl cluster leave
  ./bin/emqttd_ctl cluster remove emq@s2.emqtt.io

client::

  ./bin/emqttd_ctl clients list
  ./bin/emqttd_ctl clients show <ClientId>
  ./bin/emqttd_ctl clients kick <ClientId>

sessions::

  ./bin/emqttd_ctl sessions list
  ./bin/emqttd_ctl sessions list persistent
  ./bin/emqttd_ctl sessions list transient
  ./bin/emqttd_ctl sessions list show <ClientId>

routers::

  ./bin/emqttd_ctl routes list
  ./bin/emqttd_ctl routes show <Topic>

topics::

  ./bin/emqttd_ctl topics list
  ./bin/emqttd_ctl topics show <Topic>

subscriptions::

  ./bin/emqttd_ctl subscriptions list 
  ./bin/emqttd_ctl subscriptions list static
  ./bin/emqttd_ctl subscriptions show <ClientId>

插件::

  ./bin/emqttd_ctl plugins list
  ./bin/emqttd_ctl plugins load <Plugin>
  ./bin/emqttd_ctl plugins unload <Plugin>

bridge相关::

  ./bin/emqttd_ctl bridges list
  ./bin/emqttd_ctl bridges options
  ./bin/emqttd_ctl bridges start <Node> <topic>
  ./bin/emqttd_ctl bridges start <Node> <topic> <Options>
  ./bin/emqttd_ctl bridges stop <Node> <Topic>
  // <Options>:
    qos     = 0 | 1 | 2
    prefix  = string
    suffix  = string
    queue   = integer
  //Example:
    qos=2,prefix=abc/,suffix=/yxz,queue=1000

vm::

  ./bin/emqttd_ctl vm all
  ./bin/emqttd_ctl vm load
  ./bin/emqttd_ctl vm memory
  ./bin/emqttd_ctl vm process
  ./bin/emqttd_ctl vm io

Trace::

  ./bin/emqttd_ctl trace list
  ./bin/emqttd_ctl trace client <ClientId> <LogFile> 
  ./bin/emqttd_ctl trace client <ClientId> off  
  ./bin/emqttd_ctl trace topic <Topic> <LogFile>  
  ./bin/emqttd_ctl trace topic <Topic> off  
  // Example
  ./bin/emqttd_ctl trace client "clientid" "trace_clientid.log"

  // listeners
  ./bin/emqttd_ctl listeners

admin(registered by dashboard plugin)::

  ./bin/emqttd_ctl admins add <Username> <Password>
  ./bin/emqttd_ctl admins admins passwd <Username> <Password> 
  ./bin/emqttd_ctl admins admins del <Username> 
  // user用户?
  ./bin/emqttd_ctl users add <Username> <Password>

其他::

  ./bin/emqttd_ctl mnesia




