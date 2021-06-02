---
title: 开源项目lager1-源码分析前
date: 2018-08-23 17:19:11
categories:
- source-analysis
tags:
- erlang
- source-analysis
- lager
---

### 目的

项目使用lager打印日志很多时，会造成以下2个主要问题:

    1.「Lager的erlang消息队列」数会变成很大，影响整个系统性能
    2.有时会丢失部分日志

目的:

    1.通过源码分析找到这2个问题的原因
    2.是否可以找到一些方法解决这个问题
    3.看是否可以重写部分代码来提升性能

<!--more-->


### 看源码前工作

看lager文档显示以下几个主要参数:

    {async_threshold, 20},
    {async_threshold_window, 5}
    小于20使用异步,超过20切换回同步,小于20-5=15再切换回异步

    {error_logger_hwm, 50}
    每秒最大日志数,即戒备线
    {error_logger_flush_queue, true | false}
    % 默认是true,可以关闭
    % 超过戒备线,会flush all event notifications in the message queue
    % 而这会对other handlers in the same event manager造成意外后果
    {flush_queue, true | false}
    % flush_queue为true时可以设置threshold

    {error_logger_flush_threshold, 1000}
    % 设定error_logger sink的阀值
    {flush_threshold, 1000}
    % 对所有的sinks的阀值

    {killer_hwm, 1000},
    {killer_reinstall_after, 5000}
    // 有时你需要丢弃所有pending日志消息而不是让他耗光时间
    // if the gen_event mailbox exceeds a configurable high water mark,
    // the sink will be killed and reinstalled after a configurable cool down time
    % This means if the sink's mailbox size exceeds 1000 messages, kill the entire sink and reload it after 5000 milliseconds
    % By default, the manager killer is not installed into any sink. If the killer_reinstall_after cool down time is not specified it defaults to 5000.

ets表lager_config内容:

    [
      {
        {lager_event,loglevel}, {255,[]}
      },

      {{lager_event,async}, true},

      {
        {'_global',handlers},
        [
          {lager_console_backend,<0.148.0>,lager_event},
          {{lager_file_backend,"log/info.log"},<0.150.0>,lager_event},
          {{lager_file_backend,"log/notice.log"},<0.152.0>,lager_event},
          {{lager_file_backend,"log/warning.log"},<0.154.0>,lager_event},
          {{lager_file_backend,"log/error.log"},<0.156.0>,lager_event},
          {{lager_file_backend,"log/critical.log"},<0.158.0>,lager_event},
          {{lager_file_backend,"log/alert.log"},<0.160.0>,lager_event},
          {{lager_file_backend,"log/emergency.log"},<0.162.0>,lager_event},
          {{lager_file_backend,"console.log"},<0.164.0>,lager_event}
        ]
      }
    ]


### parse_transform模式

获取parse_transform模式源码:

    Beam = "./_build/default/lib/demo/ebin/demo_server.beam".
    {ok, {_, [{abstract_code, {_,Abs}}]}} =  beam_lib:chunks(
      Beam, [abstract_code]).
    io:fwrite("~s~n", [erl_prettypr:format(erl_syntax:form_list(Abs))]).
    % 通过以上命令得到parse_transform后的源码

原始使用:

    lager:info("handle_call _Request = ~p",[_Request]),

parse_transform模式转化后:

    case {whereis(lager_event), whereis(lager_event),
          lager_config:get({lager_event, loglevel}, {0, []})}
        of
      {undefined, undefined, _} ->
          fun () -> {error, lager_not_running} end();
      {undefined, _, _} ->
          fun () -> {error, {sink_not_configured, lager_event}}
          end();
      {__Piddemo_lager_server42, _, {__Leveldemo_lager_server42, __Tracesdemo_lager_server42}}
          when __Leveldemo_lager_server42 band 4 /= 0 orelse
                 __Tracesdemo_lager_server42 /= [] ->
          lager:do_log(info,
                       [{application, mongrel}, {module, mongrel},
                        {function, handle_call}, {line, 79},
                        {pid, pid_to_list(self())}, {node, node()}
                        | lager:md()],
                       "handle_call _Request= ~p", [_Request], 4096, 4,
                       __Leveldemo_lager_server42, __Tracesdemo_lager_server42, lager_event, __Piddemo_lager_server42);
      _ -> ok
    end,




