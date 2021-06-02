钩子(Hook)设计
===================

EMQ 消息服务器在客户端上下线、主题订阅、消息收发位置设计了扩展钩子(Hook)::

  //Hook类型
  client.connected
  client.subscribe
  client.unsubscribe
  session.subscribed
  session.unsubscribed
  message.publish
  message.delivered
  message.acked
  client.disconnected

The EMQ broker uses the Chain-of-responsibility_pattern to implement hook mechanism. The callback functions registered to hook will be executed one by one::

                  --------  ok | {ok, NewAcc}   --------  ok | {ok, NewAcc}   --------
  (Args, Acc) --> | Fun1 | -------------------> | Fun2 | -------------------> | Fun3 | --> {ok, Acc} | {stop, Acc}
                  --------                      --------                      --------
                     |                             |                             |
                stop | {stop, NewAcc}         stop | {stop, NewAcc}         stop | {stop, NewAcc}


一个hook的callback函数返回值有以下几种::

  ok  
  {ok, NewAcc}  
  stop
  {stop, NewAcc}  


相关模块::

  emqttd,       // hook APIs defined
  emqttd_hook   // implemented
  emq_plugin_template   // provides the examples for hook usage








