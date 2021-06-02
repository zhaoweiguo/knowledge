.. _erl_ets:

ets模块
################

基本使用
''''''''''''''
all/0::

  all() -> [Tab]

lookup/2::

  lookup(Tab, Key) -> [Object]

tab2file/2/3::

  tab2file/2(Tab, Filename) -> ok | {error, Reason}
  等同于tab2file(Tab, Filename,[])

  tab2file(Tab, Filename, Options) -> ok | {error, Reason}
  类型:
  Options = [Option]
  Option = {extended_info, [ExtInfo]} | {sync, boolean()}
  ExtInfo = md5sum | object_count

tab2list/1::

  tab2list(Tab) -> [Object]

.. function:: ets:info/1/2

结构::

    info(Tab) -> InfoList | undefined
    info(Tab, Item) -> Value | undefined
    类型:
    Tab = tab()
    InfoList = [InfoTuple]
    InfoTuple = 
        {compressed, boolean()} |
        {heir, pid() | none} |
        {id, tid()} |
        {keypos, integer() >= 1} |
        {memory, integer() >= 0} |
        {name, atom()} |
        {named_table, boolean()} |
        {node, node()} |
        {owner, pid()} |
        {protection, access()} |
        {size, integer() >= 0} |
        {type, type()} |
        {write_concurrency, boolean()} |
        {read_concurrency, boolean()}

实例::

    % 常用于检查是否有此表
    erl> ets:info(not_exit_tab).
    undefined



.. function:: new/2

结构::

    new(Name, Options) -> tid() | atom()
    类型:
    Name = atom()
    Options = [Option]
    Option = 
        Type |
        Access |
        named_table |
        {keypos, Pos} |
        {heir, Pid :: pid(), HeirData} |
        {heir, none} |
        Tweaks
    Type = set | ordered_set | bag | duplicate_bag
    Access = public | protected | private
    Tweaks = 
        {write_concurrency, boolean()} |
        {read_concurrency, boolean()} |
        compressed
    Pos = integer() >= 1
    HeirData = term()

实例::

  ets:new(abc, [named_table, public]).


.. function:: ets:delete/1/2

delete/1::

  delete(Tab) -> true
  删除整个Tab表

delete/2::

  delete(Tab, Key) -> true
  类型:
    Tab = tab()
    Key = term()
  删除表Tab中key为Key的所有对象

.. function:: ets:insert/2

结构::

  insert(Tab, ObjectOrObjects) -> true

实例::

  1> T = ets:new(x,[]).
  2> ets:insert(T, {key, [1, 2, 3]}).

  1> T = ets:new(x,[ordered_set]).
  2> [ ets:insert(T,{N}) || N <- lists:seq(1,10) ].

  1> true = ets:insert(Tab = ets:new(t, []), [{1,a},{2,b},{3,c},{4,d}]),

.. function:: ets:update_counter/3/4

结构::

    update_counter(Tab, Key, UpdateOp) -> Result
    update_counter(Tab, Key, UpdateOp, Default) -> Result
    其中:
    UpdateOp = {Pos, Incr} | {Pos, Incr, Threshold, SetValue}

    update_counter(Tab, Key, X3 :: [UpdateOp]) -> [Result]
    update_counter(Tab, Key, X3 :: [UpdateOp], Default) -> [Result]
    
    update_counter(Tab, Key, Incr) -> Result
    update_counter(Tab, Key, Incr, Default) -> Result

    其中: 
    Pos = Incr = Threshold = SetValue = Result = integer()
    Default = tuple()

说明::

    更新指定key对应的计数器

实例::

    53> ets:new(abc, [named_table, public]).
    abc
    54> ets:insert(abc, {a, 2, 1, 1}).
    true
    55> ets:update_counter(abc, a, 5).
    7
    56> ets:update_counter(abc, a, {3, 5}). % 指定pos为3的加5
    6
    57> ets:tab2list(abc).
    [{a,7,6,1}]
    58> ets:update_counter(abc, a, [{3, 1}, {4, 2}]).   % 更新多个
    [7,3]
    59> ets:tab2list(abc).
    [{a,7,7,3}]
    % 按key查不到, 设定为default的值,且执行加Incr操作
    60> ets:update_counter(abc, e, 1, {d, 1, 3, 1}).
    2
    61> ets:tab2list(abc).
    [{d,2,3,1},{a,7,7,3}]



以下会报badarg::

    1. The table type is not set or ordered_set.
    2. No object with the correct key exists and no default object was supplied.
    3. The object has the wrong arity.
    4. The default object arity is smaller than <keypos>.
    5. Any field from the default object that is updated is not an integer.
    6. The element to update is not an integer.
    7. The element to update is also the key.
    8. Any of Pos, Incr, Threshold, or SetValue is not an integer.











