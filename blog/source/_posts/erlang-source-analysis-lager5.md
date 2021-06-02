
---
title: 开源项目lager5-其他边边角角
date: 2018-11-05 09:19:11
categories:
- source-analysis
tags:
- erlang
- source-analysis
- lager
---

### trace_filter

执行lager_util:trace_filter(none):

    glc:compile(lager_default_tracer, glc:null(false))

lager_app:add_configured_traces/1:

<!--more-->

    配置文件:
    {traces, [
      %% handler,                         filter,        message level (defaults to debug)
      {lager_console_backend,             [{module, foo}],       info },
      {{lager_file_backend, "trace.log"}, [{request, '>', 120}], error},
      {{lager_file_backend, "event.log"}, [{module, bar}]   } %% implied debug level here
    ]}
    取出配置文件traces的值,对此列表每个item执行
      lager:trace(Handler, Filter) =>lager:trace(Handler, Filter, debug)
      or
      lager:trace(Handler, Filter, Level)



lager:trace({lager_file_backend, File}, Filter, Level):

    =>lager:trace_file(File, Filter, Level)
      a.从配置文件Filter里按key取值sink,如没配置默认为:lager_event
      @todo

lager:trace(Backend, Filter, Level):

    1.lager:validate_trace_filters(Filter, Level, Backend):

      a.<Sink> = proplists:get_value(sink, Filters, lager_event)
      b.<ValidFilter> = lager_util:validate_trace({
                                 proplists:delete(sink, Filters),
                                 Level,
                                 Backend
                               })
      c.返回{<Sink>, <ValidFilter>}
    2.lager:add_trace_to_loglevel_config({Filter, <Bin>, Handler}, <Sink>)
        1. {MinLevel, Traces} = 从表lager_config通过key:{<Sink>, loglevel})取值
        2. Traces中是否包含{Filter, <Bin>, Handler}:
          1.1.包含=> ignore
          1.2 不包含:
            NewTraces = [{Filter, <Bin>, Handler}|Traces]
            对NewTraces的每个item执行:
              lager_util:trace_filter(Filter).
              即:glc:compile(lager_default_tracer, glc_lib:reduce(trace_any(Filter))).
            更新表lager_config的key:{<Sink>, loglevel})对应的值

lager_util:validate_trace({Filter, Level, Destination}):

    1.<ValidFilter> = lager_util:validate_trace_filter(Filter)=> true | false
    2.<LevelBin> = level的二进制值<Bin>
    3.判断
      1. if <ValidFilter> == false => {error, invalid_trace}
      2. if Filter是个列表=> {ok, {glc:all(trace_acc(Query)), <LevelBin>, Handler}}
      3. 其他: {ok, {Filter, <LevelBin>, Handler}}


### extra_sinks相关
配置文件:

    {extra_sinks,
     [{audit_lager_event,
       [
        {handlers,
         [{lager_file_backend,
           [{file, "sink1.log"},
            {level, info}
           ]
          }]
        },
        {async_threshold, 500},
        {async_threshold_window, 50}
        ]
      }]
    }

步骤:

    1.往表lager_config中插入数据:
        key:{audit_lager_event, loglevel}
        value:{<Bin>, []}
    2.
    supervisor:start_child(lager_sup,
       {audit_lager_event_lager_event,
        {gen_event, start_link, [{local, audit_lager_event}]},
        permanent, 5000, worker, dynamic})
    3.如这儿配置文件值都为正常的,如
        {async_threshold, 500},
        {async_threshold_window, 50}
      则:
      supervisor:start_child(lager_handler_watcher_sup,
          [audit_lager_event, lager_backend_throttle, [500, 50]]),






