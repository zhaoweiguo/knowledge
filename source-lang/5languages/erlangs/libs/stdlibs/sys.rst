sys模块
###########

A functional interface to system messages.

.. function:: install/2/3

结构::

    install(Name, FuncSpec) -> ok
    install(Name, FuncSpec, Timeout) -> ok
    类型:
    Name = name()
    FuncSpec = {Func, FuncState} | {FuncId, Func, FuncState}
    FuncId = term()
    Func = dbg_fun()
    FuncState = term()
    Timeout = timeout()

说明::

    开启备用函数调试功能。 
    这种函数的一个示例是触发器，等待某些特殊事件并在生成事件时执行某些操作的函数。 
    如:打开低级别跟踪。

    每当生成系统事件时都会调用Func。 
    此函数将返回done或新的Func状态。 
    函数返回done或函数失败，就会被删除。 
    如果调试功能需要安装多次，则必须为每个安装指定唯一的FuncId


.. function:: debug_options

结构::

    debug_options(Options) -> [dbg_opt()]
    类型:
    Options = [Opt]
    Opt = 
        trace |
        log |
        {log, integer() >= 1} |
        statistics |
        {log_to_file, FileName} |
        {install, FuncSpec}
    FileName = file:name()
    FuncSpec = {Func, FuncState} | {FuncId, Func, FuncState}
    FuncId = term()
    Func = dbg_fun()
    FuncState = term()

说明::

    Can be used by a process that initiates a debug structure from a list of options. 
    The values of argument Opt are the same as for the corresponding functions.   
    

.. function:: handle_system_msg

结构::

    handle_system_msg(Msg, From, Parent, Module, Debug, Misc) ->
                     no_return()
    类型:
    Msg = term()
    From = {pid(), Tag :: term()}
    Parent = pid()
    Module = module()
    Debug = [dbg_opt()]
    Misc = term()

说明::

    This function is used by a process module to take care of system messages. 
    The process receives a {system, From, Msg} message and passes Msg and From to this function.

    This function never returns. It calls either of the following functions:
      1. Module:system_continue(Parent, NDebug, Misc), where the process continues the execution.
      2. Module:system_terminate(Reason, Parent, Debug, Misc), if the process is to terminate.
    Module must export the following:
      1. system_continue/3
      2. system_terminate/4
      3. system_code_change/4
      4. system_get_state/1
      5. system_replace_state/2













