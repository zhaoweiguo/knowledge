.. _cpu:

CPU和调度器占用
'''''''''''''''''''
::

  Profiling和Reduction计数:
  eprof:http://www.erlang.org/doc/man/eprof.html
  fprof:http://www.erlang.org/doc/man/fprof.html
  eflame:https://github.com/proger/eflame
  recon:proc_window/3

系统监控器::

  erlang:system_monitor/2 去监控long_gc和long_schedule
  前者会报告出工作量过大的垃圾回收(是要花时间的!)
  后者则会捕捉到由于使用了NIF或者其他使得进程难以释放调度器的做法，从而导致进程忙碌的问题

实例::

  F = fun(F) ->
    receive
      {monitor, Pid, long_schedule, Info} ->
        io:format("monitor: long_schedule, Pid:~p, Info:~p~n", [Pid, Info]);
      {monitor, Pid, long_gc, Info} ->
        io:format("monitor: long_gc, Pid:~p, Info:~p~n", [Pid, Info])
    end,
    F(F)
  end.
  SetUp = fun(Delay) -> 
    fun() ->
      register(temp_sys_monitor, self()),
      erlang:system_monitor(self(), [{long_schedule, Delay}, {long_gc, Delay}]),
      F(F)
    end
  end.
  spawn_link(SetUp(1000)).

说明::

  挂起的端口:
  系统监控器中使用 busy_port,busy_dist_port 参数
  如果发现存在此类问题:
  把关键路径上的发送函数替换为使用 
    erlang:port_command(Port, Data, [nosuspend]) ( 针 对 端 口 ) 
    或 
    erlang:send(Pid, Msg, [nosuspend])(针对分布式进程间消息)






