---
title: 开源项目lager4:lager写入函数分析
date: 2018-11-04 09:19:11
categories:
- source-analysis
tags:
- erlang
- source-analysis
- lager
---


原始使用:

    lager:info("handle_call _Request = ~p",[_Request]),

最本质是调用:

    lager:do_log(info,
       [
            {application, mongrel}, 
            {module, mongrel},
            {function, handle_call}, 
            {line, 79},
            {pid, pid_to_list(self())}, 
            {node, node()}
            | lager:md()
        ],
       "handle_call _Request= ~p", 
       [_Request], 
       4096, 
       4,
       __Leveldemo_lager_server42, 
       __Tracesdemo_lager_server42, 
       lager_event, 
       __Piddemo_lager_server42
    );

    do_log(Severity, Metadata, Format, Args, Size, SeverityAsInt, LevelThreshold, TraceFilters, Sink, SinkPid)

<!--more-->

再本质:

    同步:
    gen_event:notify(SinkPid, {log, LagerMsg});
    异步:
    gen_event:sync_notify(SinkPid, {log, LagerMsg})









