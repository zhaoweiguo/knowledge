gen_event模块
########################

回调函数::

  gen_event module                   Callback module
  ----------------                   ---------------
  gen_event:start
  gen_event:start_link       ----->  -

  gen_event:add_handler
  gen_event:add_sup_handler  ----->  Module:init/1

  gen_event:notify
  gen_event:sync_notify      ----->  Module:handle_event/2

  gen_event:call             ----->  Module:handle_call/2

  -                          ----->  Module:handle_info/2

  gen_event:delete_handler   ----->  Module:terminate/2

  gen_event:swap_handler
  gen_event:swap_sup_handler ----->  Module1:terminate/2
                                     Module2:init/1

  gen_event:which_handlers   ----->  -

  gen_event:stop             ----->  Module:terminate/2

  -                          ----->  Module:code_change/3

add_handler/3
'''''''''''''''''
结构::

  add_handler(EventMgrRef, Handler, Args) -> Result
  类型:
  EventMgrRef = Name | {Name,Node} | {global,GlobalName} | {via,Module,ViaName} | pid()
  Handler = Module | {Module,Id}
  Args = term()
  Result = ok | {'EXIT',Reason} | term()
     Reason = term()

Handler::

  Module: 回调模块
  {Module,Id}: 当多个event handler用同一个回调模块时，用于指定event handler的唯一标识
  Args: Module:init/1函数的传参

add_sup_handler/3
'''''''''''''''''''''
结构::

  add_sup_handler(EventMgrRef, Handler, Args) -> Result
  类型
  EventMgrRef = Name | {Name,Node} | {global,GlobalName} | {via,Module,ViaName} | pid()
  Handler = Module | {Module,Id}
  Args = term()
  Result = ok | {'EXIT',Reason} | term()

说明::

  类似add_handler/3
  不同:
    1.当调用进程以Reason原因终止时,
    event manager会用参数为{stop,Reason}的方法Module:terminate/2删除此event handler
    2.当event handler之后被删除时,
    event manager会发送消息{gen_event_EXIT,Handler,Reason}给调用进程
    其中,Reason有:
      normal
      shutdown
      {swapped,NewHandler,Pid}
      error()


call/3/4
''''''''''''''''
结构::

  call(EventMgrRef, Handler, Request) -> Result
  call(EventMgrRef, Handler, Request, Timeout) -> Result
  类型:
  EventMgrRef = Name | {Name,Node} | {global,GlobalName} | {via,Module,ViaName} | pid()
     Name = Node = atom()
     GlobalName = ViaName = term()
  Handler = Module | {Module,Id}
     Module = atom()
     Id = term()
  Request = term()
  Timeout = int()>0 | infinity
  Result = Reply | {error,Error}
     Reply = term()
     Error = bad_module | {'EXIT',Reason} | term()
        Reason = term()

说明::

  发送一个同步请求,等待返回值或超时发生
  EventMgrRef, Handler: 参见add_handler/3
  Request: 转发给handle_call函数
  Timeout: 默认为5000
  Result:
     {error, bad_module}: % If the specified event handler is not installed,
     {error, {'EXIT', Reason}}: % If the callback function fails with Reason
     {error, Term}: % If the callback function returns an unexpected value Term



delete_handler/3
'''''''''''''''''''''
结构::

  delete_handler(EventMgrRef, Handler, Args) -> Result
  类型:
  EventMgrRef = Name | {Name,Node} | {global,GlobalName} | {via,Module,ViaName} | pid()
     Name = Node = atom()
     GlobalName = ViaName = term()
  Handler = Module | {Module,Id}
     Module = atom()
     Id = term()
  Args = term()
  Result = term() | {error,module_not_found} | {'EXIT',Reason}

说明::

  从事件管理EventMgrRef中删除event handler
  Args: 此参数会传给Module:terminate/2的第1个参数
  返回值: 是函数Module:terminate/2的返回值


Result::

  {error,module_not_found}: 如果没有安装此handler
  {'EXIT',Reason}: 如果回调函数失败

notify/2
'''''''''''

参见sync_notify/2

sync_notify/2
''''''''''''''''''
结构::

  notify(EventMgrRef, Event) -> ok
  sync_notify(EventMgrRef, Event) -> ok
  类型:
  EventMgrRef = Name | {Name,Node} | {global,GlobalName} | {via,Module,ViaName} | pid()
  Event = term()

说明::

  event manager EventMgrRef会调用每个安装了此event的event handler
    的回调函数Module:handle_event/2 
  notify是异步请求,立即返回
  sync_notify/2是同步请求,在所有的event handlers都处理完后返回ok

其他::

  notify/1 does not fail even if the specified event manager does not exist,
     unless it is specified as Name.




which_handlers/1
'''''''''''''''''''''''
结构::

  which_handlers(EventMgrRef) -> [Handler]
  类型:
  EventMgrRef = Name | {Name,Node} | {global,GlobalName} | {via,Module,ViaName} | pid()
     Name = Node = atom()
     GlobalName = ViaName = term()
  Handler = Module | {Module,Id}
     Module = atom()
     Id = term()




实例
'''''''''''''
terminal_logger.erl::

  -module(terminal_logger).
  -behaviour(gen_event).

  -export([init/1, handle_event/2, terminate/2]).

  init(_Args) ->
      {ok, []}.

  handle_event(ErrorMsg, State) ->
      io:format("***Error*** ~p~n", [ErrorMsg]),
      {ok, State}.

  terminate(_Args, _State) ->
      ok.

file_logger.erl::

  -module(file_logger).
  -behaviour(gen_event).

  -export([init/1, handle_event/2, terminate/2]).

  init(File) ->
      {ok, Fd} = file:open(File, read),
      {ok, Fd}.

  handle_event(ErrorMsg, Fd) ->
      io:format(Fd, "***Error*** ~p~n", [ErrorMsg]),
      {ok, Fd}.

  terminate(_Args, Fd) ->
      file:close(Fd).

启动::

  // start_link通常用于supervisor监控树
  // start通常用于单独的事件管理
  1> gen_event:start({local, error_man}).
  {ok,<0.31.0>}
  // 此函数会调用terminal_logger:init([])
  2> gen_event:add_handler(error_man, terminal_logger, []).
  ok
  // 对file_logger类事件来说, 会调用
  // terminal_logger:init([])

增加handler::

  3> gen_event:add_handler(error_man, file_logger, ["/tmp/file.txt"]).
  // 会调用
  // file_logger:init(["/tmp/file.txt"])

消息发送::

  4> gen_event:notify(error_man, no_reply).
  // 会调用回调函数
  1.对terminal_logger:
  handle_event(ErrorMsg, State) ->
    io:format("***Error*** ~p~n", [ErrorMsg]),
    {ok, State}.
  2.对file_logger:
  handle_event(ErrorMsg, Fd) ->
    io:format(Fd, "***Error*** ~p~n", [ErrorMsg]),
    {ok, Fd}.

删除handler::

  5> gen_event:delete_handler(error_man, terminal_logger, []).
  ok
  6> gen_event:delete_handler(error_man, file_logger, []).
  ok

停止::

  > gen_event:stop(error_man).
  ok

处理其他消息::

  handle_info({'EXIT', Pid, Reason}, State) ->
    ..code to handle exits here..
    {ok, NewState}.

  code_change(OldVsn, State, Extra) ->
    ..code to convert state (and more) during code change
    {ok, NewState}






