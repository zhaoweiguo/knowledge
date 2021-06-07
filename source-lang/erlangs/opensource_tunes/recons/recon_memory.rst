recon_memory
#################


内存
'''''''''
::

  recon:proc_count(memory, 3).
  recon:proc_count(message_queue_len, 3).

垃圾回收::

  Erlang的系统监控器:
  % 检查发现系统还没有设置任何监控器
  erlang:system_monitor().
  % 当垃圾回收的时间超过 500 毫秒时就会得到通知消息
  % 如果也想对堆的大小进行监控，可以去设置检查{large_heap，NumWords}
  % 一开始不确定时，最好使用大一点的值,过小的值(如1 个 word 左右)会导致进程的 邮箱被通知消息撑满
  erlang:system_monitor(self(), [{long_gc, 500}]).
  % 显示消息结果
  flush().
  % 取消系统监控器
  erlang:system_monitor().
  % 确认取消成功
  erlang:system_monitor().

检测泄漏::

  检测引用计数型的 binary 泄漏非常容易
  1.先测量一下每个进程中的 binary 引用列表(使用binary 属性)
  2.强制做一次垃圾回收
  3.再测量一次，最后计算差值

  %显示出每个进程所持有的以及随后释放的 binary 数量的差值
  erl> recon:bin_leak(Max). % 值-34意思是 调用之后的 refc binary 比调用前少34
  [{<0.4.0>,-34,
    [erl_prim_loader,
     {current_function,{erl_prim_loader,loop,3}},
     {initial_call,{erlang,apply,2}}]}
     ...
   ]

   % 检查已分配内存
   recon_alloc:memory(usage).
   recon_alloc:memory(allocated).
   recon_alloc:memory(allocated_type). % 然后可以和 erlang:memory()的结果进行比较
   recon_alloc:fragmentation(current). % 打印出节点中不同分配器的使用率
   recon_alloc:fragmentation(max). % 显示出在最大内存负载下分配器的使用情况(使用率很低的情况)



实例::

  erl> recon_alloc:memory/1
  参数:
  1.used参数用来报告已分配的Erlang数据实际占用的内存大小
  2.allocated参数用来报告VM保留的内存大小。包括:已使用的内存，以及虽未使用 但是 OS 已经分配出来的内存。如果需要应对 ulimit 或者想知道 OS 报告的值，这个数值正是所需的
  3.unused参数用来报告由VM保留但是尚未分配出去的内存大小。其值等于allocated used
  4.usage参数会返回已使用的和已分配的内存百分比(0.0..1.0)

  erl> recon:scheduler_usage(1000).    % 单位毫秒
  [{1,1.5964303816665936e-5},
   {2,1.4966071914968765e-5},
   {3,0.97077683977997643},
   {4,0.91084724863174823}

  erl> length(processes()).  % 进程数

  erl> length(erlang:ports()).
  erl> recon:port_types().
  % *_inet 类型的端口基本上都是 socket，前缀指示出所使用的协议(TCP、UDP、SCTP)
  % efile 类型表示文件，”0/1”、”2/2”则分别表示标准 I/O 通道(stdin 和 stdout)以及标准错误通道 (stderr)的文件描述符
  % 其他类型基本上都会被赋予与其通信的驱动同样的名字，基本上都是port程序或者port驱动


