eunit
##########

* doc [1]_ 
* guide [2]_
* rebar3相关参见 :ref:`rebar3 <rebar3_eunit>`
* 测试相关参见 :ref:`testing <testing>`

Eunit是Erlang的单元测试工具,Eunit建立在面向对象的单元测试Junit之上,接合了函数和并发式语言的特点

Getting started
=====================


包含eunit头文件
--------------------
使用::

  -include_lib("eunit/include/eunit.hrl").

有两个影响::

  1.1: 创建exported的函数test()
  1.2: 自动export以_test()和_test_()结尾的函数
  1.3: 让EUnit preprocessor macros生效

.. note:: 
  为让-include_lib生效,Erlang module search path必须包含eunit/ebin
  如:
  erlc -pa "path/to/eunit/ebin" $(ERL_COMPILE_FLAGS) -o$(EBIN) $<
  or
  code:add_path("/path/to/eunit/ebin").

简单的测试函数
------------------
实例1-用于检测函数里面是否有崩溃::

  成功: 没有抛出异常
  失败: 抛出异常
  reverse_test() -> lists:reverse([1,2,3]).

实例2-Use exceptions to signal failure::

  reverse_nil_test() -> [] = lists:reverse([]).
  reverse_one_test() -> [1] = lists:reverse([1]).
  reverse_two_test() -> [2,1] = lists:reverse([1,2]).

实例3-Using assert macros::

  length_test() -> ?assert(length([1,2,3]) =:= 3).
  ?assert不为true抛出异常


Running EUnit
----------------
如你已经加了eunit.hrl文件，刚执行::

    m:test()

    eunit:test(m): 等同于m:test()
    eunit:test({inparallel, m}) : 并行运行m:test()

分离测试模块::

  模块名: m_tests(测试模块名为m时)
  主要用于测试m模块-exported()的函数

标准输出::

  % eunit默认捕捉标准写入,所以想直接打印到控制台需要用:
  io:format(user, "~w", [Term]).


Writing test generating functions
---------------------------------------
简单测试函数缺点::

    每个测试用例都要写一个单独的函数，并起一个名字
    太麻烦，于是测试生成函数出现了

测试生成函数::

    是编写返回测试的函数，而不是测试
    名称以xxxx_test_()结尾的函数
    测试生成器返回由EUnit执行的一组测试

实例: 最简单的::

  basic_test_() ->
    fun () -> ?assert(1 + 1 =:= 2) end.

实例: 使用宏::

  basic_test_() ->
     ?_test(?assert(1 + 1 =:= 2)).

实例: 另一种宏::

  basic_test_() ->
     ?_assert(1 + 1 =:= 2).

完整实例::

   -module(fib).
   -export([fib/1]).
   -include_lib("eunit/include/eunit.hrl").

   fib(0) -> 1;
   fib(1) -> 1;
   fib(N) when N > 1 -> fib(N-1) + fib(N-2).

   fib_test_() ->
       [?_assert(fib(0) =:= 1),
        ?_assert(fib(1) =:= 1),
        ?_assert(fib(2) =:= 2),
        ?_assert(fib(3) =:= 3),
        ?_assert(fib(4) =:= 5),
        ?_assert(fib(5) =:= 8),
        ?_assertException(error, function_clause, fib(-1)),
        ?_assert(fib(31) =:= 2178309)
       ].


Disabling testing
-------------------------

关闭测试模式-启动时执行::

    erlc -DNOTEST my_module.erl

关闭测试模式-NOTEST::

    % 要把NOTEST宏定义放在eunit.hrl前面
    -define(NOTEST, 1).
    -include_lib("eunit/include/eunit.hrl").

强制test::

    erlc -DTEST my_module.erl

Avoiding compile-time dependency on EUnit::

   -ifdef(TEST).
   -include_lib("eunit/include/eunit.hrl").
   -endif.


EUnit macros
================

Basic macros
-----------------

_test(Expr)::

    把Expr转化为测试对象
    % 等同于
    {?LINE, fun () -> (Expr) end}.

Compilation control macros
-------------------------------
EUNIT::

    % 在编译时启用EUnit时，此宏始终定义为true
    % 与NOTEST and TEST功能类似
    % 通常用于在条件编译中放置测试代码，如：
    -ifdef(EUNIT).
       % test code here
       ...
    -endif.

EUNIT_NOAUTO::

    如果定义了此宏，则将禁用自动导出或剥离测试功能。

TEST::

    在编译时启用EUnit,此宏就被定义为true
    与NOTEST and EUNIT功能类似
    与EUNIT的区别:
      EUNIT: 适用于对strictly dependent on EUnit
      TEST:  适用于generic testing conventions

NOTEST::

    在编译时禁用EUnit,此宏就被定义为true
    此宏也可用于条件编译，但更常用于禁用测试

NOASSERT::

    如果定义了此宏，则在禁用测试时，断言宏将不起作用

ASSERT::

    如果定义了此宏，它将覆盖NOASSERT宏，强制始终启用断言宏

NODEBUG::

    如果定义了此宏，则下面的调试宏将不起作用。

DEBUG::

    如果定义了此宏，它将覆盖NODEBUG宏，从而强制启用调试宏。


Utility macros
--------------------

LET(Var,Arg,Expr)::

    等同于:
    (fun(Var)->(Expr)end)(Arg).
    变量只在Expr中生效

IF(Cond,TrueCase,FalseCase)::

    如:
    1. Cond值为true:  执行TrueCase
    2. Cond值为false: 执行FalseCase

    等同于:
    (
      case (Cond) of 
        true->(TrueCase); 
        false->(FalseCase) 
      end
    ).

Assert macros
--------------------

::

    下面的每个宏都有相应的_宏，如:
    assert(BoolExpr)    => _assert(BoolExpr)
    ?_assert(BoolExpr)
    等同于
    ?_test(assert(BoolExpr))

assert(BoolExpr)::

    如果结果不为true,抛出informative exception异常
    ?assert(f(X, Y) =:= [])
    % 不止用在单元测试上
    some_recursive_function(X, Y, Z) ->
       ?assert(X + Y > Z),

assertNot(BoolExpr)::

    与assert相反

assertMatch(GuardedPattern, Expr)::

    计算Expr并将结果与GuardedPattern匹配
    如果不匹配，抛出异常
    使用此种匹配而不直接使用=匹配的原因时，这会产生更详细的错误信息
    ?assertMatch({found, {fred, _}}, lookup(bloggs, Table))
        => {found, {fred, _}} = lookup(bloggs, Table).
    ?assertMatch([X|_] when X > 0, binary_to_list(B))
        [X|_] when X > 0 =  binary_to_list(B)

assertNotMatch(GuardedPattern, Expr)::

    与assertMatch相反


assertEqual(Expect, Expr)::

    计算Expect, Expr的值，并对比结果是否相同
    等同于?assert(Expect =:= Expr).但有更详细的错误信息
    实例:
    ?assertEqual("b" ++ "a", lists:reverse("ab"))
    ?assertEqual(foo(X), bar(Y))

assertNotEqual(Unexpected, Expr)::

    与assertEqual相反


assertException(ClassPattern, TermPattern, Expr)::

    assertError(TermPattern, Expr)
      等同于    assertException(error, TermPattern, Expr)
    assertExit(TermPattern, Expr)
      等同于    assertException(exit, TermPattern, Expr)
    assertThrow(TermPattern, Expr)
      等同于    assertException(throw, TermPattern, Expr)

    计算Expr,并将异常与ClassPattern:TermPattern对比


Macros for running external commands
------------------------------------------

.. note:: 注意此块命令与os:type()相关

assertCmd(CommandString)::

    CommandString返回值不为0,则抛出异常
    ?assertCmd("mkdir foo")

assertCmdStatus(N, CommandString)::

    类似assertCmd,只不过期待返回值是N

assertCmdOutput(Text, CommandString)::

    类似assertCmd,只不过期待返回值是Text字串

cmd(CommandString)::

    {setup,
      fun () -> ?cmd("mktemp") end,
      fun (FileName) -> ?cmd("rm " ++ FileName) end,
      ...
    }

Debugging macros
----------------------

debugHere::

    只打印当前文件和当前行

debugMsg(Text)::

    类似io:format("~p", [Text]).

debugFmt(FmtString, Args)::

    类似io:format(FmtString, Args).

debugVal(Expr)::
  
    % 实例:
    ?debugVal(f(X)) 可能显示为: "f(X) = 42". 

debugVal(Expr, Depth)::

    类似debugVal
    截断指定长度

debugTime(Text,Expr)::

    展示运行时间,如:
    List1 = ?debugTime("sorting", lists:sort(List)) => "sorting: 0.015 s".


EUnit test representation
=============================


Simple test objects
-------------------------

A simple test object是下面的其中一种::

    1. 无参函数
    fun () -> ... end
    fun some_function/0
    fun some_module:some_function/0
    2. {test, ModuleName, FunctionName},
    3. {LineNumber, SimpleTest}

Test sets and deep lists
----------------------------
::

    测试集
    如T_1, ..., T_N是单独的测试对象,则[T_1，...，T_N]是由这些对象组成的测试集（按此顺序）
    如S_1，...，S_K是测试集，则[S_1，...，S_K]也是测试集
    测试集的主要表示是深度列表，并且简单的测试对象可以被视为仅包含单个测试的测试集

Titles
-----------
::

    任何测试或测试集T都可以用标题进行注释，方法是:
      将它包装在一对{Title，T}中，其中Title是一个字符串

Primitives
---------------
{module, ModuleName::atom()}::

    组成了一个测试集
    1.即那些名称以_test结尾的arity为零的函数
    ModuleName_test()函数变成简单的测试
    2.即那些名称以_test_结尾的arity为零的函数
    ModuleName_test_()函数变成生成器
    3.ModuleName_tests
    _tests模块应该只包含使用主模块的公共接口的测试用例（而不包含其他代码）

ModuleName::atom()::

    等同于{module, ModuleName}

{application, AppName::atom(), Info::list()}::

    这是一个普通的Erlang / OTP应用程序描述符，可以在.app文件中找到。 
    生成的测试集由Info中模块条目中列出的模块组成。

其他::

    {application, AppName::atom()}
    Path::string()
    {file, FileName::string()}
    {dir, Path::string()}
    {generator, GenFun::(() -> Tests)}
    {generator, ModuleName::atom(), FunctionName::atom()}
    {with, X::any(), [AbstractTestFun::((any()) -> any())]}


Control
--------------

::

    {spawn, Tests}
    {spawn, Node::atom(), Tests}
    {timeout, Time::number(), Tests}
    {inorder, Tests}
    {inparallel, Tests}
    {inparallel, N::integer(), Tests}

Fixtures
-------------



specify fixture handling::

  {setup, Setup, Tests | Instantiator}
  {setup, Setup, Cleanup, Tests | Instantiator}
  {setup, Where, Setup, Tests | Instantiator}
  {setup, Where, Setup, Cleanup, Tests | Instantiator}

  {node, Node::atom(), Tests | Instantiator}
  {node, Node::atom(), Args::string(), Tests | Instantiator}

  {foreach, Where, Setup, Cleanup, [Tests | Instantiator]}
  {foreach, Setup, Cleanup, [Tests | Instantiator]}
  {foreach, Where, Setup, [Tests | Instantiator]}
  {foreach, Setup, [Tests | Instantiator]}

  {foreachx, Where, SetupX, CleanupX, Pairs::[{X::any(), ((X::any(), R::any()) -> Tests)}]}
  {foreachx, SetupX, CleanupX, Pairs}
  {foreachx, Where, SetupX, Pairs}
  {foreachx, SetupX, Pairs}

Lazy generators
---------------------
::

  % 实例:
  lazy_test_() ->
       lazy_gen(10000).

   lazy_gen(N) ->
       {generator,
        fun () ->
            if N > 0 ->
                   [?_test(...)
                    | lazy_gen(N-1)];
               true ->
                   []
            end
        end}.





.. [1] http://erlang.org/doc/man/eunit.html
.. [2] http://erlang.org/doc/apps/eunit/users_guide.html







