compile模块
###################

.. contents::
   :depth: 1
   :local:
   :backlinks: none

.. highlight:: console


parse_transform
'''''''''''''''''''''
首先我们要明确erlang中Abstract Format的概念，这个我就不重复了，大家可以直接http://erlang.org/doc/apps/erts/absform.html



查看源码::

  f().
  Beam = "./_build/default/lib/esockd/ebin/esockd_acceptor_sup.beam".
  {ok, {_, [{abstract_code, {_,Abs}}]}} =  beam_lib:chunks(
    Beam, [abstract_code]).
  io:fwrite("~s~n", [erl_prettypr:format(erl_syntax:form_list(Abs))]).


file/2
''''''''''''
格式::

  file(File, Options) -> CompRet

  类型:
  CompRet = ModRet | BinRet | ErrRet
  ModRet = {ok,ModuleName} | {ok,ModuleName,Warnings}
  BinRet = {ok,ModuleName,Binary} | {ok,ModuleName,Binary,Warnings}
  ErrRet = error | {error,Errors,Warnings}

常见的Option::

  debug_info: 
  warnings_as_errors:
  {i,Dir}: -include or -include_lib指令
  {d,Macro}, {d,Macro,Value}: 定义宏的值,其中Macro为原子,Value为term(),默认为true。
  {parse_transform,Module}: 在代码检错前,Module:parse_transform/2需要被提前实现
    当想用Erlang原有的语法但想实现不同的功能时使用.原始的Erlang代码会被转化成你想要的语法


借助recon::

  // 监听
  recon_trace:calls({lager_transform,insert_record_attribute,1}, 1, [{scope, local}]).
  // 运行辅助监听
  c("lib/demo_lager-0.1.0/src/demo_lager_server", [{parse_transform,lager_transform}]).






