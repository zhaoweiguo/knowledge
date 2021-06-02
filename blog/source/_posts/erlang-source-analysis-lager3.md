---
title: 开源项目lager3-设置阀值相关
date: 2018-11-03 09:19:11
categories:
- source-analysis
tags:
- erlang
- source-analysis
- lager
---

### lager_backend_throttle

入口:

    init([{sink, Sink}, Hwm, Window])

表:

    表lager_config:
    {{lager_event,async}, true},

状态:

    #state{sink=Sink, hwm=Hwm, window_min=Hwm - Window}
    % Sink=lager_event
    % Threshold=env(async_threshold)
    % Window=env(async_threshold_window)

<!--more-->

### lager_manager_killer

状态:

    #state{killer_hwm=KillerHWM, killer_reinstall_after=KillerReinstallAfter}
    
    % Sink: lager_event
    % HWM: env(killer_hwm)
    % ReinstallTimer: env(killer_reinstall_after)


### lager_file_backend

状态:

    -record(state, {
        name :: string(),     //文件路径
        level :: {'mask', integer()},
        fd :: file:io_device() | undefined,
        inode :: integer() | undefined,
        flap=false :: boolean(),
        size = 0 :: integer(),
        date :: undefined | string(),
        count = 10 :: integer(),
        rotator = lager_util :: atom(),
        shaper :: lager_shaper(),
        formatter :: atom(),
        formatter_config :: any(),
        sync_on :: {'mask', integer()},
        check_interval = ?DEFAULT_CHECK_INTERVAL :: non_neg_integer(),
        sync_interval = ?DEFAULT_SYNC_INTERVAL :: non_neg_integer(),
        sync_size = ?DEFAULT_SYNC_SIZE :: non_neg_integer(),
        last_check = os:timestamp() :: erlang:timestamp()
    }).



