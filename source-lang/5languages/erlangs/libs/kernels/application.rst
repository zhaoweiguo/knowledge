application模块
########################

.. contents::
   :depth: 1
   :local:
   :backlinks: none

.. highlight:: console

::

  applictaion:get_all_env().
  applictaion:get_all_env(App).


get_env/1/2
'''''''''''

格式::

  applictaion:get_env(Par).
  applictaion:get_env(App, Par).

实例::

    application:get_env(octopus).


set_env/2/3
'''''''''''

格式::

    applictaion:set_env(App, Key, Value).

实例::

    applictaion:set_env(octopus, port, 80).


start/1/2
'''''''''''''
结构::

  start(Application) -> ok | {error, Reason}
  start(Application, Type) -> ok | {error, Reason}
  类型:
  Application = atom()
  Type = restart_type()
  Reason = term()

步骤::

  1.如果没有reload,先调用reload/1加载
  2.检查env下参数applications下的app是否全部启动,如没有,返回:{error,{not_started,App}}
  3.建立application master用于以后管理子进程
  4.查env下参数mod的值Module,并执行Module:start/2函数

Type参数::

  默认为temporary
  可选参数:permanent | transient | temporary

  permanent: 如果app终止了,那么整个系统都会停止工作.通过调用application:stop/1 手动终止app的情况除外
  transient: 如果 app 以 normal 的原因终止, 没有影响. 任何其他终止原因都会导致整个系统关闭
  temporary: application 可以以任何原因终止, 只会产生报告, 没有其他任何影响

Module:start/2
''''''''''''''''''''
结构::

  Module:start(StartType, StartArgs) -> {ok, Pid} | {ok, Pid, State} | {error, Reason}
  类型:
  StartType = 
        normal |
        {takeover, Node :: node()} |
        {failover, Node :: node()}
  StartArgs = term()
  Pid = pid()
  State = term()

说明::

  当调用application:start/1/2时调用,并启动此application的进程
  if此application是基于OTP设计原则的结构作为supervision树,则means:
    启动top supervisor tree

StartType参数::

  normal: 如是normal启动
  normal:  if the application is distributed and started at the current node 
            because of a failover from another node, and the application 
            specification key start_phases == undefined.
  {takeover,Node} if the application is distributed and started at the current node 
                    because of a takeover from Node, either because takeover/2 has 
                    been called or because the current node has higher priority than Node.
  {failover,Node} if the application is distributed and started at the current node
                   because of a failover from Node, and the application 
                   specification key start_phases /= undefined.

StartArgs::

  env中mod参数给定的值

返回值::

  {ok,Pid} or {ok,Pid,State}
  State: 任何值，当application stop时会传递给Module:prep_stop/1


Module:stop/1
'''''''''''''''''''''
结构::

  Module:stop(State)
  类型
  State = term()

说明::

  if 函数 Module:prep_stop/1存在, State是它的返回值, 
  if 函数 Module:prep_stop/1不存在, State是 Module:start/2的返回值






