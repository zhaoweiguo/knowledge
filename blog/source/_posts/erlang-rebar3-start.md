---
title: Erlang：Rebar3的简单使用
date: 2018-07-24 20:09:43
categories:
- erlang
tags:
- erlang
- rebar3
---


### 安装

##### 方法一：源码安装
```
$ git clone https://github.com/erlang/rebar3.git
$ cd rebar3
$ ./bootstrap
```
##### 方法二：点击「链接」直接下载

https://s3.amazonaws.com/rebar3/rebar3

##### 方法三：直接从其他项目中拷贝

<!--more-->

### 项目说明

##### 新建项目命令
```
//1新建一个简单app项目
$ rebar3 new app <projName>
//2新建一个多app项目
$ rebar3 new release <projName>
//3新建一个简单app项目
$ rebar3 new lib <projName>
//4新建一个rebar插件
$ rebar3 new plugin <projName>
```
##### app项目结构
```
$> rebar3 new app projApp

├── LICENSE
├── README.md
├── rebar.config
└── src
    ├── projApp.app.src
    ├── projApp_app.erl
    └── projApp_sup.erl
```
##### release项目结构
```
$> rebar3 new release projRel

├── LICENSE
├── README.md
├── apps
│   └── projRel
│       └── src
│             ├── projRel.app.src
│             ├── projRel_app.erl
│             └── projRel_sup.erl
├── config
│   ├── sys.config
│   └── vm.args
└── rebar.config
```
PS:看文件目录就能大体看出，这两个的区别，app类型项目主要是简单的项目，而release项目多了个apps目录，此目录下可以有多个Erlang的application，可以处理复杂项目

##### lib项目
```
├── LICENSE
├── README.md
├── rebar.config
└── src
    ├── projLib.app.src
    └── projLib.erl
```
##### plugin项目

说明:代码格式与app相同，但它有一套它自己的实现方式，具体实现留到以后来做


##### 编译运行
以上把新建这块大体说完了，下面以release类项目为实例，具体分析
执行
```
$> rebar3 compile
```
编译成功，会生成一个新文件夹_build
```
├── _build
│   └── default
│       └── lib
│           └── projRel
│               ├── ebin
│               │   ├── projRel.app
│               │   ├── projRel_app.beam
│               │   └── projRel_sup.beam
│               ├── include -> ../../../../apps/projRel/include
│               ├── priv -> ../../../../apps/projRel/priv
│               └── src -> ../../../../apps/projRel/src
```

##### 文件目录说明
```
deps默认目录:
_build/default/lib
release默认目录:
_build/default/rel
test默认目录:
_build/test/lib
```

### 常见命令
```
//查看依赖树
$ rebar3 tree
//查看依赖 $ rebar3 deps
//release所有app
$ rebar release

//release指定app
$ rebar3 release -n <release_name>

//按指定配置release
$ rebar3 as prod tar 
```


### 配置文件实例
```erlang
{erl_opts, [
  debug_info
  ,{i, "./include"}  % 指定include文件目录
  ,{d, 'NOTEST', true}   %
  ,{parse_transform, lager_transform}  %lager专用
 
]}.
 
% {deps_error_on_conflict, true}. // 增加这句，依赖有冲突时，会中止
{rebar_packages_cdn, "https://hexpm.upyun.com"}.  % package中国镜像
 
 
{plugins, [  %% 插件
  % .dtl格式文件插件
  {rebar3_erlydtl_plugin, ".*",
    {git, "https://github.com/tsloughter/rebar3_erlydtl_plugin.git", {branch, "master"}}}
]}.
 
 
{deps, [
  {apns,    {git, "git@github:zhaoweiguo/apns.git"}},
  {eredis, {git, "https://github.com/wooga/eredis.git", {tag, "v1.1.0"}}},
  {brod, {git, "https://github.com/klarna/brod.git", {tag, "3.4.0"}}}
  ... ...
]}.
 
{erlydtl_opts,[ % erlydtl插件相关配置
  {doc_root, "templates"}
  %,{compiler_options, [report, return, debug_info]}
]}.
{provider_hooks, [  %% hook钩子
  {pre, [{compile, {erlydtl, compile}}]}  % 执行rebar3 compile时先执行rebar3 plugin compile
]}.
 
 
 
{relx, [{
  release, {
    octopus, "0.1.0"
  },
  [octopus,
    ... ...
    sasl]},
 
  {sys_config, "./config/octopus.config"},
  {vm_args, "./config/vm.args"},
 
  {dev_mode, false}, % 开发模式
  {include_erts, false},  % 编译时是否包含erts库
%%  {exclude_modules, [{
%%    syntax_tools, [merl, merl_transform]
%%  }]},
 
  {extended_start_script, true}
]}.
 
{profiles, [{ % 配置相关，同一rebar.config可以生成多种不同版本,如release, default, debug等
  prod, [
    {
      erl_opts
%      ,[no_debug_info, warnings_as_errors]   % [注意]加此句,有warning不能通过
      ,[no_debug_info]
    },
    {relx, [
      {dev_mode, false},    % 用于修改上面relx顶层目录的配置
      {include_erts, true}
    ]}
  ]
}]
}.
```







