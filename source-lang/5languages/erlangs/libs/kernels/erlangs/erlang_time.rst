.. _time:

时间相关
-----------

.. function:: erlang:send_after/3/4

::

  erlang:send_after(Time, Dest, Msg) -> TimerRef
  等同于
  erlang:send_after(Time,Dest,Msg, []).

  其他等同于erlang:start_timer/4
  除了超时格式是Msg,而start_timer是{timeout, TimerRef, Msg}
  说明:start_timer/3/4函数主要是可以用于区分此消息是否是超时消息

.. function:: erlang:start_timer/3/4

说明::

  设定一个定时器，指定时间(单位:milliseconds)后，发送一条消息{timeout, TimerRef, Msg}到Dest

结构::

  erlang:start_timer(Time,Dest,Msg).
  等同于
  erlang:start_timer(Time,Dest,Msg, []).

  erlang:start_timer(Time, Dest, Msg, Options) -> TimerRef
  Time = integer() >= 0
  Dest = pid() | atom()
  Msg = term()
  TimerRef = reference()
  Options = [Option]
  Option = {abs, Abs}
  Abs = boolean(): 默认为false
  TimerRef = reference()

  PS:Abs的值具体是关于Erlang monotonic time是否准确的问题?
  PS:时间段是erlang:system_info(start_time), erlang:system_info(end_time)之间的
  PS: Dest为Pid:Pid死掉timer自动取消(erts5.4.11);Dest为atom则不会
  PS: Dest为Pid:必须是current runtime system instance创建的实例; 
    Dest为atom:会被解析成locally registered process,且进程查找用到的时间会累计到超时里,
    且查找不到也不报错
