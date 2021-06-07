

路由
==============
基本结构::

    Routes = [Host]
    Host = {HostMatch, PathsList} | {HostMatch, Constraints, PathsList}.
    PathsList = [Path].
    Path = {PathMatch, Handler, Opts} | {PathMatch, Constraints, Handler, Opts}.
    PathMatch: string() or binary()
    

Match详解::

    PathMatch1 = "/".
    PathMatch2 = "/path/to/resource".
    HostMatch1 = "cowboy.example.org".

    % 下面两句一样
    PathMatch2 = "/path/to/resource".
    PathMatch3 = "/path/to/resource/".

    % 下面三句一样
    HostMatch1 = "cowboy.example.org".
    HostMatch2 = "cowboy.example.org.".
    HostMatch3 = ".cowboy.example.org".

    % binding
    PathMatch = "/hats/:name/prices".
    HostMatch = ":subdomain.example.org".
    % http://test.example.org/hats/gordon/prices
    erl> cowboy_req:binding/{2,3}
    name => gordon
    subdomain => test

    % :_的用法
    % 后面不取它的值,类似erlang的_
    HostMatch = "ninenines.:_".
    PathMatch = "/hats/:name/:name".


    % []指定可选
    PathMatch = "/hats/[page/:number]".
    HostMatch = "[www.]ninenines.eu".
    PathMatch = "/hats/[page/[:number]]".

    % [...]:多匹配
    PathMatch = "/hats/[...]".
    HostMatch = "[...]ninenines.eu".
    erl> cowboy_req:host_info/1和cowboy_req:path_info/1

    % '_':匹配任意host或path
    % "*":通配符匹配,通常与OPTION方法一起使用
    PathMatch = '_'.
    HostMatch = '_'.

    HostMatch = "*".



编译::


    % cowboy_route:compile/2
    Dispatch = cowboy_router:compile([
        %% {HostMatch, list({PathMatch, Handler, Opts})}
        {'_', [{'_', my_handler, []}]}
    ]),
    %% Name, NbAcceptors, TransOpts, ProtoOpts
    cowboy:start_http(my_http_listener, 100,
        [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]
    ).


在线更新::

    % cowboy:set_env/3:
    Dispatch = cowboy_router:compile(Routes),
    cowboy:set_env(my_http_listener, dispatch, Dispatch).



router::


    % 1.在应用的priv_dir/static/目录下,所有文件的路由
    % 2.文件priv/index.html
    Dispatch = [
        {'_', [
            {"/[...]", cowboy_static, [
                {directory, {priv_dir, my_app, [<<"static">>]}},
                {file, "index.html"},
                {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            ]}
        ]}
    ].
















