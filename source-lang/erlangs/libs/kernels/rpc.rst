rpc模块
##########
Remote Procedure Call services

call/4/5
''''''''''''
结构::

  call(Node, Module, Function, Args) -> Res | {badrpc, Reason}
  call(Node, Module, Function, Args, Timeout) ->
          Res | {badrpc, Reason}
  类型:
  Node = node()
  Module = module()
  Function = atom()
  Args = [term()]
  Res = Reason = term()


multicall/3/4/5
''''''''''''''''''
结构::

  multicall/3:
  multicall([node()|nodes()], Module, Function, Args, infinity).
  multicall/4:
  multicall([node()|nodes()], Module, Function, Args, Timeout).

  multicall(Nodes, Module, Function, Args, Timeout) ->
             {ResL, BadNodes}
  类型:
  Nodes = [node()]
  ResL = [Res :: term() | {badrpc, Reason :: term()}]
  BadNodes = [node()]

说明::

  并发调用多个node的rpc请求

实例::

  %% Find object code for module Mod
  {Mod, Bin, File} = code:get_object_code(Mod),
  %% and load it on all nodes including this one
  {ResL, _} = rpc:multicall(code, load_binary, [Mod, File, Bin]),
  %% and then maybe check the ResL list.








