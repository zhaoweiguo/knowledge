.. _etop:

etop模块
###############
说明::

  etop是Erlang提供的类似于top命令，它的输出格式和功能都与top类似，提供了必要的节点信息和进程信息

常用用法::

  % 查看占用CPU最高的进程 每10秒输出一次
  > spawn(fun() -> etop:start([{interval,10}, {sort, runtime}]) end). 
  % 查看占用内存最高的进程 每10秒输出一次 输出进程数量为20
  > spawn(fun() -> etop:start([{interval,10}, {sort, memory}, {lines,20}]) end). 
  

远程节点连接::

  % 按内存排序, 显示前20条
  > erl -name abcd@127.0.0.1 -hidden -s etop -output text -sort memory -lines 20 -node 'server_node@127.0.0.1' -setcookie galaxy_server

  % 上面操作的另一个实现方式
  > erl -name abc@127.0.0.1 -hidden  -setcookie galaxy_server
  > etop:start([{node,'server_node@127.0.0.1'}, {output, text}, {lines, 20},  {sort, memory}]).

  % 连接远程节点方式三
  > erl -name abc@127.0.0.1 -setcookie galaxy_server
  >  rpc:call('server_node@127.0.0.1', etop, start, [[{output, text}, {lines, 20},  {sort, memory}]]).


常见选项::

  node: 要监控的节点
  setcookie: 要监控的节点的cookie
  lines: 要监控的条数,默认10
  interval: 设定监控间隔,默认5s
  accumulate: 精度,默认false,为true时execution time and reductions are accumulated.
  sort:排序方式,
      Value: runtime | reductions | memory | msg_q
      Default: runtime (reductions if tracing=off)
  tracing:
    etop使用erlang跟踪工具,当etop运行时,除非tracing=off,否则其他跟踪工具是不可用的.
    Value: on | off
    Default: on





