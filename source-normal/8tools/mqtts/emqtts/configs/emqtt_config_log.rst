Emqtt日志相关配置
======================


Console Log::

  ## Console log. Enum: off, file, console, both
  log.console = console

  ## Console log level. Enum: debug, info, notice, warning, error, critical, alert, emergency
  log.console.level = error

  ## Console log file
  ## log.console.file = log/console.log

Error Log::

  log.error.file = log/error.log

Crash Log::

  ## Enable the crash log. Enum: on, off
  log.crash = on
  log.crash.file = log/crash.log

Syslog::

  ## Syslog. Enum: on, off
  log.syslog = on
  ##  syslog level. Enum: debug, info, notice, warning, error, critical, alert, emergency
  log.syslog.level = error

