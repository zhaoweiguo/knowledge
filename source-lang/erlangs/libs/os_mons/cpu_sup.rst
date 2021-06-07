cpu_sup模块
###############

util/0/1
'''''''''''
结构::

  util() -> CpuUtil | {error, Reason}
  类型:
  CpuUtil = float()

  util(Opts) -> UtilSpec | {error, Reason}
  类型:
  Opts = [detailed | per_cpu]
  UtilSpec = UtilDesc | [UtilDesc]
   UtilDesc = {Cpus, Busy, NonBusy, Misc}
    Cpus = all | int() | [int()]()
    Busy = NonBusy = {State, Share} | Share
     State = user | nice_user | kernel
      | wait | idle | atom()
     Share = float()
    Misc = []
  Reason = term()

实例::

  cpu_sup:util([per_cpu]).
  cpu_sup:util([detailed]).
  cpu_sup:util([detailed,per_cpu]).
  cpu_sup:util().


avg1/avg5/avg15
'''''''''''''''''''
结构::

  avg1() -> SystemLoad | {error, Reason}
  类型:
  SystemLoad = int()
  Reason = term()

说明::

  获得负载load的值(默认*256)

实例::

  erl> cpu_sup:avg1()/256.




