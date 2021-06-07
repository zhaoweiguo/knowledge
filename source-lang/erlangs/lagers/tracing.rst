日志跟踪
##############

基本用法
-----------
::


    lager:trace_file("log/error.log", [{module, mymodule}], warning)

    // 下面两命令相同
    lager:trace_console([{request, 117}])
    lager:trace_console([{request, 117}], debug)

    % 查看跟踪状态
    lager:status()

    % 清除全部跟踪
    lager:clear_all_traces().

    % 删除指定trace
    {ok, Trace} = lager:trace_file("log/error.log", [{module, mymodule}]),
    ...
    lager:stop_trace(Trace)

    % 进程跟踪用字符串
    lager:trace_console([{pid, "<0.410.0>"}])

Filter composition::

    % all means "AND style" 
    lager:trace_console([{all, [{request, '>', 117}, {request, '<', 120}]}])
    % any has the effect of "OR style" 
    lager:trace_console([{any, [{request, '>', 117}, {request, '<', 120}]}])

Null filters::

    {null, false}: 像黑洞, 任何都通不过
    {null, true}: 所有都能通过


自定义跟踪
------------

根据log message attributes可以实现日志跟踪,lager自动对pid, module, function and line这4个attributes进行日志跟踪。但你也可以按自己期望增加。

如::

    lager:warning([{request, RequestID},{vhost, Vhost}], "Permission denied to ~s", [User]).

你就可以通过下面的方法进行跟踪::

    lager:trace_file("logs/example.com.error", [{vhost, "example.com"}], error).

在进程的生命周期中保留元数据::

    lager:md([{zone, forbidden}]).
    % lager:md will only accept a list of key/value pairs keyed by atoms.


Multiple sink support
--------------------------

默认sink为lager_event，但可以指定其他sink为，如::

    % 指定sink为audit_event
    lager:trace_file("log/security.log", [
      {sink, audit_event}, 
      {function, myfunction}
    ], warning)

有下面2个未解决问题::

    Traces cannot intercept messages sent to a different sink.
      解决:opening multiple traces
    使用lager:trace_file打开的文件，不能再被其他sink的trace_file写
      解决:rearchitecting lager's file backend, but this has not been tackled.


Traces from configuration
--------------------------------

实例::

  {lager, [
    {handlers, [...]},
    {traces, [
      %% handler,                         filter,                message level (defaults to debug if not given)
      {lager_console_backend,             [{module, foo}],       info },
      {{lager_file_backend, "trace.log"}, [{request, '>', 120}], error},
      {{lager_file_backend, "event.log"}, [{module, bar}]             } %% implied debug level here
    ]}
  ]}.










