gproc
===============


网站 [1]_

Erlang 进程注册机制目前的限制是::

  names只能是atom
  一个进程只能注册一个name
  不能进行高效的搜索和遍历,进程信息的检索是通过遍历检查进程的元数据完成的.

Gproc是Erlang进程注册机制的加强版,提供了如下原生进程注册没有的功能::

  使用任意Erlang Term作为进程的别名
  一个进程注册多个别名
  支持QLC和match specification高效查询
  自动移交已经注册的names和属性到另外的进程

ets表::

  gproc
  gproc_monitor



get_attribute/2/3
''''''''''''''''''''''
结构::

  get_attribute(Key, Attr::atom()) -> Value
  get_attribute(Key, Pid::pid() | shared, Attr::atom()) -> Value



lookup_values/1
'''''''''''''''''''
实例::

  gproc:lookup_values({p,l,Name})


reg/1/2/3
''''''''''''''
结构::

  reg(Key::key()) -> true
      等同于: reg(Key, default(Key), []).
  reg(Key::key(), Value::value()) -> true
      等同于: reg(Key, Value, []).
  reg(Key::key(), Value::value(), Attrs::attrs()) -> true

  类型:
  Key:: {Type, Context, Name}
  Type :: p | n | c | a | r | rc
  Context :: l | g

说明::

  l:local
  g:global
  --
  p - 'property',非唯一,不同进程可以注册相同的名字
  n - 'name',指定上下文是唯一的
  c - 'counter',类似property,数值,大体类似ets计数器
  a - 'aggregated counter',汇总计数器,由gproc自动更新,指定范围内所有相同名称计数器的总和.
  r - 'resource property',类似property,可通过'resource counter'追踪
  rc - 'resource counter',追踪相同名称的资源属性数量.当计数为0时,可以执行有on_zero属性指定的任何触发器

On-zero triggers::

  Msg = {gproc, resource_on_zero, Context, Name, Pid}

  {send, Key} - run gproc:send(Key, Msg)
  {bcast, Key} - run gproc:bcast(Key, Msg)
  publish - run gproc_ps:publish(Context, gproc_resource_on_zero, {Context, Name, Pid})
  {unreg_shared, Type, Name} - unregister the shared key {Type, Context, Name}


实例::

  gproc:reg({p, l, "Shell"}).
  gproc:reg({p, l, Name}, Port).


send/2
''''''''
结构::

  send(Key::process() | key(), Msg::any()) -> Msg


说明::

  发送消息给Key相关的指定1个或多个进程

实例::

  gproc:send({p,l,"Shell"}, dvd).







.. [1] https://github.com/uwiger/gproc





