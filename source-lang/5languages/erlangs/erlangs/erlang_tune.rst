Erlang调优
##########

::

  [erlang:garbage_collect(P) || P <- erlang:processes(),{status, waiting} == erlang:process_info(P, status)].




+zerts_de_busy_limit
====================

* http://blog.yufeng.info/archives/689
* from: http://blog.yufeng.info/archives/2641
* erlang:system_monitor(MonitorPid, Options) -> MonSettings
* 当我们收到{monitor, SusPid, busy_dist_port, Port}消息的时候，就可以确认系统经常有阻塞问题。
* http://www.erlang.org/doc/man/erlang.html#system_info_dist_buf_busy_limit
* http://www.erlang.org/doc/man/erl.html#+zdbbl 





* https://blog.csdn.net/huang1196/article/details/38660325