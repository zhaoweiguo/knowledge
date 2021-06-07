ttb模块
###########

A base for building trace tools for distributed systems.

描述::

    The Trace Tool Builder, ttb, is a base for building trace tools for distributed systems.
    When using ttb, do not use module dbg in application Runtime_Tools in parallel.

.. function:: p/2

结构::

    p(Items, Flags) -> Return
    类型:
    Return = {ok, [{Item, MatchDesc}]}
    Items = Item | [Item]
    Item = pid() | port() | RegName | {global, GlobalRegName} | all | processes | 
            ports | existing | existing_processes | existing_ports | new | 
            new_processes | new_ports
    RegName = atom()
    GlobalRegName = term()
    Flags = Flag | [Flag]

说明::

    Sets the specified trace flags on the specified processes or ports. Flag timestamp is always turned on.
    注: trace flag参考dbg模块

    Processes can be specified as registered names, globally registered names, or process identifiers. Ports can be specified as registered names or port identifiers. If a registered name is specified, the flags are set on processes/ports with this name on all active nodes.





.. function:: start_trace/4

结构::

    start_trace(Nodes, Patterns, FlagSpec, Opts) -> Result
    类型:
    Result = see p/2
    Nodes = see tracer/2
    Patterns = [tuple()]
    FlagSpec = {Procs, Flags}
    Proc = see p/2
    Flags = see p/2
    Opts = see tracer/2

说明::

    This function is a shortcut allowing to start a trace with one command. 
    Each tuple in Patterns is converted to a list, which in turn is passed to ttb:tpl/2,3,4.

实例::

    > ttb:start_trace([Node, OtherNode],
                  [{mod, foo, []}, {mod, bar, 2}],
                  {all, call},
                  [{file, File}, {handler,{fun myhandler/4, S}}]).
    等同于
    > ttb:start_trace([Node, OtherNode],
                  [{file, File}, {handler,{fun myhandler/4, S}}]),
    ttb:tpl(mod, foo, []),
    ttb:tpl(mod, bar, 2, []),
    ttb:p(all, call).

.. function:: tracer/0/1/2

架构::

    tracer() -> Result
      => tracer(node())
    tracer(shell) -> Result
      => tracer(node(),[{file, {local, "ttb"}}, shell]).
    tracer(dbg) -> Result
      => tracer(node(),[{shell, only}]).
    tracer(Nodes) -> Result
      => tracer(Nodes,[])
    tracer(Nodes,Opts) -> Result
    类型:
    Result = {ok, ActivatedNodes} | {error,Reason}
    Nodes = atom() | [atom()] | all | existing | new
    Opts = Opt | [Opt]
    Opt = {file,Client} | 
          {handler, FormatHandler} | {process_info, true | false} | 
          shell | {shell, ShellSpec} | 
          {timer, TimerSpec} | 
          {overload_check, {MSec, Module, Function}} | {flush, MSec} | 
          resume | {resume, FetchTimeout} | {queue_size, QueueSize}

    
    FormatHandler = See format/2 
    TimerSpec = MSec | {MSec, StopOpts}
        MSec = integer()
        StopOpts = see stop/2
    FetchTimeout = integer()
    QueueSize = non_neg_integer()

{file,Client}::

    Client = File | {local, File} % tracing其他结点时,要用{local, File}
        File = Filename | Wrap
            Wrap = {wrap,Filename} | {wrap,Filename,Size,Count} 
                % 默认值:Size=128*1024 and Count=8
            Filename = string()  % 默认值:ttb

shell::

    Shortcut for {shell, true}.

{shell, ShellSpec} ::

    true | false | only









