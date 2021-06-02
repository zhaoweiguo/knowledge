proc_lib模块
####################


.. function:: start_link/3/4/5

结构::

  start_link(Module, Function, Args) -> Ret
  start_link(Module, Function, Args, Time) -> Ret
  start_link(Module, Function, Args, Time, SpawnOpts) -> Ret
  类型:
  Time = timeout()
  SpawnOpts = [spawn_option()]
  Ret = term() | {error, Reason :: term()}

说明::

  同步启动一个进程:启动进程，等待启动完成，然后调用
  init_ack(Parent, Ret) or init_ack(Ret)

返回值::

  {error, Reason}: 如果调用
  {error, timeout}: 超时

.. function:: init_ack/1/2

结构::

    init_ack(Ret) -> ok
    init_ack(Parent, Ret) -> ok
    类型:
    Parent = pid()
    Ret = term()

说明::

    此函数必须由start[_link]/3,4,5函数启动的进程使用.
    它告诉Parent该进程已初始化,已启动或无法初始化自身

实例::

    -module(my_proc).
    -export([start_link/0]).
    -export([init/1]).

    start_link() ->
        proc_lib:start_link(my_proc, init, [self()]).

    init(Parent) ->
        case do_initialization() of
            ok ->
                proc_lib:init_ack(Parent, {ok, self()});
            {error, Reason} ->
                exit(Reason)
        end,
        loop().


.. function:: hibernate/3

::

  hibernate(Module, Function, Args) -> no_return()
  等同于调用erlang:hibernate(Module, Function, Args)
  1.把调用进程置为wait状态,分配的内存可尽可能减少
  这个在此进程在短时间内不期望接收任何消息时有用
  2.当有新消息过来时,进程会通过调用Module:Function(Args)重新启动
  因为此函数调用时进程terminates,call stack为空,所以没有返回值
  3.当函数erlang:hibernate/3执行时,会丢弃进程的call stack,垃圾回收此进程
  之后,所有实时数据都会进入continuous heap,然后此heap会缩小到和有用数据一大小
  注意:
  因为清空了call stack,所以catch相关都被移除,在唤醒后还要恢复
  所以使用erlang:hibernate/3要小心,建议使用proc_lib:hibernate/3














