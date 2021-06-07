net_kernel [1]_
#####################
说明::

  net kernel是一个系统进程，只用于distributed Erlang.
  此进程的目的是实现BIFs spawn/4 and spawn_link/4的部分功能并提供网络监控


  $ erl -sname foobar
  =>
  1> net_kernel:start([foobar, shortnames]).
  {ok,<0.64.0>}



  $ erl -name foobar@host.com
  =>
  1> net_kernel:start(['foobar@host.com', longnames]).
  {ok,<0.64.0>}

.. function:: start/1

结构::

  start([Name]) -> {ok, pid()} | {error, Reason}
  start([Name, NameType]) -> {ok, pid()} | {error, Reason}
  start([Name, NameType, Ticktime]) -> {ok, pid()} | {error, Reason}
  类型:
  NameType = shortnames | longnames
  Reason = {already_started, pid()} | term()











.. [1] http://erlang.org/doc/man/net_kernel.html





