基本
###########

::

    ets:tab2list(lager_config).

    {parse_transform, lager_transform}


交流::

  freenode:10 pm UTC,every third Thursday
  https://github.com/erlang-lager/lager
  其他backend
  https://github.com/jbrisbin/lager_amqp_backend

Sink configuration::

  lager:info  => lager_event
  audit:info  => audit_lager_event
  myCompanyName:debug  => myCompanyName_lager_event

  // rebar.config
  {lager_extra_sinks, [audit]}

Error logger integration::

  error_logger_redirect   => true: //把系统error_logger转为lager的error_logger
  error_logger_format_raw => true: //disable reformatting for OTP and Cowboy messages


Asynchronous mode::

  % 小于20使用异步,超过20切换回同步,小于20-5再切换回异步
  % 原因: 异步不可控,会把系统crash
  {async_threshold, 20},
  {async_threshold_window, 5}
  % 如果想一直异步模式
  {async_threshold, 20},

  % 可设定每秒最大日志数
  {error_logger_hwm, 50}

Event queue flushing::

  % 超过戒备线,会flush all event notifications in the message queue
  % 而这会对other handlers in the same event manager造成意外后果
  % 默认是true,可以关闭
  {error_logger_flush_queue, true | false}

  % 
  {flush_queue, true | false}
  % flush_queue为true时可以设置threshold
  % 设定error_logger sink的阀值
  {error_logger_flush_threshold, 1000}

  %对所有的sinks
  {flush_threshold, 1000}

Sink Killer::

  // 有时你需要丢弃所有pending日志消息而不是让他耗光时间
  // if the gen_event mailbox exceeds a configurable high water mark, 
  // the sink will be killed and reinstalled after a configurable cool down time

  //例:
  {killer_hwm, 1000},
  {killer_reinstall_after, 5000}
  % This means if the sink's mailbox size exceeds 1000 messages, kill the entire sink and reload it after 5000 milliseconds
  % By default, the manager killer is not installed into any sink. If the killer_reinstall_after cool down time is not specified it defaults to 5000.



Runtime loglevel changes::

  // 确定有哪几个event
  gen_event:which_handlers(lager_event).
  // 设定指定event到指定级别
  lager:set_loglevel(lager_console_backend, debug).
  lager:set_loglevel(lager_file_backend, "console.log", debug).






