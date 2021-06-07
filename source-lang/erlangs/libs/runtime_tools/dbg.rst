dbg模块 [1]_
###############



实例::

    > dbg:start().   % start dbg
    > dbg:tracer().  % start a simple tracer process
    > dbg:tp(Module, Function, Arity, []).   % specify MFA you are interested in
    > dbg:p(all, c).   % trace calls (c) of that MFA for all processes.

    ... trace here

    > dbg:stop_clear().   % stop tracer and clear effect of tp and p calls.

想trace模块中没有导出的函数，请使用tpl::

    > dbg:tpl(Module, '_', []).  % all calls in Module
    > dbg:tpl(Module, Function, '_', []).   % all calls to Module:Function with any arity.
    > dbg:tpl(Module, Function, Arity, []). % all calls to Module:Function/Arity.
    > dbg:tpl(M, F, A, [{'_', [], [{return_trace}]}]).   % same as before, but also show return value.

使用dbg:fun2ms来生成函数入参的匹配模式::

    1> dbg:fun2ms(fun([M,N]) when N > 3 -> return_trace() end).
    [{['$1','$2'],[{'>','$2',3}],[{return_trace}]}]


可以使用dbg:p函数来指定特定的进程::

    > dbg:p(all, c).   % trace calls to selected functions by all functions
    > dbg:p(new, c).   % trace calls by processes spawned from now on
    > dbg:p(Pid, c).   % trace calls by given process
    > dbg:p(Pid, [c, m]).  % trace calls and messages of a given process


.. note::

    1.由于trace时产生的日志非常多,通常需要把它放到一个文件汇总后再分析(而不是直接输出到shell中):
    
    生成多个文件保存日志:
    >dbg:tracer(port,dbg:trace_port(file,{"/log/trace",wrap,atom_to_list(node())})).
    这点也说明了dbg太放纵使用者,一不小心就会产生大量的日志,导致节点异常
    生产环境中慎用

    2.所有的tp,p都是在在dbg:start/0,dbg:trace/0开启后才能起作用的


实例-监听指定进程::

    Pid = pid(0, 56, 0).
    FileName = "/tmp/dbg.log".
    dbg:start().
    {ok, IO} = file:open(FileName, [append]).
    {ok, TPid} = dbg:tracer(process, {fun dbg:dhandler/2, IO}).
    dbg:p(Pid,[m,p]).
    dbg:stop().




.. [1] http://erlang.org/doc/man/dbg.html



