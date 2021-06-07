Erlang工具
====================

::


  // 支持的最大并发进程数(对应+P)
  erlang:system_info(process_limit).


  // 内存
  erlang:memory().

  // CPU
  erlang:system_flag(scheduler_wall_time, true).
  // 该函数返回[{调度器ID, BusyTime, TotalTime}]
  // BusyTime是调度器执行进程代码，BIF，NIF，GC等的时间
  // TotalTime是cheduler_wall_time打开统计以来的总调度器钟表时间
  erlang:statistics(scheduler_wall_time).
  // BusyTime/TotalTime
  Ts0 = lists:sort(erlang:statistics(scheduler_wall_time)).
  Ts1 = lists:sort(erlang:statistics(scheduler_wall_time)).
  lists:map(fun({{I, A0, T0}, {I, A1, T1}}) -> 
    {I, (A1 - A0)/(T1 - T0)} end, lists:zip(Ts0,Ts1)).

  // 进程
  // 当前进程数
  length(processes()).
  // 端口数量
  length(ports()).
  //指定进程的详细信息
  erlang:process_info(Pid, message_queue_len).
  获取端口信息
  erlang:port_info/2

  //OTP进程
  sys:log_to_file(Pid, FileName)： 将指定进程收到的所有事件信息打印到指定文件
  sys:get_state(Pid)： 获取OTP进程的State
  sys:statistics(Pid, Flag): Flag: true/false/get 打开/关闭/获取进程信息统计
  sys:install/remove 可为指定进程动态挂载和卸载通用事件处理函数
  sys:suspend/resume: 挂起/恢复指定进程
  sys:terminate(Pid, Reason): 向指定进程发消息，终止该进程












