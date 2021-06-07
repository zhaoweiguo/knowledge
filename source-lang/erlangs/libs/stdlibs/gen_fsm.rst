gen_fsm模块
###################

说明::

  OTP 20 [erts-9.0]之后变成Deprecated
  被替换为gen_statem

  有限状态机:finite state machine

行为函数与回调函数的关系::

  gen_fsm module                    Callback module
  --------------                    ---------------
  gen_fsm:start
  gen_fsm:start_link                -----> Module:init/1

  gen_fsm:stop                      -----> Module:terminate/3

  gen_fsm:send_event                -----> Module:StateName/2

  gen_fsm:send_all_state_event      -----> Module:handle_event/3

  gen_fsm:sync_send_event           -----> Module:StateName/3

  gen_fsm:sync_send_all_state_event -----> Module:handle_sync_event/4

  -                                 -----> Module:handle_info/3

  -                                 -----> Module:terminate/3

  -                                 -----> Module:code_change/4

Module:init(Args) -> Result
''''''''''''''''''''''''''''''''
::

  Args = term()
  Result = {ok,StateName,StateData} | {ok,StateName,StateData,Timeout}
    | {ok,StateName,StateData,hibernate}
    | {stop,Reason} | ignore
   StateName = atom()
   StateData = term()
   Timeout = int()>0 | infinity
   Reason = term()





enter_loop/4/5/6
'''''''''''''''''''''''
::

  enter_loop(Module, Options, StateName, StateData)
  enter_loop(Module, Options, StateName, StateData, FsmName)
  enter_loop(Module, Options, StateName, StateData, Timeout)
  enter_loop(Module, Options, StateName, StateData, FsmName, Timeout)
  类型:
  Module = atom()
  Options = [Option]
   Option = {debug,Dbgs}
    Dbgs = [Dbg]
     Dbg = trace | log | statistics| {log_to_file,FileName} | {install,{Func,FuncState}}
     StateName = atom()
  StateData = term()
  FsmName = {local,Name} | {global,GlobalName} | {via,Module,ViaName}
   Name = atom()
   GlobalName = ViaName = term()
  Timeout = int() | infinity















