proplists模块
###################
::

  // 返回列表的key,不包含重复荐
  // 必须是k/v格式
  get_keys(List) -> [term()]
  proplists:get_keys(application:which_applications()).

  // 得到指定key对应的value
  // 必须是k/v格式
  get_value(Key, List) -> term()

  // 查询指定key的值
  lookup(Key, List) -> none | tuple()
  例:
  proplists:lookup(lager, application:which_applications()).



.. function:: append_values/2

::

    append_values(Key, ListIn) -> ListOut
    类型:
    Key = term()
    ListIn = ListOut = [term()]

说明::

    类似get_all_values/2,但除非它本身已经是list,否则每个值都会被封装进list中
    生成的列表被连接在一起

实例::

    erl> proplists:append_values(a, [{a, [1,2]}, {a, 3}, {c, -1}, {a, [4]}]).
    [1,2,3,4]






