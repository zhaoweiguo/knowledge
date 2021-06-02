mstat命令
##############
mpstat 用于多处理器系统中的CPU的利用率的统计

::

  Usage: mpstat [ options... ] [ <interval> [ <count> ] ]
  Options are:
  [ -P { <cpu> | ALL } ] [ -V ]


实例::

  mpstat -P 0 2 10    //查看第一个CPU

  mpstat 2 10          //查看所有CPU，也可以使用-p ALL

说明::

    %user    显示在用户级别(application)运行使用 CPU 总时间的百分比。
    %nice    显示在用户级别，用于nice操作，所占用 CPU 总时间的百分比。
    %system 在核心级别(kernel)运行所使用 CPU 总时间的百分比。
    %iowait 显示用于等待I/O操作占用 CPU 总时间的百分比。
    %irq  显示在interval时间段内，硬中断占用的CPU总时间。
    %soft  显示在interval时间段内，软中断占用的CPU总时间。
    %steal   管理程序(hypervisor)为另一个虚拟进程提供服务而等待虚拟CPU的百分比。
    %idle    显示 CPU 空闲时间占用CPU总时间的百分比。
    intr/s 在internal时间段里，每秒CPU接收的中断的次数。

其计算理论如下::

    CPU总的工作时间=total_cur=user+system+nice+idle+iowait+irq+softirq
    total_pre=pre_user+ pre_system+ pre_nice+ pre_idle+ pre_iowait+ pre_irq+ pre_softirq
    user=user_cur–user_pre
    total=total_cur-total_pre
    其中_cur 表示当前值，_pre表示interval时间前的值。上表中的所有值可取到两位小数点
    
注：mpstat的取值来自于/proc/stat文件,该文件的几个参数解析如下::

    ctxt: 给出了自系统启动以来CPU发生的上下文交换的次数
    btime: 给出了从系统启动到现在为止的时间，单位为秒
    processes (total_forks): 自系统启动以来所创建的任务的个数目
    procs_running：当前运行队列的任务的数目
    procs_blocked：当前被阻塞的任务的数目



