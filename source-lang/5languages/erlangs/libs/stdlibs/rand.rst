rand模块
================

::

  // 随机返回0.0-1.0
  uniform() -> float()
  // 随机返回1-N
  uniform(N) -> integer() >= 1


seed/1/2
-------------

结构::

    seed(AlgOrStateOrExpState) -> state()
    类型:
    AlgOrStateOrExpState = builtin_alg() | state() | export_state()
      builtin_alg() = exs64 | exsplus | exsp | exs1024 | exs1024s | exrop
         
实例::

    rand:seed(exs64).






