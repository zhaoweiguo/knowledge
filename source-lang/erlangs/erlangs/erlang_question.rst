Erlang常见问题
######################


多Node不同Cookie互相通信
''''''''''''''''''''''''''''''
重现步骤::
  
  erl -name a@127.0.0.1 -setcookie a123
  erl -name b@127.0.0.1 -setcookie b123
  erl -name c@127.0.0.1 -setcookie c123

  c> erlang:set_cookie('a@127.0.0.1', 'a123').
  c> net_kernel:connect('a@127.0.0.1').
  c> erlang:set_cookie('b@127.0.0.1', 'b123').
  c> net_kernel:connect('b@127.0.0.1').



observer:start()执行失败
'''''''''''''''''''''''''''''

报错内容::

  ** exception error: undefined function wx_object:start/3
  in function observer_wx:start/0 (observer_wx.erl, line 67)

原因::

  一般是在release时没有加wx模块,缺少wx模块导致失败


消息有为汉字时json出错
''''''''''''''''''''''
解决方案::

    S = list_to_binary(xmerl_ucs:to_utf8("灯泡"))



tmp
''''''''
::

  Erlang的supervisor执行顺序有关系吗？
  答：是有关系的，只不过在app未启动前可以执行cast请求


莫名奇怪的问题
''''''''''''''''''
原因::

    使用rebar工具,依赖很多项目，多人开发，不经常用的环境.

解决方案::

    执行: rebar3 upgrade
    其他: util:reload()
















