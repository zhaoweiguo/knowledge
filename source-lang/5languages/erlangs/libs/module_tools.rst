Tools
##########



Reference Manual: [1]_
User's Guide: [2]_

.. toctree::
   :maxdepth: 2

   tools/fprof


::

    cprof测试每个函数被调用了多少次,这个工具为轻量在运行系统上使用这个工具会给系统带来5%~10%的额外负载
    fprof显示函数调用和被调用的埋单，并将结果输出到一个文件中，这个工具比较适合于在实验环境或模拟环境中对进行大规模的性能前一段，它会带来非常显著的系统负载.
    eprof分分析一个Erlang程序中计算时间主要消耗在哪里，它实际是fprof的前任，不同在于：这适合规模小一些的性能前评估.



.. [1] http://erlang.org/doc/apps/tools/index.html
.. [2] http://erlang.org/doc/apps/tools/users_guide.html
