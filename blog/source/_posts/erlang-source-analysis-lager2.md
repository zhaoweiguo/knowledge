---
title: 开源项目lager2-application启动
date: 2018-11-02 09:19:11
categories:
- source-analysis
tags:
- erlang
- source-analysis
- lager
---

### lager_sup

1.ets表:lager_config:

    % 初使化时往表里增加2条数据
    1.1 Sink
    {lager_event, loglevel} => {Int, []}
    例:{lager_event,loglevel}, {255,[]}
    其中: Int为8位的整形,即下面的and操作
      -define(DEBUG, 128).
      -define(INFO, 64).
      -define(NOTICE, 32).
      -define(WARNING, 16).
      -define(ERROR, 8).
      -define(CRITICAL, 4).
      -define(ALERT, 2).
      -define(EMERGENCY, 1).
      -define(LOG_NONE, 0).

    1.2 Handlers
    {_global, handlers} => []

2.三个子进程one_for_one:

    {lager, {gen_event, start_link, [{local, lager_event}]},
            permanent, 5000, worker, dynamic}
    {lager_handler_watcher_sup, {lager_handler_watcher_sup, start_link, []},
            permanent, 5000, supervisor, [lager_handler_watcher_sup]}
    //可选,根据env(crash_log)的值
    {lager_crash_log, {lager_crash_log, start_link, [File, MaxBytes,
      RotationSize, RotationDate, RotationCount, RotationMod]},
      permanent, 5000, worker, [lager_crash_log]}

<!--more-->

3.lager_event:

    % 后面操作中增加事件

4.lager_handler_watcher_sup.erl:

    simple_one_for_one:
    {lager_handler_watcher, {lager_handler_watcher, start_link, []},
        temporary, 5000, worker, [lager_handler_watcher]}
    % 后面通过start_child增加

5.lager_crash_log.erl:

    % 后面单独对它分析

### lager_app:boot/0

##### Handler=>lager_backend_throttle

相关参数

    {async_threshold, 20},      % 默认undefined
    {async_threshold_window, 5} % 默认undefined

    a.如没设定async_threshold或值小于0
    不执行以下操作

    b.如没设定async_threshold_window
    async_threshold_window = async_threshold * 0.2(向下取整)

    c.两参数不为整数
    throw异常

    d. 都正常

启动handler=>lager_backend_throttle:

    % 启动一个lager_handler_watcher_sup的child: 
    supervisor:start_child(lager_handler_watcher_sup, [Sink, lager_backend_throttle, [Threshold, Window]])
    其中:
    % Sink=lager_event
    % Threshold=env(async_threshold)
    % Window=env(async_threshold_window)

    说明:
    会先生成simple_one_for_one的lager_handler_watcher,再启动gen_event
    会增加参数{sink, Sink}


##### Handler=>lager_manager_killer

参数:

    {killer_hwm, 1000}              % 默认undefined
    {killer_reinstall_after, 5000}  % 默认5000
    % This means if the sink's mailbox size exceeds 1000 messages,
    % kill the entire sink and reload it after 5000 milliseconds.

    % a. 没有配置killer_hwm参数
    不执行以下操作

    % b.没有配置killer_reinstall_after参数
    默认为5000

    % c.两参数不是大于0整数
    throw异常

    % d.一切正常

启动handler=>lager_manager_killer:

    % 启动一个lager_handler_watcher_sup的child: 
    supervisor:start_child(lager_handler_watcher_sup, [Sink, lager_manager_killer, [HWM, ReinstallTimer]])
    其中:
    % Sink: lager_event
    % HWM: env(killer_hwm)
    % ReinstallTimer: env(killer_reinstall_after)
  
    说明:
    会先生成simple_one_for_one的lager_handler_watcher,再启动gen_event

##### 配置文件配置handlers

配置文件:

    {handlers, [
      {lager_console_backend, [{level, info}]},
      {lager_file_backend, [{file, "error.log"}, {level, error}]},
      {lager_file_backend, [{file, "console.log"}, {level, info}]}
     ]},

    % a.没有设备配置文件
    不执行以下操作

    % b.handlers不是列表
    throw异常

    % c.一切正常


把配件文件转为格式:{Module, Config}，即:

    [
      {lager_console_backend, [{level, info}]},
      {
        {lager_file_backend, "error.log"}, 
        [{file, "error.log"}, {level, error}]
      },
      {
        {lager_file_backend, "console.log"}, 
        [{file, "console.log"}, {level, info}]
      }
    ]


对上面配置文件handlers列表中的每个handler，执行:

    lager_app:check_handler_config(Module, Config)
    1. 如果是lager_console_backend类型:
      直接返回ok
    2. 如果是lager_file_backend类型:
      a. Fs=get(__lager_file_backend_filenames) % 进程字典
        有些字典: 返回值
        无字典: 返回ordsets:new()
      b. put(__lager_file_backend_filenames, ordsets:add_element(F, Fs))
        参数:
        F: "error.log" | "console.log"
        Fs: 进程字典指针

启动handler=>按配置文件启动3个:

    start_handler(Sink, Module, Config)
      % Sink: lager_event
      % Module: 
        % lager_console_backend | 
        % {lager_file_backend, "error.log"} | 
        % {lager_file_backend, "console.log"}
      % Config: [{file, "error.log"}, {level, error}]
      % 说明: handlers配置,对list中的每一项启动一个child
      {ok, Watcher} = supervisor:start_child(lager_handler_watcher_sup, [Sink, Module, Config])

往表lager_config中插入数据:

    {{_global, handlers} => [{Module, Watcher, Sink} | _OtherList]}
    其中:
    Module: {lager_file_backend, "error.log"}
    Watcher: 上一步start_child的pid
    Sink: lager_event

##### update_loglevel_config模块

获取Traces:

    % 后面单独对它分析

get_loglevels(lager_event):

    1.获取所有handlers:
      gen_event:which_handlers(Sink)

    2.执行call/4
      对名为lager_event的gen_event,对它所有的handlers,执行:
          call/4(request:get_loglevel)

    3.合并得到最小log级别,确定什么级别的日志会自动丢弃

    4.更新表lager_config中值:

    key: {lager_event, loglevel}
    value: {MinLog, Traces}
    如:
    {lager_event,loglevel}, {255,[]}


##### start_error_logger_handler/3

参数:

    {error_logger_redirect, true}   % 默认:true
    {error_logger_hwm, 50}          % 默认:0
    {error_logger_whitelist, [Logger.ErrorHandler]} %  Stop lager removing Logger's:error_logger handler
    {error_logger_groupleader_strategy, undefined}  % 默认为undefined

步骤:

    1.如error_logger_redirect => false:
      直接返回[]
    2.参数error_logger_groupleader_strategy的值
      2.1 如为: undefined:
        直接返回: handle
      2.2 如为: handle | ignore | mirror
        直接返回: 此值
      2.3 throw 异常

    3.supervisor:start_child(lager_handler_watcher_sup, [error_logger, error_logger_lager_h, [HWM, GlStrategy]])
      HWM: 配置error_logger_hwm的值
      GlStrategy: 配置error_logger_groupleader_strategy的值

### boot(all_extra)
参数::

    extra_sinks
    # 后面单独对它分析


### boot('traces')
参数::

    traces

说明::

    1. 需要用到goldrush, 后面单独对它分析
    2. traces相关, 后面单独对它分析




