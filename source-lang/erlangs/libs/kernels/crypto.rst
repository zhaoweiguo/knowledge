crypto模块
=====================


strong_rand_bytes/1
'''''''''''''''''''''''''
作用::

  生成N bytes随机字串
  默认等同于openssl rand命令
  如缺少安全随机,random generator可能会失败并抛出low_entropy异常

用法::

  strong_rand_bytes(N) -> binary()
  N = integer()










