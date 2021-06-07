gen_server模块
#####################

Design Principles
''''''''''''''''''''''''''
Client-Server Principles:
1 Server VS n Client

.. figure:: /images/languages/erlangs/erl_otp_gen_server_principle.gif
   :width: 60%

监控树模式::

  init(Args) ->
    ...,
    process_flag(trap_exit, true),
    ...,
    {ok, State}.

  ...

  terminate(shutdown, State) ->
      ..code for cleaning up here..
      ok.

Standalone Gen_Servers::

  ...
  export([stop/0]).
  ...

  stop() ->
      gen_server:cast(ch3, stop).
  ...

  handle_cast(stop, State) ->
      {stop, normal, State};
  handle_cast({free, Ch}, State) ->
      ....

  ...

  terminate(normal, State) ->
      ok.


.. function:: abcast/2/3

结构::

  abcast(Name, Request) -> abcast
  abcast(Nodes, Name, Request) -> abcast
  类型:
  Nodes = [Node]
  Request = term()

说明::

  向指定Node本地注册为Name的gen_server进程发送asynchronous请求
  此函数立即返回,忽略not exist结点或不存在gen_server名
  此gen_server进程调用Module:handle_cast/2方法处理此请求
  注: 更多请求参考:multi_call/2,3,4.


.. function:: call/2/3

结构::

  call(ServerRef, Request) -> Reply
  call(ServerRef, Request, Timeout) -> Reply
  Types
  ServerRef = Name | {Name,Node} | {global,GlobalName}
    | {via,Module,ViaName} | pid()
   Node = atom()
   GlobalName = ViaName = term()
  Request = term()
  Timeout = int()>0 | infinity
  Reply = term()


.. function:: enter_loop/3/4/5

结构::

  enter_loop(Module, Options, State)
  enter_loop(Module, Options, State, ServerName)
  enter_loop(Module, Options, State, Timeout)
  enter_loop(Module, Options, State, ServerName, Timeout)


类型::

  Options = [{debug,Dbgs} | {hibernate_after,HibernateAfterTimeout}]
    Dbgs = [trace | log | statistics
      | {log_to_file,FileName} | {install,{Func,FuncState}}]

作用 [1]_ ::

    让一个已经存在的process进入gen_server进程中
    Does not return, instead the calling process enters the gen_server process receive loop and becomes a gen_server process. 
    此进程必须用proc_lib[1]的启动函数启动
    用户需要手动做进程初使化(包括注册名,如果指定ServerName)

    此函数在做比gen_server还复杂的初始化时更加有用

.. warning::

    失败原因:
    1.调用进程不是由proc_lib启动
    2.指定ServerName但没有注册

.. function:: multi_call/2/3/4

结构::

  multi_call(Name, Request) -> Result
  multi_call(Nodes, Name, Request) -> Result
  multi_call(Nodes, Name, Request, Timeout) -> Result
  类型:
  Nodes = [Node]
  Name = atom()
  Request = term()
  Timeout = int()>=0 | infinity
  Result = {Replies,BadNodes}
   Replies = [{Node,Reply}]
    Reply = term()
  BadNodes = [Node]

说明::

  向每个Node上本地注册为Name的gen_server发送synchronous请求,并等待返回
  Nodes默认值为: [node()|nodes()]
  Timeout默认值为: infinity

.. warning::

    如其中有node不能处理monitor(如C Node或Java Node)
    gen_server在请求时没有启动,但在2秒内启动
    此函数会等待整个超时时间,包括infinity
    注: 全Erlang结点没有此问题

.. function:: reply/2

结构::

  reply(Client, Reply) -> Result
  Types
  Client - see below
  Reply = term()
  Result = term()


说明::

  当不能使用Module:handle_call/3函数的返回值定义回复时,gen_server进程可以使用此函数显示回复
  之后的就不需要handler_call的返回值了,即可使用:
  {noreply, xxx}


.. function:: start/start_link/3/4

::

  start(Module, Args, Options) -> Result
  start(ServerName, Module, Args, Options) -> Result
  start_link(Module, Args, Options) -> Result
  start_link(ServerName, Module, Args, Options) -> Result
  类型:
  ServerName = {local,Name} | {global,GlobalName} | {via,Module,ViaName}
  Options = [Option]
     Option = {debug,Dbgs} | {timeout,Time} | {hibernate_after,HibernateAfterTimeout} | {spawn_opt,SOpts}
        Dbgs = [Dbg]
            Dbg = trace | log | statistics | {log_to_file,FileName} | {install,{Func,FuncState}}
        SOpts = [term()]
  Result = {ok,Pid} | ignore | {error,Error}
     Error = {already_started,Pid} | term()

Args::

  If option {timeout,Time} is present, the gen_server process is allowed to spend Time milliseconds initializing or it is terminated and the start function returns {error,timeout}.

  If option {hibernate_after,HibernateAfterTimeout} is present, the gen_server process awaits any message for HibernateAfterTimeout milliseconds and if no message is received, the process goes into hibernation automatically (by calling proc_lib:hibernate/3).

  If option {debug,Dbgs} is present, the corresponding sys function is called for each item in Dbgs; see sys(3).

  If option {spawn_opt,SOpts} is present, SOpts is passed as option list to the spawn_opt BIF, which is used to spawn the gen_server process; see spawn_opt/2.

.. function:: stop/1/3

类型::

  stop(ServerRef) -> ok
  stop(ServerRef, Reason, Timeout) -> ok
  类型:
  ServerRef = Name | {Name,Node} | {global,GlobalName}
    | {via,Module,ViaName} | pid()
  Reason = term()

说明::

  指定server以Reason原因exit并等待它终止.此gen_server进程会在exit前调用Module:terminate/2
  Reason默认值为: normal
  Timeout默认值为: infinity, 单位milliseconds

  Reason为normal, shutdown, or {shutdown,Term}时会返回ok并terminate
  Reason为其他时,会causes an error report to be issued using logger(3)

  如果服务在指定时间内没有被terminated,则抛出timeout exception
  如果此process不exist, 抛出a noproc exception


.. function:: Module:init

::

  Module:init(Args) -> Result
  类型:
  Args = term()
  Result = {ok,State} | {ok,State,Timeout} | {ok,State,hibernate}
   | {ok,State,{continue,Continue}} | {stop,Reason} | ignore
   State = term()
   Timeout = int()>=0 | infinity
   Reason = term()

说明::

  {ok,State,Timeout}
  除非Timeout millisecond时间内收到请求,否则会触发timeout的info消息
  {ok,State} 等于 {ok,State,infinity}
  一直等待请求过来
  {ok,State,hibernate}
  等待消息时进入hibernate状态,通过调用proc_lib:hibernate/3
  {stop,Reason} | ignore
  初使化失败时,返回

.. function:: code_change/3


实例::

  1.reloader升级后发现每5000s reloader一次代码:
    原因: node没有重启, gen_server里面state的值没有变
    原来单位是ms，这次升级后变成s


.. [1] http://erlang.org/doc/man/proc_lib.html



