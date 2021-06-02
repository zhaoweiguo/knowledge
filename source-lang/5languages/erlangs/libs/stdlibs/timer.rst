timer模块
################


sleep/1
''''''''''''
结构::

  sleep(Time) -> ok
  Time:单位ms,可设置为infinity



tc/1/2/3
''''''''''''
结构::

  tc(Fun) -> {Time, Value}
  tc(Fun, Arguments) -> {Time, Value}
  tc(Module, Function, Arguments) -> {Time, Value}
  类型:
  Module = module()
  Function = atom()
  Arguments = [term()]
  Time = integer() % 单位:microseconds
  Value = term()

tc/3::

  评估执行:apply(Module, Function, Arguments)
  并用函数erlang:monotonic_time/0测量执行时间.

  返回值:{Time, Value}
  其中: 
    Time执行时间(单位microseconds)
    Value是执行的返回值

tc/2::

  执行apply(Fun, Arguments). 其他等同tc/3

tc/1::

  执行Fun().其他等同tc/3.






