app模块 [1]_
##############

结构::

  {application, Application,
  [{description,  Description},
   {id,           Id},
   {vsn,          Vsn},
   {modules,      Modules},
   {maxP,         MaxP},
   {maxT,         MaxT},
   {registered,   Names},
   {included_applications, Apps},
   {applications, Apps},
   {env,          Env},
   {mod,          Start},
   {start_phases, Phases},
   {runtime_dependencies, RTDeps}]}.

说明::


               Value                Default
               -----                -------
  Application  atom()               -
  Description  string()             ""
  Id           string()             ""
  Vsn          string()             ""
  Modules      [Module]             []
  MaxP         int()                infinity
  MaxT         int()                infinity
  Names        [Name]               []
  Apps         [App]                []
  Env          [{Par,Val}]          []
  Start        {Module,StartArgs}   []
  Phases       [{Phase,PhaseArgs}]  undefined
  RTDeps       [ApplicationVersion] []

  Module = Name = App = Par = Phase = atom()
  Val = StartArgs = PhaseArgs = term()
  ApplicationVersion = string()


start_phases::

  在调用Module:start/2时，使用:
  在调用Module:start_phase(Phase,Type,PhaseArgs)后才返回
  所以要指定{mod, {application_starter,[Module,StartArgs]}}
  参数start_phases有几条,就要执行几次Module:start_phase/3
  如:
    {start_phases, [
      {load_config, []},
      {start_os_monitoring,[{timeout,30000}]},
      {start_clients,[]}]}
    则有以下3个子函数:
    start_phase(load_config, _StartType, _PhaseArgs) ->
    start_phase(start_os_monitoring, _StartType, _PhaseArgs) ->
    start_phase(start_clients, _StartType, _PhaseArgs) ->

registered::

  已注册进程的所有名称均在此应用程序中启动 
  systools使用此列表来检测不同应用程序之间的名称冲突













.. [1] http://erlang.org/doc/man/app.html





