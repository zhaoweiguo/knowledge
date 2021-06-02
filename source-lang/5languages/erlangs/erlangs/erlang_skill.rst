.. _erlang_skill:

Erlang技巧
#################
::

    %仅适用于erl shell的命令
    rp(xxx()).    % 显示全部内容
    f().          %清除所有变量
    f(Pid).       %清除变量Pid
    c(useless).   %编译useless.erl

    % atom相关
    1> atom.
    atom
    2> atoms_rule.
    atoms_rule
    3> atoms_rule@erlang.
    atoms_rule@erlang
    4> 'Atoms can be cheated!'.
    'Atoms can be cheated!'
    5> atom = 'atom'.
    atom

    exit/1
    exit(Pid, Reason).
    exit(Pid, kill).
    process_flag(trap_exit, true).


    SpawnFun = spawn(fun functionname:fun/1).
    spawn(Mod, Func, Args).

    %% 实例说明:
    do_it() ->
        process_flag(trap_exit, true),  % 指定当前进程为系统进程
        Pid = erlang:spawn_link(timer, sleep, [9999999]), % 很长时间执行不完
        exit(Pid, kill),    % 杀掉进程
        receive
            {'EXIT', Pid, killed} ->  % 会收到此种进程
                ok
        end.

    try-catch语法结构内无法构成尾递归

判断是否字符串::

    -spec is_string(String :: any()) -> true | false.
    is_string(String) when is_list(String) ->
        Fun = fun(E) ->
            E >= 0 andalso E =< 255
              end,
        lists:all(Fun, String);
    is_string(_String) ->
        ?FALSE.

一堆二进制转化成可读串::

    A = <<123,34,73,78,70,79,34,58,123,34,78,73,67,75,78,65,77,69,34,58,34,
              227,128,130,83,117,110,102,108,111,119,101,114,91,229,164,170,
              233,152,179,93,34,125,125>>.
    io:format("~ts",[A]).


小工具::

    etop可以给进程排个名(memory, runtime, msg_q);
    pman显示所有进程列表,并能trace进程的函数调用到文件中;
    dbg进行trace,pattern trace更是方便的一塌糊涂;
    tv可以查看ets,mnesia表;
    percept可以绘制出进程并发统计图;
    dialyzer对代码进行静态分析;
    fprof进行性能分析. 这些你都用了么?

汉字::

    unicode:characters_to_binary("谢谢谢谢谢谢谢谢谢谢谢").

    // 打印汉字
    erl> io:format("~ts~n", ["汉字"]).
    汉字
    ok

    // 消息有为汉字时json出错
    S = list_to_binary(xmerl_ucs:to_utf8("灯泡"))



操作符::

  op  Description
  ==  等于
  /=  不等于
  =<  小于或等于
  < 小于
  >=  大于或等于
  > 大于
  =:= 恒等于
  =/= 恒不等于
  / 浮点除法  number
  div   整数除法  integer
  bnot  一元 not 位运算  integer
  rem 整数求余  integer
  % 整数2进制运算符
  band  与运算 integer
  bor 或运算 integer
  bxor  异或运算  integer
  bsl 左移运算  integer
  bsr 右移运算  integer
  rem
  bnot
  % 2进制运算符
  not   非
  and   与
  or    或
  xor   异或
  % 短路2进制运算符
  orelse
  andalso

  % 实例:
  2#00100 = 2#00010 bsl 1.
  2#00001 = 2#00010 bsr 1.
  2#10101 = 2#10001 bor 2#00101.



位运算::

  8> <<R:8, Rest/binary>> = Pixels.
  % 几种方式:
  Value
  Value:Size
  Value/TypeSpecifierList
  Value:Size/TypeSpecifierList

  Type: integer | float | binary | bytes | bitstring | bits | utf8 | utf16 | utf32
  Signedness: signed | unsigned
  Endianness: big | little | native
  Unit: unit:Integer

  10> <<X1/unsigned>> =  <<-44>>.
  <<"Ô">>
  11> X1.
  212
  12> <<X2/signed>> =  <<-44>>. 
  <<"Ô">>
  13> X2.
  -44
  14> <<X2/integer-signed-little>> =  <<-44>>.
  <<"Ô">>
  15> X2.
  -44
  16> <<N:8/unit:1>> = <<72>>.
  <<"H">>
  17> N.
  72
  18> <<N/integer>> = <<72>>.
  <<"H">>
  19> <<Y:4/little-unit:8>> = <<72,0,0,0>>.     
  <<72,0,0,0>>
  20> Y.
  72
  21> <<Ver:5/binary, _/binary>> = <<"/v1.0/fdafk/fdsaf">>.
  <<"/v1.0/fdafk/fdsaf">>
  22> Ver.
  <<"/v1.0">>

匿名函数递归::

  F = fun(This, [], Total) -> Total;  
       (This, [H|T], Total) -> This(This, T, H+Total) end.

  实例:删除simple_one_for_one的子:
  Fun = 
    fun
      (This, List, 10) ->
        io:format("done~n");
      (This, [Pid | List], Num) ->
        io:format("kill pid:~p~n", [Pid]),
        exit(Pid, kill),
        This(This, List, Num+1),
        ok
    end.
  Fun(Fun, [Pid || {_, Pid, _, _} <- supervisor:which_children(demo_lager_sup)], 0).




源码分析方法
'''''''''''''''
反编译文件的源码::

    Beam = "./_build/default/lib/octopus/ebin/fatscale_servant.beam".
    {ok, {_, [{abstract_code, {_,Abs}}]}} =  beam_lib:chunks(
                    Beam, [abstract_code]).
    io:fwrite("~s~n", [erl_prettypr:format(erl_syntax:form_list(Abs))]).
    or
    file:write_file("abc.erl", erl_prettypr:format(erl_syntax:form_list(Abs))).








