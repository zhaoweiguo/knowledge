do_log转化
#############
使用::

    lager:info("handle_call Request = ~p",[Request]),

最本质是调用::

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
       "handle_call Request= ~p", 
       [Request], 
       4096, 
       4,
       __Leveldemo_lager_server42, 
       __Tracesdemo_lager_server42, 
       lager_event, 
       __Piddemo_lager_server42
    );

    do_log(Severity, Metadata, Format, Args, Size, SeverityAsInt, LevelThreshold, TraceFilters, Sink, SinkPid)






