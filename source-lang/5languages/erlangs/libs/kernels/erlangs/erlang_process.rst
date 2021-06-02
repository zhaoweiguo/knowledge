进程相关
-----------
.. function:: spawn/1/2/3/4

结构::

  spawn(Fun) -> pid()
  spawn(Node, Fun) -> pid()
  spawn(Module, Function, Args) -> pid()


说明::

  spawn: 等同于没有opt的spawn_opt
  spawn_link: 等同于opt带[link]的spawn_opt
  spawn_monitor: 等同于opt带[monitor]的spawn_opt

实例::

  spawn(fun() -> server("Hello") end).

  spawn(io,format, ["hello world~n"]).


.. function:: spawn_opt/2/3/4/5

结构::

  spawn_opt(Fun, Options) -> pid() | {pid(), reference()}
  spawn_opt(Node, Fun, Options) -> pid() | {pid(), reference()}
  spawn_opt(Module, Function, Args, Options) ->
            pid() | {pid(), reference()}
  spawn_opt(Node, Module, Function, Args, Options) ->
            pid() | {pid(), reference()}

  类型
  Node = node()
  Fun = function()
  Options = [spawn_opt_option()]
  spawn_opt_option() = 
      link |
      monitor |
      {priority, Level :: low | normal | high | max} |
      {fullsweep_after, Number :: integer() >= 0} |
      {min_heap_size, Size :: integer() >= 0} |
      {min_bin_vheap_size, VSize :: integer() >= 0} |
      {max_heap_size, Size :: integer() >= 0 |
            #{size => integer() >= 0, kill => boolean(), error_logger => boolean()}} |
      {message_queue_data, MQD :: off_heap | on_heap}

说明::

  等同于有Options的spawn/3

Options选项说明::

  link: 等同于spawn_link/3
  monitor: 等同于monitor/2
  {priority, Level}: 等同于运行process_flag(priority,Level)
  {fullsweep_after, Number}: 用于调优, @todo
  {min_heap_size, Size}: 用于调优, 设定最小heap,当大于系统默认值时,垃圾回收次数变少,提高性能
  {min_bin_vheap_size, VSize}: 用于调优,minimum binary virtual heap size
  {max_heap_size, Size}: 默认值是可通过参数+hmax修改.说见:process_flag(max_heap_size,Size).
  {message_queue_data, MQD}: 参数+hmqd修改,process_flag(message_queue_data,MQD)



.. function:: monitor/1

结构::

  monitor(Type, Item) -> MonitorRef
  类型:
  Type: process | port | time_offset
  Item: monitor_process_identifier()  |   
            monitor_port_identifier() | 
            clock_service
  MonitorRef = reference()
  registered_process_identifier() = 
      registered_name() | {registered_name(), node()}
  monitor_process_identifier() = 
      pid() | registered_process_identifier()
  monitor_port_identifier() = port() | registered_name()

说明::

  发送一个类型为Type的monitor请求给Item指定的「实体」,
  if这个monitored的「实体」不存在或变化,会给监控者发送如下message
  {Tag, MonitorRef, Type, Object, Info}

  Type为process | port只会触发一次，之后就会被移除，触发时发送消息格式:
  {'DOWN', MonitorRef, Type, Object, Info}

Object::

  pid() or port()           % when monitoring a local process or port

  RegisteredName
  {RegisteredName, Node}    % when monitoring process or port by name

Info::

  进程exit的原因
  noproc: 进程、port不存在
  noconnection: 没连接到要监控进程对应的node

Type为time_offset::

  @todo
  {'CHANGE', MonitorRef, Type, Item, NewTimeOffset}


.. function:: system_info/2

backtrace_depth::

  erlang:system_flag(backtrace_depth, Depth) -> OldDepth
  类型:
  Depth = OldDepth = integer() >= 0

scheduler_wall_time::

  system_flag(scheduler_wall_time, Boolean) ->
                      OldBoolean
  类型:
  Boolean = OldBoolean = boolean()
  说明:
  Turns on or off scheduler wall time measurements.
  查看:erlang:statistics(scheduler_wall_time).



.. function:: statistics/1

scheduler_wall_time::

  statistics(scheduler_wall_time) ->
              [{SchedulerId, ActiveTime, TotalTime}] | undefined
  类型:
  SchedulerId = integer() >= 1
  ActiveTime = TotalTime = integer() >= 0

io::

  statistics(Item :: io) -> {{input, Input}, {output, Output}}
  类型:
  Input = Output = integer() >= 0
  返回值:
  Input:通过ports接收的total number of bytes
  Output:通过ports发出的的total number of bytes

garbage_collection::

  statistics(Item :: garbage_collection) ->
                {Number_of_GCs, Words_Reclaimed, 0}
  类型:
    Number_of_GCs = Words_Reclaimed = integer() >= 0
  说明:
    返回garbage collection的信息
    注:对某此实现,此信息可能无效
  实例:
    > statistics(garbage_collection).
    {85,23961,0}

run_queue::

  statistics(run_queue) -> integer() >= 0
  实例:
    erlang:statistics(run_queue).
  说明:
  the number of processes and ports that are ready to run on all available normal run-queues. 
  Dirty run queues are not part of the result. 
  The information is gathered atomically. That is, the result is a consistent snapshot of the state, but this operation is much more expensive compared to statistics(total_run_queue_lengths), especially when a large amount of schedulers is used.

total_run_queue_lengths::

  statistics(total_run_queue_lengths) ->
              TotalRunQueueLengths
  实例:
    erlang:statistics(total_run_queue_lengths).
  类型:
  TotalRunQueueLengths = integer() >= 0
  The same as calling lists:sum(statistics(run_queue_lengths)), but more efficient.

total_run_queue_lengths_all::

  The same as calling lists:sum(statistics(run_queue_lengths_all)), but more efficient.

wall_clock::

  statistics(wall_clock) ->
    {Total_Wallclock_Time, Wallclock_Time_Since_Last_Call}

  Returns information about wall clock. 
  wall_clock can be used in the same manner as runtime, 
  except that real time is measured as opposed to runtime or CPU time.
