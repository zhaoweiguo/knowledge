Compilation and Code Loading [1]_
####################################

如何compile和load代码依赖于系统而不是一个语言问题

Compilation
---------------

Erlang程序必须被编译成object code，运行object code的虚拟机叫BEAM，因此object code以.beam为后缀
代码编译有以下几种方法:

1. compile模块::

    compile:file(Module)
    compile:file(Module, Options)

2. shell命令c(Module):

    编译&加载

3. make模块::

    make:all().

4. erl启动时::

    % erl -compile Module1...ModuleN
    % erl -make

5. erlc编译::

    % erlc <flags> File1.erl...FileN.erl

Code Loading
----------------

object code必须要加载到Erlang runtime system,此部分功能由code server处理，详见code模块
code server加载代码有两种机制::

    interactive (default)
    embedded

Code Replacement
--------------------

1. Erlang supports change of code in a running system
2. Code replacement is done on module level.

代码在系统中存在2种状态: old和current
同一模块可以同时存在两种状态


Running a Function When a Module is Loaded
----------------------------------------------

-on_load()::

    格式: -on_load(Name/0).  % Name即为函数名
    指定模块加载时自动运行的函数
    无需导出,必须是无参数的函数
    函数返回值:
      ok: 代码加载成功
      Other: 代码不加载

.. note::

    在OTP 19之前，如果on_load函数失败，之前的current code还是会变成old
    这导致系统中不存在current code

在embedded模式,所有代码都会被加载,接着所有的on_load都会被执行
除非所有on_load函数都成功执行，否则系统就会被终止

实例::

    -module(m).
    -on_load(load_my_nifs/0).

    load_my_nifs() ->
        NifPath = ...,    %Set up the path to the NIF library.
        Info = ...,       %Initialize the Info term
        erlang:load_nif(NifPath, Info).

如果erlang:load_nif/2函数调用失败，此模块就不会被加载

细研究
---------
code模块对外提供接口，code_server模块处理实际的工作，注册为code_server
维护一个私有ets表code。 预加载的10个模块::

    erl> erlang:pre_loaded().
    [erts_internal,erlang,erl_prim_loader,prim_zip,zlib,
     prim_file,prim_inet,prim_eval,init,otp_ring0]

对于预定义的模块，如lists，math等等系统模块，这些模块是不能重复热更新的。
这些模块所在的目录被称为sticky目录。 
这是为了防止有人误操作把系统模块给替换了导致整个系统崩溃。
除了这些系统模块，其他的模块都是可以热更新的。

erlang:check_old_code/1::

    erlang:check_old_code(Mod) -> boolean().
    检查系统中是否存在该模块的老代码
    当系统中有老代码的时候，要清除老代码（执行purge）才能加载新的代码。 
    为了清除老代码要先找到仍在执行老代码的进程，将其kill掉。

erlang:check_process_code/2::

    erlang:check_process_code(Pid, Mod) -> boolean(). 
    检查进程是否在执行Mod的老代码。 
    为了找出仍在执行老代码的进程，需要遍历进程列表processes()，依次进行检查

code:purge/1::

    将老版本的代码从系统中移除掉，如果仍有进程在执行老版本代码，则将这些进程杀掉

code:soft_purge/1::

    尝试将老代码移除掉，如果仍有进程在执行老版本代码，则返回失败

进程仍在执行模块的老代码，有三种情况::

    1. 进程正在执行老代码。这种情况下是不管进程调用的全名函数还是短名函数。
        对于全名函数，当前这次执行完了下次就会切换到新代码，所以一开始返回true，后面就false了。
        对于短名函数则始终为true。
    2. 进程包含短名函数的引用。
    3. 进程包含引用短名函数的fun对象。比如:
        其他模块发送了一个fun给进程执行，这个fun对象包含了模块的短名对象，
        那么执行fun对象期间返回true。
    如果一个常驻内存的进程拿到了一个模块构造的匿名函数，那么这个模块要热更的时候就比较麻烦了

检查系统中的老代码::

    f(OldMods).
    OldMods = lists:filtermap(
        fun({Module, Filename}) ->
            is_list(Filename) andalso
            erlang:check_old_code(Module) andalso
            {true, Module}
        end,
        code:all_loaded()
    ).
    or
    f(OldMods).
    OldMods = lists:filtermap( fun({Module, Filename}) -> is_list(Filename) andalso erlang:check_old_code(Module) andalso {true, Module} end, code:all_loaded()).

检查系统中老代码无法被purge的模块::

    lists:filtermap(
        fun(Module) ->
            not code:soft_purge(Module)
        end,
        OldMods
    ).
    or
    lists:filtermap(fun(Module) -> not code:soft_purge(Module) end, OldMods).

找出还在执行老代码Mod的进程信息::

    [process_info(Pid)||Pid<-processes(),erlang:check_process_code(Pid, Mod)].

杀进程。一般先monitor，再kill，等待接收moniter消息，确认当前进程杀死。因为被杀死的进程可能需要进行一些清理的行为，如果不等待它确认死亡就将执行后续操作如移除代码，可能会导致清理过程出现找不到代码的问题。

code_server中杀死进程的过程::

    %% do_purge(Module)
    %%  Kill all processes running code from *old* Module, and then purge the
    %%  module. Return true if any processes killed, else false.

    do_purge(Mod0) ->
        Mod = to_atom(Mod0),
        case erlang:check_old_code(Mod) of
        false -> false;
        true -> do_purge(processes(), Mod, false)
        end.

    do_purge([P|Ps], Mod, Purged) ->
        case erlang:check_process_code(P, Mod) of
        true ->
            Ref = erlang:monitor(process, P),
            exit(P, kill),
            receive
            {'DOWN',Ref,process,_Pid,_} -> ok
            end,
            do_purge(Ps, Mod, true);
        false ->
            do_purge(Ps, Mod, Purged)
        end;
    do_purge([], Mod, Purged) ->
        catch erlang:purge_module(Mod),
        Purged.

直接purge有杀死进程的危险性，所以code_server也提供了soft_purge，如果有进程仍在执行老代码，则不移除老代码::

    %% do_soft_purge(Module)
    %% Purge old code only if no procs remain that run old code.
    %% Return true in that case, false if procs remain (in this
    %% case old code is not purged)

    do_soft_purge(Mod) ->
        case erlang:check_old_code(Mod) of
        false -> true;
        true -> do_soft_purge(processes(), Mod)
        end.

    do_soft_purge([P|Ps], Mod) ->
        case erlang:check_process_code(P, Mod) of
        true -> false;
        false -> do_soft_purge(Ps, Mod)
        end;
    do_soft_purge([], Mod) ->
        catch erlang:purge_module(Mod),
        true.

检查代码是否有改变::

    %% @doc Return a list of beam modules that have changed.
    all_changed() ->
        [M || {M, Fn} <- code:all_loaded(), is_list(Fn), is_changed(M)].

    %% @spec is_changed(atom()) -> boolean()
    %% @doc true if the loaded module is a beam with a vsn attribute
    %%      and does not match the on-disk beam file, returns false otherwise.
    is_changed(M) ->
        try
            module_vsn(M:module_info()) =/= module_vsn(code:get_object_code(M))
        catch _:_ ->
                false
        end.

    %% Internal API

    module_vsn({M, Beam, _Fn}) ->
        {ok, {M, Vsn}} = beam_lib:version(Beam),
        Vsn;
    module_vsn(L) when is_list(L) ->
        {_, Attrs} = lists:keyfind(attributes, 1, L),
        {_, Vsn} = lists:keyfind(vsn, 1, Attrs),
        Vsn.







.. [1] http://erlang.org/doc/reference_manual/code_loading.html
