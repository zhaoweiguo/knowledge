dict模块
############

.. function:: update/3/4

结构::

  update(Key, Fun, Dict1) -> Dict2
  类型
  Dict1 = Dict2 = dict(Key, Value)
  Fun = fun((Value1 :: Value) -> Value2 :: Value)
  使用函数Fun更新Dict1指定Key对应的Value值.如Key不存在抛出异常.

  update(Key, Fun, Initial, Dict1) -> Dict2
  类型
  Dict1 = Dict2 = dict(Key, Value)
  Fun = fun((Value1 :: Value) -> Value2 :: Value)
  Initial = Value
  功能基本同上.当Key不存在时,赋值为Initial


内部调用::

  dict:append(Key, Val, D) ->
    dict:update(Key, fun (Old) -> Old ++ [Val] end, [Val], D).


.. function:: merge/3

结构::

    merge(Fun, Dict1, Dict2) -> Dict3
    类型
    Fun = fun((Key, Value1, Value2) -> Value)
    Dict1 = dict(Key, Value1)
    Dict2 = dict(Key, Value2)
    Dict3 = dict(Key, Value)

说明::

    合并两个dict. 新生成的dict包含两个dict中的所有的key,
    当有key相同时,执行函数Fun,函数类似下面但执行速度更快:

    merge(Fun, D1, D2) ->
        fold(fun (K, V1, D) ->
            update(K, fun (V2) -> Fun(K, V1, V2) end, V1, D)
         end, D2, D1).




