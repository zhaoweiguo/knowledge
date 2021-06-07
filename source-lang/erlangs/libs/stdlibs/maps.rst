maps模块
#############

.. function:: find/2

结构::

  find(Key, Map) -> {ok, Value} | error
  Types
  Key = term()
  Map = map()
  Value = term()

说明::

  返回Map中key为Key对应的value

实例::

  > Map = #{"hi" => 42},
    Key = "hi",
    maps:find(Key,Map).
  {ok,42}

.. function:: fold/3

::

    注: OTP 17.0增加
    fold(Fun, Init, MapOrIter) -> Acc
    类型:
    Fun = fun((Key, Value, AccIn) -> AccOut)
    Init = term()
    Acc = AccOut
    AccIn = Init | AccOut
    MapOrIter = #{Key => Value} | iterator(Key, Value)

实例::

    Map = #{<<"25">> => <<"11111">>,
              <<"code">> => <<"scene_data_v2">>,
              <<"t">> => 1582010130302,
              <<"value">> => <<"Gordon">>
              }.
    Fun = fun(Key, Value, AccIn) ->
                  io:format("Key=~p, Value=~p~n", [Key, Value]),
                  [{Key, Value}] ++ AccIn
               end.
    Init = [].
    maps:fold(Fun, Init, Map).
    [{<<"value">>,<<"Gordon">>},
     {<<"t">>,1582010130302},
     {<<"code">>,<<"scene_data_v2">>},
     {<<"25">>,<<"11111">>}]

.. function:: from_list/1

::

    from_list(List) -> Map
    类型:
    List = [{Key, Value}]
    Key = Value = term()
    Map = map()

实例::

    erl> List = [{"a",ignored},{1337,"value two"},{42,value_three},{"a",1}].
    erl> maps:from_list(List).
    #{42 => value_three,1337 => "value two","a" => 1}


.. function:: get/2/3

::

    get(Key, Map) -> Value
    类型
    Key = term()
    Map = map()
    Value = term()

说明::

    如原Map中含有Key, 返回Map中key为Key对应的value
    如原Map中不含有Key, {badkey,Key}
    Map不是map类型, {badmap,Map}

get/3::

    如原Map中不含有Key, 则返回默认值

实例::

    > Key = 1337,
    > Map = #{42 => value_two,1337 => "value one","a" => 1},
    > maps:get(Key, Map).
    "value one"

    > Map = #{ key1 => val1, key2 => val2 }.
    #{key1 => val1,key2 => val2}
    > maps:get(key1, Map, "Default value").
    val1
    > maps:get(key3, Map, "Default value").
    "Default value"


.. function:: merge/2

结构::

  merge(Map1, Map2) -> Map3
  类型:
  Map1 = Map2 = Map3 = map()

说明::

  Merges two maps into a single map Map3. 
  If two keys exist in both maps, the value in Map1 is superseded by the value in Map2.

  The call fails with a {badmap,Map} exception if Map1 or Map2 is not a map.

实例::

  > Map1 = #{a => "value_one", b => "value_two"},
    Map2 = #{a => 1, c => 2},
    maps:merge(Map1,Map2).
  #{a => 1,b => "value_two",c => 2}

.. function:: put/3

结构::

  put(Key, Value, Map1) -> Map2
  Types
  Key = Value = term()
  Map1 = Map2 = map()

说明::

  往map中插入一条记录{Key, Value},如原Map1中含有Key,则替换此值

实例::

  > Map = #{"a" => 1}.
  #{"a" => 1}
  > maps:put("a", 42, Map).
  #{"a" => 42}
  > maps:put("b", 1337, Map).
  #{"a" => 1,"b" => 1337}


.. function:: remove/2

结构::

  remove(Key, Map1) -> Map2
  Types
  Key = term()
  Map1 = Map2 = map()

说明::

  移除此Key对应的记录

实例::

  > Map = #{"a" => 1}.
  #{"a" => 1}
  > maps:remove("a",Map).
  #{}
  > maps:remove("b",Map).
  #{"a" => 1}









