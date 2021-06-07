
.. _optimize:

优化相关
------------------

.. function:: erlang:memory/0

::


  1> erlang:memory().
  [{total,16230416},
   {processes,4084504},
   {processes_used,4083128},
   {system,12145912},
   {atom,202505},
   {atom_used,187270},
   {binary,62544},
   {code,3984366},
   {ets,310872}]
   1.total字段包含了由进程和系统使用的内存之和(这个数字是不全面的，除非使用了instrumented VM79)
   2.Processes字段指示的是Erlang进程、进程堆栈和堆使用的内存
   3.system字段包含了其余的部分:ETS表、VM中原子、refc binary80、以及一些我没有提及的隐藏数据

.. function:: system_monitor/0

::

  erlang:system_monitor() -> MonSettings
  % 查看监控状态
  类型:
  MonSettings = undefined | {MonitorPid, Options}
  Options = [system_monitor_option()]
  system_monitor_option() = 
      busy_port |
      busy_dist_port |
      {long_gc, integer() >= 0} |
      {long_schedule, integer() >= 0} |
      {large_heap, integer() >= 0}

.. function:: system_monitor/1

::

  erlang:system_monitor(Arg) -> MonSettings
  % 清除监控状态
  Arg = MonSettings = undefined | {MonitorPid, Options}
  当Arg==undefined:清空所有监控设置
  当Arg=={MonitorPid, Options}:等同于 erlang:system_monitor(MonitorPid,Options).

.. function:: system_monitor/2

::

  erlang:system_monitor(MonitorPid, Options) -> MonSettings
  % 新增监控状态
  类型:
  MonitorPid = pid()
  Options = [system_monitor_option()]
  MonSettings = undefined | {OldMonitorPid, OldOptions}
  OldMonitorPid = pid()
  OldOptions = [system_monitor_option()]

system_monitor_option可选选项
'''''''''''''''''''''''''''''''''

.. function:: {long_gc, Time}

::

  如果垃圾回收用了至少Time wall clock milliseconds, 
  就会发a message {monitor, GcPid, long_gc, Info} 到MonitorPid. 
  其中:
  GcPid是垃圾回收的pid. 
  Info是two-element tuples列表，用于描述垃圾回收的结果
    如,{timeout, GcTime}, 
    其中:
    GcTime是垃圾回收的时间(单位milliseconds).
    其他元组有:
      heap_size, heap_block_size, stack_size, 
      mbuf_size, old_heap_size, and old_heap_block_size. 

.. option:: {long_schedule, Time}

::

  如一个系统中的process or port不间断运行Time以上clock milliseconds,
  就会发a message {monitor, PidOrPort, long_schedule, Info} 到MonitorPid.
  其中:
    PidOrPort是这个运行的process or port
    Info一2元素的tuples列表，用于描述这个event.
  如果是一进程pid(),Info的值有: 
    {timeout, Millis}, 
    {in, Location}, and {out, Location}
    其中:
      Location:
        MFA ({Module, Function, Arity}) 
        或
        undefined.

  如果是一端口port(),Info的值有: 
    {timeout, Millis} 
    {port_op,Op} 
    其中:
      Op = proc_sig, timeout, input, output, event, or dist_cmd
      depending on which driver callback was executing.

      proc_sig is an internal operation and is never to appear, while the others represent the corresponding driver callbacks timeout, ready_input, ready_output, event, and outputv (when the port is used by distribution). Value Millis in tuple timeout informs about the uninterrupted execution time of the process or port, which always is equal to or higher than the Time value supplied when starting the trace. New tuples can be added to the Info list in a future release. The order of the tuples in the list can be changed at any time without prior notice.

      This can be used to detect problems with NIFs or drivers that take too long to execute. 1 ms is considered a good maximum time for a driver callback or a NIF. However, a time-sharing system is usually to consider everything < 100 ms as "possible" and fairly "normal". However, longer schedule times can indicate swapping or a misbehaving NIF/driver. Misbehaving NIFs and drivers can cause bad resource utilization and bad overall system performance.

.. option:: {large_heap, Size}

::

  If a garbage collection in the system results in the allocated size of a heap being at least Size words, a message {monitor, GcPid, large_heap, Info} is sent to MonitorPid. GcPid and Info are the same as for long_gc earlier, except that the tuple tagged with timeout is not present.

  The monitor message is sent if the sum of the sizes of all memory blocks allocated for all heap generations after a garbage collection is equal to or higher than Size.

  When a process is killed by max_heap_size, it is killed before the garbage collection is complete and thus no large heap message is sent.

.. option:: busy_port

::

  If a process in the system gets suspended because it sends to a busy port, a message {monitor, SusPid, busy_port, Port} is sent to MonitorPid. SusPid is the pid that got suspended when sending to Port.

.. option:: busy_dist_port

::

  If a process in the system gets suspended because it sends to a process on a remote node whose inter-node communication was handled by a busy port, a message {monitor, SusPid, busy_dist_port, Port} is sent to MonitorPid. SusPid is the pid that got suspended when sending through the inter-node communication port Port.

失败:

  badarg
  If MonitorPid does not exist.
  badarg
  If MonitorPid is not a local process.



.. function:: process_info/1/2

结构::

    process_info(Pid) -> Info

    process_info(Pid, Item) -> InfoTuple | [] | undefined
    process_info(Pid, ItemList) -> InfoTupleList | [] | undefined
    类型:
      Item可选类型:
          backtrace |
          binary |
          catchlevel |
          current_function |
          current_location |
          current_stacktrace |
          dictionary |
          error_handler |
          garbage_collection |
          garbage_collection_info |
          group_leader |
          heap_size |
          initial_call |
          links |
          last_calls |
          memory |
          message_queue_len |
          messages |
          min_heap_size |
          min_bin_vheap_size |
          monitored_by |
          monitors |
          message_queue_data |
          priority |
          reductions |
          registered_name |
          sequential_trace_token |
          stack_size |
          status |
          suspending |
          total_heap_size |
          trace |
          trap_exit

