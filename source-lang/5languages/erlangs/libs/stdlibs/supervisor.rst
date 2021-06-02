supervisor模块 [2]_
########################

start_link
'''''''''''''''''
实例::

    start_link(Module, Args) -> startlink_ret()  // 同下, 只是没有注册名
    start_link(SupName, Module, Args) -> startlink_ret()

    类型:
        SupName = sup_name()
        Module = module()
        Args = term()
        startlink_ret() = 
            {ok, pid()} | ignore | {error, startlink_err()}

        startlink_err() = 
            {already_started, pid()} | {shutdown, term()} | term()
        sup_name() = 
            {local, Name :: atom()} |
            {global, Name :: atom()} |
            {via, Module :: module(), Name :: any()}

说明::

    执行后会调用Module:init/1函数来确定
        restart strategy
        maximum restart intensity
        child processes
    直到init函数执行完且所有子进程都启动才返回

SupName::

    {local,Name} - supervisor被使用函数register/2本地注册
    {global,Name} - supervisor被使用global:register_name/2全局注册
    {via,Module,Name} - supervisor被使用Module的registry represented注册.这个Module 的回调应该export以下3个函数:
        register_name/2
        unregister_name/1
        send/2

情形::

    1.如果所有子进程都成功，即返回{ok,Child}, {ok,Child,Info}, or ignore
        且supervisor也成功创建，则返回{ok,Child}
    2.如果已经有相同名的supervisor，刚返回{error,{already_started,Pid}}
    3.如果Module:init/1 返回 ignore，此函数也返回ignore
        supervisor并以原因normal的方式terminate
    4.如果函数Module:init/1失败或返回不正确值，则返回{error,Term}
        supervisor并以原因Term的方式terminate
    5.如任何子进程start函数: 失败 | 返回error tuple | erroneous值
        supervisor以shutdown原因终止所有已经启动的子进程
        然后终止自己并返回{error, {shutdown, Reason}}


start_child
'''''''''''''''''
结构::

    start_child(SupRef, ChildSpec) -> startchild_ret()

    类型:
    SupRef = sup_ref()
    ChildSpec = child_spec() | (List :: [term()])
    startchild_ret() = {ok, Child :: child()}
             | {ok, Child :: child(), Info :: term()}
             | {error, startchild_err()}
    startchild_err() = already_present
             | {already_started, Child :: child()}
             | term()
    sup_ref() =     
        (Name :: atom()) |                   % 如:supervisor本地注册
        {Name :: atom(), Node :: node()} |   % 如:supervisor是本地的另一个node
        {global, Name :: atom()} |           % 如:supervisor是全局registered
        {via, Module, Name :: any()} |       % 如:supervisor是通过alternative process注册
        pid()
    child_spec() =
        #{
          id := child_id(),
          start := mfargs(),
          restart => restart(),
          shutdown => shutdown(),
          type => worker(),
          modules => modules()
        }

    对非simple_one_for_one类型
        1.此child已存在且未启动: {error,already_present} 
        2.此child已存在且已启动: {error,{already_started,Child}} 
        3.{ok,Child} or {ok,Child,Info}
        4.如child返回ignore,此child会被加入到supervisor中且值为undefined,并返回{ok,undefined}
    对simple_one_for_one类型
        规格在init/1函数中已经确定,ChildSpec类型格式为List :: [term()]
        1.子进程启动时参数附加上List，结合{M,F,A}，执行apply(M, F, A++List)
        2.如child返回ignore,函数返回{ok,undefined},且不把child加入到supervisor中
        3.如子进程返回error tuple或erroneous value或fails,则忽略,并返回 {error,Error}

实例::

    % supervisor版:
    init([]) ->
        {ok,{{simple_one_for_one, 0, 1},
             [{demo_gun_hubsock,
              {demo_gun_hubsock, start_link, []},
              temporary,
              brutal_kill,
              worker,
              [demo_gun_hubsock]}]}}.

    % start_child版:
    Args = {demo_gun_hubsock,
        {demo_gun_hubsock, start_link, [[]]},
        temporary, brutal_kill, worker, [demo_gun_hubsock]}
    start_child(Args) ->
        supervisor:start_child(demo_gun_hubsock_sup, Args).
    
    %or =>
    ChildSpecs = [#{
        id => demo_gun_hubsock,
        start => {demo_gun_hubsock, start_link, []},
        shutdown => brutal_kill
    }],
    supervisor:start_child(demo_gun_hubsock_sup, ChildSpecs).



which_children/1
'''''''''''''''''''''
实例::

    which_children(SupRef) -> [{Id, Child, Type, Modules}]
    类型:
    SupRef = sup_ref()
    Id = child_id() | undefined
    Child = child() | restarting
    Type = worker | supervisor
    Modules = modules()

说明::

    返回创建的子列表

.. note::

    注意:child太多时可能会造成占用内存过多

每个子进程包含的信息::

    Id: 
        1.child specification
        2.undefined for simple_one_for_one

    Child:
        1.相应子进程的pid 
        2.如果进程重启,the atom restarting
        3.undefined if there is no such process.

    Type:
        As defined in the child specification.

    Modules:
        As defined in the child specification.






design_principles [1]_
''''''''''''''''''''''''''''''

实例::

    start_link() ->
        supervisor:start_link(ch_sup, []).

    init(_Args) ->
        SupFlags = #{
                strategy => one_for_one, 
                intensity => 1, 
                period => 5},
        ChildSpecs = [#{
                id => ch3,
                start => {ch3, start_link, []},
                restart => permanent,
                shutdown => brutal_kill,
                type => worker,
                modules => [cg3]}],
        {ok, {SupFlags, ChildSpecs}}.

SupFlags结构::

    sup_flags() = #{
            strategy => strategy(),            % optional
            intensity => non_neg_integer(),    % optional
            period => pos_integer()            % optional
    }


重启机制(strategy())::

    one_for_one
    子进程终止并被重启，其他子进程不受影响

    one_for_all
    子进程终止并被重启，其他子进程都会被终止并重启

    rest_for_one

    子进程终止并被重启，此子进程后面的子进程都会被终止并重启

    simple_one_for_one
    所有的进程都是动态增加同样process type的实例
    函数delete_child/2和restart_child/2方法对此种类型都是非法的,并会报错 {error,simple_one_for_one}
    函数terminate_child/2可以使用，第2个参数是pid()

intensity与period::

    子进程在period秒内重启intensity，则重启此supervisor



ChildSpecs结构::

    child_spec() = {Id,StartFunc,Restart,Shutdown,Type,Modules}
        Id = term()
        StartFunc = {M,F,A}
            M = F = atom()
            A = [term()]
        Restart = permanent | transient | temporary
        Shutdown = brutal_kill | int()>0 | infinity
        Type = worker | supervisor
        Modules = [Module] | dynamic
            Module = atom()


Restart参数::

    permanent
        总是被重启
    transient
        只有在不正常终止时才重启，即不是下面3个终止原因:
        normal, shutdown, or {shutdown,Term}
    temporary
        总是不重启

Shutdown参数::

    // 定义如何能一定终止子进程
    // 默认值:
    // supervisor: infinity
    // worker: 5000
    brutal_kill
        无条件的使用exit(Child,kill)终止
    int()>0
        先使用exit(Child,shutdown)终止，如果在int秒时间内没有收到原因为shutdown的exit信号,
        则使用无条件使用exit(Child,kill)终止
    infinity
        一般用于supervisor,给以足够时间终止
        也可以用于worker，但要足够小心

Modules参数::

    // 可选,默认值是[M]
    1.如果子进程是supervisor, gen_server or, gen_statem
    [Module]，其他Module是回调模块
    2.如果子进程是gen_event with dynamic set of callback modules
    dynamic

simple_one_for_one实例::

    -module(simple_sup).
    -behaviour(supervisor).

    -export([start_link/0]).
    -export([init/1]).

    start_link() ->
        supervisor:start_link(simple_sup, []).

    init(_Args) ->
        SupFlags = #{strategy => simple_one_for_one,
                     intensity => 0,
                     period => 1},
        ChildSpecs = [#{id => call,
                        start => {call, start_link, []},
                        shutdown => brutal_kill}],
        {ok, {SupFlags, ChildSpecs}}.

    // 使用:
    supervisor:start_child(Sup, List)
    // 如:
    supervisor:start_child(Pid, [id1])
    // 等同于:
    apply(call, start_link, []++[id1])

综合实例::

    [Pid || {_, Pid, _, _} <- supervisor:which_children(demo_lager_sup)].



.. [1] http://erlang.org/doc/design_principles/sup_princ.html
.. [2] http://erlang.org/doc/man/supervisor.html