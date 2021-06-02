配置文件
##############

Syslog style loglevel comparison flags::

  info - info and higher (>= is implicit)
  =debug - only the debug level
  !=info - everything but the info level
  <=notice - notice and below
  <warning - anything less than warning

Internal log rotation::

  % 记录error及以上
  % 文件大于10mb或每天凌晨时，循环日志:{size, 10485760}, {date, "$D0"}
  % 保持5个历史日志: {count, 5}
  [{file, "error.log"}, {level, error}, {size, 10485760}, {date, "$D0"}, {count, 5}]

  % 记录error
  % 不循环打印:{size, 0}, {date, ""}
  [{file, "error.log"}, {level, =error}, {size, 0}, {date, ""}, {count, 5}]


  % 记录小于warning
  % 文件大于10mb或每周日23点循环: {size, 10485760}, {date, "$W0D23"}
  % 不保持历史日志: {count, 0}
  [{file, "error.log"}, {level, <warning}, {size, 10485760}, {date, "$W0D23"}, {count, 0}]

  % date实例
  $D0     rotate every night at midnight
  $D23    rotate every day at 23:00 hr
  $W0D23  rotate every week on Sunday at 23:00 hr
  $W5D16  rotate every week on Friday at 16:00 hr
  $M1D0   rotate on the first day of every month at
          midnight (i.e., the start of the day)
  $M5D6   rotate on every 5th day of the month at
          6:00 hr


日志格式实例::

  {lager_file_backend, [
    {file, "error.log"}, 
    {level, error}, 
    {formatter, lager_default_formatter},
    {size, 104857600}, 
    {date, "$D0"}, 
    {count, 15},
    {formatter_config, [
      date, " ", time, " [", severity, "] ", pid, " ", module, ":", function, "(", line, ") ", message, "\e[0m\r\n"
    ]}
  ]}
  // formatter_config说明:
  sev: severity的缩写，'debug' -> $D
  pid, file, line, module, function, and node
  application
  name
  {atom(), semi-iolist()}


其他::

  %% format log timestamps as UTC
  [{sasl, [{utc_log, true}]}].

Exception Pretty Printing::

  try
      foo()
  catch
      Class:Reason ->
          lager:error(
              "~nStacktrace:~s",
              [lager:pr_stacktrace(erlang:get_stacktrace(), {Class, Reason})])
  end.

Record Pretty Printing::

  lager:info("My state is ~p", [lager:pr(State, ?MODULE)])

Colored terminal output::

  % Erlang R16+
  {colored, true}
  {lager_console_backend, [
    {level, info}, {formatter, lager_default_formatter},
    {formatter_config, [time, color, " [",severity,"] ", message, "\e[0m\r\n"]}
  ]}






