lists模块
################

duplicate/2
'''''''''''''''
结构::

    duplicate(N, Elem) -> List
    类型
    N = integer() >= 0
    Elem = T
    List = [T]
    T = term()

说明::

    Returns a list containing N copies of term Elem.

实例::

    > lists:duplicate(5, xx).
    [xx,xx,xx,xx,xx]




filter/2
'''''''''''''
用法::

    filter(Pred, List1) -> List2
    类型
    Pred = fun((Elem :: T) -> boolean())
    List1 = List2 = [T]
    T = term()

说明::

    List2是List1中的元素在执行Pred(Elem)函数时返回true的列表

filtermap/2
'''''''''''''''
用法::

    filtermap(Fun, List1) -> List2
    类型:
    Fun = fun((Elem) -> boolean()| {true, Value})
    List1 = [Elem]
    List2 = [Elem | Value]

说明::

    按函数Fun进行过滤

代码展示实现功能::

    filtermap(Fun, List1) ->
      lists:foldr(
        fun(Elem, Acc) ->
           case Fun(Elem) of
               false -> Acc;
               true -> [Elem|Acc];
               {true,Value} -> [Value|Acc]
           end
        end, [], List1).

实例::

  > lists:filtermap(
    fun(X) -> 
      case X rem 2 of 
        0 -> {true, X div 2}; 
        _ -> false 
      end 
    end, [1,2,3,4,5]).
  结果:[1,2]



foreach/2
'''''''''''''
用法::

  foreach(Fun, List) -> ok
  类型:
  Fun = fun((Elem :: T) -> term())
  List = [T]
  T = term()

说明::

  对List中的每个元素调用Fun(Elem)
  得到的结果顺序与List顺序相同

实例::

    L1 = [1,2,3,4,5].
    lists:foreach(fun(X) -> io:format("~p~n", [X]) end, L1).

    L2 = [{a1, b1}, {a2, b2}, {a3, b3}].
    Fun = fun({A, _}) -> 
        io:format("~p~n", [A]) 
    end.
    lists:foreach(Fun, L2).


foldl/3
'''''''''''''''
用法::

    foldl(Fun, Acc0, List) -> Acc1
    类型:
    Fun = fun((Elem :: T, AccIn) -> AccOut)
    Acc0 = Acc1 = AccIn = AccOut = term()
    List = [T]
    T = term()

解释::

    遍历List, 一次次执行Fun/2函数, 
    Fun/2函数:
    第1个参数是List中的每次的值, 
    第2个参数初使值为Acc0, 之后每次是前一次的结果

实例::

    > lists:foldl(fun(X, Sum) -> X + Sum end, 0, [1,2,3,4,5]).
    15
    > lists:foldl(fun(X, Prod) -> X * Prod end, 1, [1,2,3,4,5]).
    120


keyfind/3
''''''''''''''
用法::

    keyfind(Key, N, TupleList) -> Tuple | false
    类型:
    Key = term()
    N = integer() >= 1
    1..tuple_size(Tuple)
    TupleList = [Tuple]
    Tuple = tuple()

解释::

    取出指定key对应的tuple

实例::

    > lists:keyfind(a, 1, [{a,1}, {b,2}]).
    {a, 1}
    > lists:keyfind(a, 1, [{ad,1}, {b,2}, {a,a,b}]).
    {a, a, b}


keymember/3
''''''''''''''
用法::

    keyfind(Key, N, TupleList) -> true | false
    类型:
    Key = term()
    N = integer() >= 1
    1..tuple_size(Tuple)
    TupleList = [Tuple]
    Tuple = tuple()

解释::

    查询tuple列表TupleList，并把它的第N个元素与Key对比是否相同
    如果相同返回true，否则返回false

实例::
  
    lists:keymember(octopus, 1, application:which_applications()).


keyreplace/4
'''''''''''''''''
用法::

  keyreplace(Key, N, TupleList1, NewTuple) -> TupleList2
  类型:
  Key = term()
  N = integer() >= 1; 1..tuple_size(Tuple)
  TupleList1 = TupleList2 = [Tuple]
  NewTuple = Tuple
  Tuple = tuple()

说明::

  如果TupleList1中的tuple的第N位的值等于Key,则把此tuple的值替换为NewTuple

实例::

  %% 示例
  lists:keyreplace(env, 1, AppSpec, {env, Env}).
  %% 实例
  1> List = [{key1, value1}, {key2, value2}].
  [{key1,value1},{key2,value2}]
  2> lists:keyreplace(key1, 1, List, {key1, abc}).
  [{key1,abc},{key2,value2}]

keysort/2
''''''''''''''
用法::

  keysort(N, TupleList1) -> TupleList2
  类型:
  N = integer() >= 1
  TupleList1 = TupleList2 = [Tuple]

说明::

  Returns a list containing the sorted elements of list TupleList1. Sorting is performed on the Nth element of the tuples. The sort is stable.


keytake/3
'''''''''''''
用法::

    keytake(Key, N, TupleList1) -> {value, Tuple, TupleList2} | false

说明::

    把TupleList1中第N列与Key对比,如果都不相同返回false,
    如果相同, Tuple即为第1个与Key相同的值, TupleList2是去除了Tuple后的tuple列表

实例::

    > lists:keytake(a, 1, [{ad,1}, {b,2}, {a,a,b}]).
    {value,{a,a,b},[{ad,1},{b,2}]}


member/2
''''''''''''
用法::

    member(Elem, List) -> boolean()
    类型:
    Elem = T
    List = [T]
    T = term()

解释::

    如果列表List中有Elem返回true，否则返回true

实例::

    1> List = [1,2,3,4,5].
    [1,2,3,4,5]
    2> lists:member(3, List).
    true

partition/2
''''''''''''''''
用法::

  partition(Pred, List) -> {Satisfying, NotSatisfying}
  类型:
  Pred = fun((Elem :: T) -> boolean())
  List = Satisfying = NotSatisfying = [T]
  T = term()

说明::

  对列表进行区分,Pred函数执行为true的归类到Satisfying,其他的归类到NotSatisfying

实例::

  > lists:partition(fun(A) -> A rem 2 == 1 end, [1,2,3,4,5,6,7]).
  {[1,3,5,7],[2,4,6]}
  > lists:partition(fun(A) -> is_atom(A) end, [a,b,1,c,d,2,3,4,e]).
  {[a,b,c,d,e],[1,2,3,4]}


排序相关
'''''''''''

.. function:: sort/1

::

  sort(List1) -> List2
  类型:
  List1 = List2 = [T]
  T = term()

说明::

  Returns a list containing the sorted elements of List1.

.. function:: sort/2

::

  sort(Fun, List1) -> List2
  类型:
  Fun = fun((A :: T, B :: T) -> boolean())
  List1 = List2 = [T]
  T = term()

说明::

  基于排序函数Fun, 返回排序的列表List1
  函数Fun(A, B): 如果A<=B, 则返回true; 反之返回false

实例1::

  % 最简单实例
  Fun = fun(A, B) ->
    A =< B
  end.
  List = [1, 3, 5, 2, 6, 4].
  lists:sort(Fun, List).

实例2::

  % 取出所有进程reductions最高的前5个进程
  Fun = fun({reductions,R1}, {reductions,R2}) ->
    R1 > R2
  end.
  List = [process_info(Pid, reductions) || Pid <- processes()].
  lists:sublist(lists:sort(Fun, List), 5).

实例3::

  % 列表中列表
  Fun = fun(List1, List2) ->
    {reductions,R1} = lists:nth(1, List1),
    {reductions,R2} = lists:nth(1, List2),
    R1 > R2
  end.
  List = [process_info(Pid, [reductions, registered_name]) || Pid <- processes()].
  lists:sublist(lists:sort(Fun, List), 5).




.. function:: split/2

::

    split(N, List1) -> {List2, List3}

    类型:
    N = integer() >= 0
        0..length(List1)
    List1 = List2 = List3 = [T]
    T = term()

说明::

    拆分List1,拆分后
    List2包含前N个元素
    List3包含剩下的元素


.. function:: prefix/2

::

    prefix(List1, List2) -> boolean()
    类型
    List1 = List2 = [T]
    T = term()
    如果List1是List2的prefix返回true，否则返回false

实例::

  14 > lists:prefix([], []). 
  true
  15> lists:prefix([abc], [abc, def]).
  true
  16> lists:prefix([abc], [abcdef]).
  false

.. function:: zip/2

结构::

    zip(List1, List2) -> List3
    Types
    List1 = [A]
    List2 = [B]
    List3 = [{A, B}]
    A = B = term()

说明::

    把两个长度相同的列表List1, List2合并成一个两元素tuple的新列表的List3

实例::

    $> List1 = [a, b, c].
    $> List2 = [1, 2, 3].
    $> lists:zip(List1, List2).
    [{a,1},{b,2},{c,3}]

.. function:: zip3/3

结构::

    zip3(List1, List2, List3) -> List4
    Types
    List1 = [A]
    List2 = [B]
    List3 = [C]
    List4 = [{A, B, C}]
    A = B = C = term()

说明::

    参见zip/2

实例::

    $> List3 = ['!', '@', '#'].
    $> lists:zip3(List1, List2, List3).
    [{a,1,'!'},{b,2,'@'},{c,3,'#'}]







