.. _rebar_nitrogenapp:

以nitrogen_2.0.4为例建立工程框架
=================================

说明:
    * 把所有[appname]换成你你自己的app的名字

.. _nitrogenapp_basic:

首先建立一个基本的工程框架
--------------------------

* 首先进入项目根目录,建立如下基本文件目录::

    mkdir apps/ deps/ rel/ etc/

* 增加 ``rebar`` 文件:
    * 源码生成::

        git clone https://github.com/basho/rebar.git
        cd rebar
        make

    * 直接下载文件::

        wget http://cloud.github.com/downloads/basho/rebar/rebar

    * 从别的项目(如:riak)复制

    **注:最好是用riak发布项目里面的rebar文件(用前面介绍的方法[wget或源码]可能有问题),会比较稳定**

* 增加 ``rebar.config`` 文件，并在 ``rebar.config`` 文件中增加如下内容::

    %% -*- mode: erlang;erlang-indent-level: 4;indent-tabs-mode: nil -*-
    {sub_dirs, ["rel"]}. %%需要编译的子目录
    {require_otp_vsn, "R13B04|R14"}. %%要求当前机器的 erlang 版本为 R13B04|R14
    {cover_enabled, true}. %%如果 ebin 目录下存在 beam 文件,允许覆盖
    {erl_opts, [debug_info, fail_on_warning]}. %%编译时检查是否有 warning,如果有将编译报错
    {deps, [
        {mochiweb, "1.5.*", {git, "git://github.com/mochi/mochiweb.git", {tag, "1.5.0"}}},
        {nitrogen_core, "2.1.*", {git, "git://github.com/nitrogen/nitrogen_core.git", "HEAD"}}, %%nitrogen 框架依赖项目
        {nprocreg, "0.2.*", {git, "git://github.com/nitrogen/nprocreg.git", "HEAD"}}, %%nitrogen 框架依赖项目
        {simple_bridge, "1.2.*", {git, "git://github.com/nitrogen/simple_bridge.git", "HEAD"}}, %%nitrogen 框架依赖项目
        {sync, "0.1.*", {git, "git://github.com/rustyio/sync.git", "HEAD"}} %%nitrogen 框架依赖项目
    ]}.

* 增加 ``Makefile`` 文件, 添加如下内容(如果编译有问题,把前面的空格重新打一遍)::

    VERSION=0.1.0 #首先定义版本
    .PHONY: deps doc
    # 默认为获取依赖 OTP 项目,然后进行编译
    all: deps compile

    help:
        @echo
        @echo "Usage: "
        @echo "./make {compile|clean}"
        @echo
        @echo "./make {rel|package}"
        @echo
        @echo

    #编译相关项目,在编译之前先查看依赖项目是否已经存在
    compile:deps
        ./rebar compile

    #获取 OTP 项目
    deps:
        ./rebar get-deps

    clean:
        ./rebar clean

    #清除依赖项目
    distclean: clean
        ./rebar delete-deps

    #测试所有项目
    test:
        ./rebar eunit

    dialyzer: compile
        @dialyzer -Wno_return -c ebin

    doc :
        @./rebar doc skip_deps=true

    * 编译项目(编译的过程会把信赖项目加载进来)::

        make

.. _nitrogenapp_nitrogen:

使用 nitrogen 做一个网站
------------------------

    * 首先创建基本目录结构(框架根目录)::

        mkdir site; cd site
        mkdir ebin;mkdir src;mkdir include;mkdir static;mkdir templates

    * 使用 rebar 创建一个 otp 项目::

        ../rebar create-app appid=[appname]

    * 修改文件 ``appname_sup.erl`` :

        * 增加对 ``wf.hrl`` 文件的包含::

            -include_lib("nitrogen_core/include/wf.hrl").%%包含 wf.hrl 文件

        * 增加一个循环接收请求消息的函数::

            %% 循环接收消息的函数
            loop(Req) ->
                {ok, DocRoot} = application:get_env(mochiweb, document_root),
                RequestBridge = simple_bridge:make_request(mochiweb_request_bridge, {Req, DocRoot}),
                ResponseBridge = simple_bridge:make_response(mochiweb_response_bridge, {Req, DocRoot}),
                nitrogen:init_request(RequestBridge, ResponseBridge),
                nitrogen:run().

        * 导出 loop 函数::

            -export ([loop/1]).%%导出 loop 函数

        * 修改 ``init/1`` 函数为::

            init([]) ->
                %% Start the Process Registry...
                application:start(nprocreg),
                %% Start Mochiweb...
                application:load(mochiweb),
                {ok, BindAddress} = application:get_env(mochiweb, bind_address),
                {ok, Port} = application:get_env(mochiweb, port),
                {ok, ServerName} = application:get_env(mochiweb, server_name),
                {ok, DocRoot} = application:get_env(mochiweb, document_root),
                io:format("Starting Mochiweb Server (~s) on ~s:~p, root: '~s'~n",
                             [ServerName, BindAddress, Port, DocRoot]),
                % Start Mochiweb...
                Options = [
                    {name, ServerName},
                    {ip, BindAddress},
                    {port, Port},
                    {loop, fun [appname]_sup:loop/1}
                ],
                mochiweb_http:start(Options),
                {ok, { {one_for_one, 5, 10}, []} }.

    * 增加一个 index.erl 文件,内容如下::

        -module (index).
        -compile(export_all).
        -include_lib("nitrogen_core/include/wf.hrl").

        main() -> body().
        title() -> "Hello,Welcome to My World".
        body() ->
            #container_12 { body=[#grid_8 { alpha=true, prefix=2, suffix=2, omega=true,body=inner_body() }]}.

        inner_body() ->
            [
                #h1 { text="Hello,Welcome to Nitrogen World" },
                #p{}, "Run <b>./bin/dev help</b> to see some useful developer commands."
            ].

    * 修改 rebar.config 文件, 使之可以编译 site 目录::

        {sub_dirs, ["rel","site"]}. %%需要编译的子目录

    * 增加一个 mochiweb 配置文件: ``etc/mochiweb.config`` ,内容如下::

        [{mochiweb, [
            {bind_address, "0.0.0.0"},
            {port, 8000},
            {server_name, [appname]},
            {document_root, "./site/static"}
        ]}].

    * 在项目根目录增加文件: ``start.sh`` 文件,并执行命令 ``chmod +x start.sh`` ,内容如下::

        #!/bin/sh
        cd `dirname $0`
        exec erl -name 'appname@127.0.0.1' -pa $PWD/site/ebin -pa $PWD/apps/*/ebin \
           $PWD/deps/*/ebin -boot start_sasl -config "etc/mochiweb.config" \
           -eval "application:load(mochiweb)" -eval "application:start([appname])"

    * 启动应用::

        ./start.sh

    * 打开浏览器,输入:http://127.0.0.1:8000, 在浏览器中显示::

        Hello,Welcome to nitrogen world
        -:).


.. _nitrogenapp_release:

工程项目发布
-------------

**说明**

    rebar 工具的打包功能使用的 erlang 类库是 reltool,所以发布版本之前需要首先在 ``rel`` 目录新建一个 ``reltool.config`` , 这个文件很复杂,幸运的是 rebar 工具提供生成这个文件的功能

    * 使用 rebar 工具生成版本发布配置文件::

        cd rel
        ../rebar create-node nodeid=[appname]

    * 命令执行后生成如下文件(重要文件 ``reltool.config`` )::

        |-- files
        |   |-- app.config
        |   |-- erl
        |   |-- [appname]
        |   |-- nodetool
        |   `-- vm.args
        `-- reltool.config


      注:在 ``reltool.config`` 文件中, **overlay标签** 十分重要,除了涉及到相关 erlang OTP 项目类库文件外,在一个发布版本中还需要有一些提交设定的参数以及静态文件,例如 css 文件等

    * 对文件 ``reltool.config`` 进行修改:
        * 增加erlang格式的头::

            %% -*- mode: erlang -*-

        * 修改配置节::

            {lib_dirs, []} => {lib_dirs, ["../deps","../apps","../site"]}

        * 修改 rel 版本号::

            {rel, "[appname]", "1" ... => {rel, "[appname]", "0.1.0" ...

        * 修改包含的应用列表(举例如下[根据实际情况改变])::

            {rel, "[appname]", "0.1.0",
            [
                kernel,
                stdlib,
                sasl,
                inets,
                crypto,
                runtime_tools,
                mnesia,
                os_mon
            ]},

        * 要对包含的 OTP 进行打包压缩,建议加上这个选项::

            {excl_sys_filters, ["^bin/.*", "^erts.*/bin/(dialyzer|typer)"]},
            {excl_archive_filters, [".*"]},%%(这行是增加的) 不要对包含的OTP进行打包压缩,建议加上这个选项
            {app, sasl, [{incl_cond, include}]}

        * 打包如下otp项目::

            {app, sasl, [{incl_cond, include}]},
            {app, eunit, [{incl_cond, include}]},%%建议打包上 eunit OTP 项目
            {app, os_mon, [{incl_cond, include}]},%% 打包 os_mon OTP 项目
            {app, mochiweb, [{incl_cond, include}]}, %% 打包 mochiweb OTP 项目
            {app, nitrogen_core, [{incl_cond, include}]}, %% 打包 nitrogen_core OTP 项目
            {app, nprocreg, [{incl_cond, include}]}, %% 打包 nprocreg OTP 项目
            {app, simple_bridge, [{incl_cond, include}]}, %% 打包 simple_bridge OTP 项目
            {app, sync, [{incl_cond, include}]} %% 打包 sync OTP 项目

    * 在 ``rel`` 目录下增加 ``overlay`` 目录, 并在其下创建子目录:
        * 执行如下命令::

            mkdir overlay; cd overlay
            mkdir common erts; mkdir -p mochiweb/etc
            cd common; mkdir bin etc site; mkdir -p log/sasl
            cd site; mkdir ebin include src static templates
            cd ../../..
            tree

        * 执行后目录 ``rel`` 目录下结构为::

            .
            ├── files
            │ ├── app.config
            │ ├── erl
            │ ├── [appname]
            │ ├── nodetool
            │ └── vm.args
            ├── overlay
            │ ├── common
            │ │ ├── bin
            │ │ ├── etc
            │ │ ├── log
            │ │ │ └── sasl
            │ │ └── site
            │ │   ├── ebin
            │ │   ├── include
            │ │   ├── src
            │ │   ├── static
            │ │   └── templates
            │ ├── erts
            │ └── mochiweb
            │   └── etc
            └── reltool.config
            16 directories, 6 files

    * 将 files 目录下的文件复制如下目录中::

        cp files/app.config overlay/common/etc; cp files/vm.args overlay/common/etc
        cp files/erl overlay/erts; cp files/nodetool overlay/erts
        cp files/[appname] overlay/common/bin

        cp ../etc/mochiweb.config overlay/mochiweb/etc

    * 这时的目录结构树如下::

        ├── files
        │ ├── app.config
        │ ├── erl
        │ ├── [appname]
        │ ├── nodetool
        │ └── vm.args
        ├── overlay
        │ ├── common
        │ │ ├── bin
        │ │ │ └── [appname]
        │ │ ├── etc
        │ │ │ ├── app.config
        │ │ │ └── vm.args
        │ │ ├── log
        │ │ │ └── sasl
        │ │ └── site
        │ │   ├── ebin
        │ │   ├── include
        │ │   ├── src
        │ │   ├── static
        │ │   └── templates
        │ ├── erts
        │ │ ├── erl
        │ │ └── nodetool
        │ └── mochiweb
        │   └── etc
        │     └── mochiweb.config
        └── reltool.config
        16 directories, 12 files

    * 修改 reltool.config 文件中 **overlay配置段** ( *把overlay配置段删除* )::

        {overlay, [
           %% {mkdir, "fold/subfold"} %创建目录
           %% Copy common files...
           {copy, "./overlay/common/*"},
           %% Copy start files...
           {copy, "./overlay/erts/*", "{{erts_vsn}}/bin"},
           {copy, "../site/ebin", "site"},
           {copy, "../site/include", "site"},
           {copy, "../site/static", "site"},
           {copy, "../site/templates", "site"},
           %% Copy mochiweb config files...
           {copy, "overlay/mochiweb/*"}
       ]}.

    * 将 rebar 文件 复制到 rel 目录下::

        cp ../rebar ./

    * 修改 overlay/common/bin/[appname] 文件,使之可以读取多个 config 文件:

        * 找到::

            CMD="$BINDIR/erlexec -boot $RUNNER_BASE_DIR/releases/$APP_VSN/$BOOTFILE \
                -embedded -config $RUNNER_ETC_DIR/app.config -args_file \
                $RUNNER_ETC_DIR/vm.args -- ${1+"$@"}"

        * 修改为::

            CONFIG=""
            for f in `ls $RUNNER_ETC_DIR/*.config`
            do
                CONFIG="$CONFIG -config $f"; 
            done
            CMD="$BINDIR/erlexec -boot $RUNNER_BASE_DIR/releases/$APP_VSN/$BOOTFILE \
                -embedded $CONFIG -args_file $RUNNER_ETC_DIR/vm.args -- ${1+"$@"}"

    * 修改 overlay/common/etc/vm.args 文件, **增加** 如下配置项::

        ## Include .beam files for site.
        -pa ./site/ebin
        ## Include .beam files for dependencies.
        -pa ./deps/*/ebin
        ## Include .beam files for dependencies.
        -pa ./apps/*/ebin
        ## Run code at startup.
        -eval "application:start([appname])"

    * 生成版本::

        ./rebar generate

    * 启动发布的工程项目::

        ./[appname]/bin/[appname] console

    * 在浏览器中输入网址:http://127.0.0.1:8000,显示::

        Hello,Welcome to nitrogen world
        -:).
