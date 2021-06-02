
.. highlight:: console

.. _normal:

基本使用
------------------

.. function:: byte_size/1

::

  // Bitstring有多少个bytes,不够8位的也按1个算
  byte_size(Bitstring) -> integer() >= 0
  > byte_size(<<433:16,3:3>>).
  3
  > byte_size(<<1,2,3>>).
  3

.. function:: element/2

::

  // 返回第N个元素值,N从1开始
  element(N, Tuple) -> term()

.. function:: iolist_to_binary/1

::

  // 把iolist() | binary()数据转为binary()
  iolist_to_binary(IoListOrBinary) -> binary()
  > Bin1 = <<1,2,3>>.
  <<1,2,3>>
  > Bin2 = <<4,5>>.
  <<4,5>>
  > Bin3 = <<6>>.
  <<6>>
  > iolist_to_binary([Bin1,1,[2,3,Bin2],4|Bin3]).
  <<1,2,3,1,2,3,4,5,4,6>>


.. function:: trunc/1

::

  trunc(Number) -> integer()
  类型:
  Number = number()
  实例:
  erl> trunc(5.5).
  5


.. function:: tuple_size/1

::

  // 返回Tuple的个数
  tuple_size(Tuple) -> integer() >= 0
  tuple_size({morni, mulle, bwange}).  // 3


.. function:: pid_to_list/1

::

  pid_to_list(Pid).

.. function:: list_to_pid/1

::

  list_to_pid("<0.0.0>").
  % pid(0,0,0). 只适用于shell

