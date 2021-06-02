recon crash
################



分析崩溃文件::

  % 分析崩溃文件
  erl_crashdump_analyzer.sh erl_crash.dump

  % 遍历崩溃文件，把邮箱中消息个数大于 1000 的进程正在运行的函数打印出来
  awk -v threshold=10000 -f ~/bin/queue_fun.awk erl_crash.dump

  常见问题:
  进程太多(或者太少)
  端口太多
  无法分配内存



