recon [1]_
###############



.. toctree::
   :maxdepth: 1

   recons/recon_info
   recons/recon_memory
   recons/recon_cpu
   recons/recon_trace
   recons/recon_proc
   recons/recon_crash
   recons/recon_port



其他::

    Let it Crash:
    大多数bug都是暂态的,进程重启到一个已知的稳态是一个非常不错的策略
    卫生保证机制 VS 免疫系统(可以在运行时处理错误，并视此为一种生存能力)

    ETS 表每秒能处理的请求量要远高于进程

    +sbwt none | very_short | short | medium | long | vey_long
    
    cpu最为精确的数据是调度器钟表时间(wall clock)

对节点进行GC，并返回进程GC前后持有的binary差异最大的N个进程::

  % 
  recon:bin_leak(N).

返回M毫秒内的调度器占用::

  recon:scheduler_usage(M)





.. [1] https://github.com/ferd/recon







