rebar3整体说明
======================

::

  // 命令:
  rebar3 new <template> <project-name>
  // 参数:
  <template>:
    1.app
    2.lib
    3.release
    4.escript
    5.plugin
  // 实例:
  $ rebar3 new release myrelease

Erlang项目分为两种类型::

  1.single app、lib类型:
  rebar3 new app <name>
  rebar3 new lib <name>
  src在顶级目录
  2.project app类型:
  rebar3 new release <name>
  lib、apps目录在顶级目录


依赖相关::

  deps默认目录:
  _build/default/lib
  test默认目录:
  _build/test/lib

  //查看依赖树
  $ rebar3 tree
  //查看依赖
  $ rebar3 deps

  依赖从顶层向下clone，下层依赖不能overwrite上层依赖，最终依赖会写入rebar.lock中
  {deps_error_on_conflict, true}. // 增加这句，依赖有冲突时，会中止

  //包管理依赖:Package Manager Dependencies
  //类似其他composer,npm之类
  //地址:~/.cache/rebar3/hex/default/packages
  //用下面这行可以换代理、镜像
  {rebar_packages_cdn, "https://hexpm.upyun.com"}.

  $ rebar3 unlock <app>

  // 各种依赖类型
  {deps,[
    %% Packages
    rebar,
    {rebar,"1.0.0"},
    {rebar, {pkg, rebar_fork}}, % rebar app under a different pkg name
    {rebar, "1.0.0", {pkg, rebar_fork}},
    %% Source Dependencies
    {rebar, {git, "git://github.com/erlang/rebar3.git"}},
    {rebar, {git, "http://github.com/erlang/rebar3.git"}},
    {rebar, {git, "https://github.com/erlang/rebar3.git"}},
    {rebar, {git, "git@github.com:erlang/rebar3.git"}},
    {rebar, {hg, "https://othersite.com/erlang/rebar3"}},
    {rebar, {git, "git://github.com/erlang/rebar3.git", {ref, "aef728"}}},
    {rebar, {git, "git://github.com/erlang/rebar3.git", {branch, "master"}}},
    {rebar, {git, "git://github.com/erlang/rebar3.git", {tag, "3.0.0"}}},
    %% Legacy support -- added parts such as [raw] are ignored
    {rebar, "3.*", {git,"git://github.com/erlang/rebar3.git"}},
    {rebar, {git, "git://github.com/erlang/rebar3.git"}, [raw]},
    {rebar, "3.*", {git, "git://github.com/erlang/rebar3.git"}, [raw]}
  ]}.


配置文件::

  {deps, [...]}.
  {relx, [
      ...
  ]}.

  {profiles, [
      {prod, [
          {erl_opts, [no_debug_info, warnings_as_errors]},
          {relx, [{dev_mode, false}]}
      ]},
      {native, [
          {erl_opts, [{native, o3}]}
      ]},
      {test, [
          {deps, [meck]},
          {erl_opts, [debug_info]}
      ]}
  ]}.

  // 上面实例中有4distinct profiles，分别为:
  1.default; 2.prod; 3.native; 4.test
  // 实例:
  $rebar3 ct:
    default->test
  $rebar3 as test ct:
    default->test
  $rebar3 as native ct: 
    default->native->test
  $rebar3 as test,native ct:
    default->native->test（因为:幂等性）
  $rebar3 release:
    default
  $rebar3 as prod release
    default->prod->release
  $rebar3 as prod, native release
    与上相同,只是compiling modules to native mode

  // The order of application of profiles is therefore:
  1.default
  2.The REBAR_PROFILE value, if any
  3.the profiles specified in the as part of the command line
  4.the profiles specified by each individual command


releases相关::

  //命令:
  $ rebar release
  // release项目下有多个app时，使用-n指定
  $ rebar3 release -n <release_name>

  // 配置文件:
  {relx, [
    {
      release, 
      {<release name>, "0.0.1"},
      [<app>]
    },
    {
      release, 
      {<release name2>, "0.0.1"},
      [<app>]
    },
    {dev_mode, true},  // 开发模式，自动编译？
    {include_erts, false},
    {extended_start_script, true}
  ]}.

Overlays
''''''''''''''
配置::

  {relx, [
      ...
      {overlay_vars, "vars.config"},
      {overlay, [{mkdir, "log/sasl"},
                 {template, "priv/app.config", "etc/app.config"},
                 {copy, "Procfile", "Procfile"}]}
  ]}.

选项::

  mkdir:    在release目录「_build/default/rel/xxx」中创建目录
  copy:     copy文件到目录「_build/default/rel/xxx」中
  template: 同copy(只是可扩展)


配置::

  {overlay_vars, "vars.config"}

  $> cat vars.config:
  %% some variables
  {key, value}.
  {other_key, other_val}.
  %% includes variables from another file
  "./some_file.config".


动态配置::

  $ cat vm.args
  -name ${NODE_NAME}
  $ cat sys.config
  [
   {appname, [{port, "${PORT}"}]}
  ].
  $ cat xxx.sh   //借助shell命令启动多个application
  #!/bin/bash

  export RELX_REPLACE_OS_VARS=true

  for i in `seq 1 10`;
  do
      NODE_NAME=node_$i
      PORT=808$i
      _build/default/rel/<release>/bin/<release> foreground &
      sleep 1

Overlay相关::

  {relx, [
      ...
      {overlay_vars, "vars.config"},
      {overlay, [{mkdir, "log/sasl"},
                 {template, "priv/app.config", "etc/app.config"},
                 {copy, "Procfile", "Procfile"}]}
  ]}.
  //注(语法格式):https://github.com/soranoba/mustache

  // overlay_vars里面的文件格式如下:
  %% some variables
  {key, value}.
  {other_key, other_val}.
  %% includes variables from another file
  "./some_file.config".

  // overlay支持的命令
  mkdir
  template
  copy

  // overlay_vars里面variables有:
  log : The current log level in the format of (<logname>:<loglevel>)
  output_dir : The current output directory for the built release
  target_dir : The same as output_dir, exists for backwards compatibility
  overridden : The current list of overridden apps (a list of app names)
  goals : The list of user specified goals in the system
  lib_dirs : The list of library directories, both user specified and derived
  config_file : The list of config file used in the system
  providers : The list of provider names used for this run of relx
  sys_config : The location of the sys config file
  root_dir : The root dir of the current project
  default_release_name : The current default release name for the relx run
  default_release_version : The current default release version for the relx run
  default_release : The current default release for the relx run
  release_erts_version : The version of the Erlang Runtime System in use
  erts_vsn : The same as release_erts_version (for backwards compatibility)
  release_name : The currently executing release
  release_version : the currently executing version
  rel_vsn : Same as release_version. Exists for backwards compatibility
  release_applications : A list of applications included in the release

实例::

  // 文件base.config
  {data_dir, "/data/yolo_app"}.
  {version, "1.0.0"}.
  {run_user, "root"}.

  // 文件dev.config
  %% Include the base config
  "./base.config".
  %% The build we have
  {build, "dev"}.

  // 文件prod.config
  %% Include the base config
  "./base.config".
  %% The build we have
  {build, "prod"}.

Hooks::

  {extended_start_script_hooks, [
    {pre_start, [{custom, "hooks/pre_start"}]},
    {post_start, [
      {pid, "/tmp/foo.pid"},
      {wait_for_process, some_process},
      {custom, "hooks/post_start"}
    ]},
    {pre_stop, [
      {custom, "hooks/pre_stop"}]},
      {post_stop, [{custom, "hooks/post_stop"}]},
    ]},
    {post_stop, [{custom, "hooks/post_stop"}]}
  ]}.

Extensions::

  % start script extensions
  {extended_start_script_extensions, [
     {status, "extensions/status"}
  ]}.

















