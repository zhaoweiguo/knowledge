perf命令
===============

安装::

   apt-get install linux-tools-3.16
   yum install perf

使用

   perf stat xxxx.sh   // 察看指定命令的运行情况,准备调优


   perf top
   //用于实时显示当前系统的性能统计信息
   该命令主要用来观察整个系统当前的状态，比如可以通过查看该命令的输出来查看当前系统最耗时的内核函数或某个用户进程




