heart模块
##############
::

    Heartbeat monitoring of an Erlang runtime system.
    heart发送定期心跳到外部的port program(也叫heart)
    此heart port program是用于检查它监控的Erlang运行时系统是否在running
    如果在HEART_BEAT_TIMEOUT秒(默认60s)没有收到心跳,就重启此系统

::

    % erl -heart ...
    % erl -heart -env HEART_BEAT_TIMEOUT 30 ...
    % erl -heart -env ERL_CRASH_DUMP_SECONDS 10 ...
    % erl -heart -env HEART_KILL_SIGNAL SIGABRT ...
    % erl -heart -env HEART_NO_KILL 1 ...







