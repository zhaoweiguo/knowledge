fprof
##########


实例::

    fprof:apply(foo, create_file_slow, [junk, 1024]).
    fprof:profile().
    fprof:analyse().

实例::

    Procs = [Pid1, Pid2].
    fprof:trace([start, {procs, Procs}]).
    fprof:trace([stop]).
    fprof:profile().
    fprof:analyse([totals, no_details, {sort, own},
                      no_callers, {dest, "fprof.analysis"}]).
    fprof:stop().




User's Guide
'''''''''''''''''

fprof是一个分析工具, 可用于了解不同的函数消费在不同进程的处理时间.



