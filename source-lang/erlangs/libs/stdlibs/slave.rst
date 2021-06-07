slave模块
##############

作用::

  启动和控制slave节点的函数

说明::

  slave节点由master节点启动,且master死掉slave自动死掉
  所有的slave的terminal output都会返回master结点.File I/O由master来做
  slave结点在其它主机上的,启动时要加rsh选项(需确保无密登录)
  slave与master有相同的文件系统
  Erlang/OTP需要安装相同版本,且是相同的版本


start/1/2/3
''''''''''''''''
结构::

    start(Host) -> {ok, Node} | {error, Reason}
    start(Host, Name) -> {ok, Node} | {error, Reason}
    start(Host, Name, Args) -> {ok, Node} | {error, Reason}
    类型:
    Reason = timeout | no_rsh | {already_running, Node}

说明:

  








