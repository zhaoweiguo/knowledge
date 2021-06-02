recon_trace模块 [5]_
######################

跟踪 Erlang 程序，有几种选择:

sys [1]_ ::

  在生产环境中使用会有点问题，因为它 没有把IO重定向到远程shell，也不具有对跟踪消息的限速能力

dbg [2]_ ::

  问题在于，你必须非常清楚自己所做的事情的后果，
  因为它会把节点上的几乎所有信息都进行日志记录，因此可以瞬间杀死节点

  erlang模块中的跟踪BIF函数:
  抽象层次太低，比较难以使用

redebug [3]_ [4]_ ::

  可以安全地在生产环境中使用，它是eper套件的一部分。
  它具有内置的限速机制，接口也易于使用。
  要使用它，必须得把eper的所有依赖都增加进来

动态追踪函数::

  recon_trace:calls/2-3

  说明:
  % 强大的动态追踪函数，可用于动态挂载钩子。
  % 1. 可挂载模块/函数调用(甚至可对参数匹配/过滤)
  % 2. 可对调用进程筛选(指定Pid，限制新建进程等)
  % 3. 可限制打印的追踪数量/速率
  % 4. 其它功能，如输出重定向，追踪调用结果等


recon_trace::

  是recon中处理跟踪的模块
  它的目标是既具有和redebug同样级别的产品安全性，又不需要过多的依赖
  它只能跟踪函数调用，不能跟踪消息


跟踪原则::

  如果进程包含有敏感性息，可以调用process_flag(sensitive,true)来强制数据私有

使用Recon进行跟踪::
  
  %% 任何调用queue模块的函数，最多打印10条:
  recon_trace:calls({queue, ’_’, ’_’}, 10)

  %% 100条lists:seq(A,B):
  recon_trace:calls({lists, seq, 2}, 100)
  %% 每秒最多100条lists:seq(A,B):
  recon_trace:calls({lists, seq, 2}, {100, 1000})
  %% 参考:lists:seq(A,B,2)
  recon_trace:calls({lists, seq, fun([_,_,2]) -> ok end}, 100)
  %% 参考: iolist_to_binary/1 
  %% 一种测试无用转化的方法(原来就已经是binary类型了):
  recon_trace:calls({erlang, iolist_to_binary,
    fun([X]) when is_binary(X) -> ok end}, 10)
  %% 指定进程
  recon_trace:calls({queue, ’_’, ’_’}, {50,1000}, [{pid, Pid}])
  %% Print the traces with the function arity instead of literal arguments: 
  recon_trace:calls(TSpec, Max, [{args, arity}])
  %% 匹配两个模块dict和lists的filter/2函数
  recon_trace:calls([{dict,filter,2},{lists,filter,2}], 10, [{pid, new]})

  %% pid是gproc注册进程
  %% 跟踪handle_call/3 函数
  recon_trace:calls({Mod,handle_call,3}, {1,100}, [{pid, [{via, gproc, Name}, new]}

  %% Show the result of a given function call, the important bit being the 
  %% return_trace() call or the {return_trace} match spec value. 

  recon_trace:calls({Mod,Fun,fun(_) -> return_trace() end}, Max, Opts)
  recon_trace:calls({Mod,Fun,[{’_’, [], [{return_trace}]}]}, Max, Opts)

  % handle_event({log, Message}, #state)
  recon_trace:calls({lager_kafka_backend, handle_event, fun([{log, _}, _]) -> return_trace() end}, 2).



选项::

  {pid, PidSepc}
  指定要跟踪的进程。有效的值为 all、new、existing 或者进程描述符({A,B,C}, “<A.B.C>”、 表示进程名字的原子、{global, Name}、{via, Registrar, Name}或者 pid)。也支持指定多个， 可以把它们放到列表中。
  {timestamp, format | trace}
  缺省情况下，formatter 进程会在收到的消息中增加时间戳。如果需要精确的时间戳， 可以通过选项{timestamp, trace}强制直接在跟踪消息中使用时间戳。
  {args, arity | args}
  是打印出函数调用的参数个数，还是打印出其字面表示(缺省)。
  {scope, global | local|} 缺省情况下，只有’global’(全称函数调用)的才会被跟踪，不会跟踪模块的内部调用。 要想强制跟踪内部调用，可以传入{scope, local}选项。当想跟踪进程中以 Fun(Args) 而不 是 Module:Fun(Args)的方式调用的代码时，这个选项很有用


链接和监控::
  
  % 返回既没被链接也没被监控的进程列表
  erl> [P || P <- processes(), [{_, Ls}, {_, Ms}] <- [process_info(P, [links, monitors])], []==Ls, []==Ms].
  % 看看数量是不是正常
  erl> supervisor:count_children(SupervisorPidOrName).


.. [1] `sys <http://www.erlang.org/doc/man/sys.html>`_
.. [2] http://www.erlang.org/doc/man/dbg.html
.. [3] https://github.com/massemanet/eper/blob/master/doc/redbug.txt
.. [4] https://github.com/massemanet/eper
.. [5] http://ferd.github.io/recon/recon_trace.html





