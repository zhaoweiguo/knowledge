.. _ps:

ps命令使用
=================

显示进程信息,参数可省略::

       aux 以 BSD 风格显示进程 常用
       -efH 以 System V 风格显示进程
       -e , -A 显示所有进程
       a 显示终端上所有用户的进程
       x 显示无终端进程
       u 显示详细信息
       f 树状显示
       w 完整显示信息
       l 显示长列表
       -o <format>   //--format <format>

列属性::

  USER 进程的属主；
  PID   进程的ID；
  PPID    父进程；
  %CPU   进程占用的CPU百分比；
  %MEM  占用内存的百分比；
  NI        进程的NICE值，数值大，表示较少占用CPU时间；
  VSZ     該进程使用的虚拟內存量（KB）；
  RSS     該進程占用的固定內存量（KB）（驻留中页的数量）；
  TTY     該進程在那個終端上運行（登陸者的終端位置），若與終端無關，則顯示（？）。若為pts/0等，則表示由網絡連接主機進程
  WCHAN  當前進程是否正在進行，若為-表示正在進行；
  START   該進程被觸發启动时间；
  TIME      該进程實際使用CPU運行的时间；
  COMMAND   命令的名称和参数；



ps工具标识进程的5种状态码::

  D 无法中断的休眠状态（通常 IO 的进程）uninterruptible sleep (usually IO)
  R 正在运行可中在队列中可过行的,runnable (on run queue)
  S 处于休眠状态, sleeping
  T 停止或被追踪, traced or stopped
  W 进入内存交换  （从内核2.6开始无效）
  X 死掉的进程   （基本很少見）
  Z 僵尸进程, a defunct (”zombie”) process
  < 优先级高的进程
  N 优先级较低的进程
  L 有些页被锁进内存；
  s 进程的领导者（在它之下有子进程）
  l 多进程的（使用 CLONE_THREAD, 类似 NPTL pthreads）
  + 位于后台的进程组



示例::

     ps aux     常用的输出格式
     ps alx     另一种常用输出格式

     // 查看所有进程
     ps -ef    // 显示所有进程信息，连同命令行
     ps –eLf | grep java
     ps -eF
     ps -ely

To see every process on the system using BSD syntax::

    ps ax
    ps axu

To print a process tree::

    ps -ejH
    ps axjf

To get info about threads::

    ps -eLf  // 常用
    ps axms

To get security info::

    ps -eo euser,ruser,suser,fuser,f,comm,label
    ps axZ
    ps -eM

To see every process running as root (real & effective ID) in user format::

    ps -U root -u root u

用户自定义模式看进程::

    ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
    ps axo stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm
    ps -eopid,tt,user,fname,tmout,f,wchan

只打印syslogd的进程id::

    ps -C syslogd -o pid=

只打印PID为42的进程名::

    ps -p 42 -o comm=





实例::

    ps -o rss
    ps -

展示格式::

    rss        RSS
    resident set size, the non-swapped physical memory that a task has used (in kiloBytes). 
    (alias rssize, rsz).
    实际驻留"在内存中"的内存数. 不包括已经交换出去的代码. 举一个例子: 
    如果你有一个程序使用了100K内存, 操作系统交换出40K内存, 那么RSS为60K. 
    RSS还包括了与其它进程共享的内存区域. 这些区域通常用于libc库等

    vsz        VSZ
    virtual memory size of the process in KiB (1024-byte units). 
    Device mappings are currently excluded; this is subject to change. (alias vsize).

    size       SZ
    approximate amount of swap space that would be required if the process were 
      to dirty all writable pages and then be swapped out. This number is very rough!
    进程使用的地址空间, 如果进程映射了100M的内存, 进程的地址空间将报告为100M内存. 
    事实上, 这个大小不是一个程序实际使用的内存数

    sz         SZ
    size in physical pages of the core image of the process. 
    This includes text, data, and stack space. 
    Device mappings are currently excluded; this is subject to change. See vsz and rss.
    （Private RSS）: 映射到内存中的页面, 这些页面仅由进程单独使用.
    这也是我们最关心地方: 进程实际占用的内存数








