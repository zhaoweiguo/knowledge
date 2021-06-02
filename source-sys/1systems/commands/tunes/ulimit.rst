.. _ulimit:

ulimit命令
####################

:说明: ulimit用于shell启动进程所占用的资源
:类别: shell内建命令
:语法格式: ulimit [-acdfHlmnpsStvw] [size]

参数介绍::

    -H 设置硬件资源限制.
    -S 设置软件资源限制.
    -a 显示当前所有的资源限制.
    -c size:设置core文件的最大值.单位:blocks
    -d size:设置数据段的最大值.单位:kbytes
    -f size:设置创建文件的最大值.单位:blocks
    -l size:设置在内存中锁定进程的最大值.单位:kbytes
    -m size:设置可以使用的常驻内存的最大值.单位:kbytes
    -n size:设置内核可以同时打开的文件描述符的最大值.单位:n
    -p size:设置管道缓冲区的最大值.单位:kbytes
    -s size:设置堆栈的最大值.单位:kbytes
    -t size:设置CPU使用时间的最大上限.单位:seconds
    -v size:设置虚拟内存的最大值.单位:kbytes


举例::

    在Linux下写程序的时候，如果程序比较大，经常会遇到 ``"段错误"segmentation fault`` 这样的问题，
    这主要就是由于Linux系统初始的 ``堆栈大小(stack size)`` 太小的缘故, 一般为10M. 
    我一般把stack size设置成256M，这样就没有段错误了!命令为:

    ulimit   -s 262140

    如果要系统自动记住这个配置，就编辑/etc/profile文件
    在 “ulimit -S -c 0 > /dev/null 2>&1”行下，添加“ulimit   -s 262140”，保存重启系统就可以了

    Linux对于每个用户，系统限制其最大进程数。
    为提高性能，可以根据设备资源情况, 设置各linux 用户的最大进程数，
    下面我把某linux用户的最大进程数设为10000个:

    ulimit -u 10000 

其他建议设置成无限制（unlimited）的一些重要设置是::

    数据段长度：ulimit -d unlimited 
    最大内存大小：ulimit -m unlimited 
    堆栈大小：ulimit -s unlimited 
    CPU 时间：ulimit -t unlimited 
    虚拟内存：ulimit -v unlimited 

PS：如果你碰到类似的错误提示::

    ulimit: max user processes: cannot modify limit: 不允许的操作 
    ulimit: open files: cannot modify limit: 不允许的操作 

    为啥root用户是可以的？普通用户又会遇到这样的问题？ 
    看一下 ``/etc/security/limits.conf`` 大概就会明白。 
    linux对用户有默认的ulimit限制, 而这个文件可以配置用户的硬配置和软配置, 硬配置是个上限
    超出上限的修改就会出"不允许的操作"这样的错误。 

在limits.conf加上::

    *        soft    noproc  10240 
    *        hard    noproc  10240 
    *        soft    nofile  10240 
    *        hard    nofile  10240 

    就是限制了任意用户的最大线程数和文件数为10240

说明::

    * 代表针对所有用户
    noproc 是代表最大进程数(max number of processes)
    nofile 是代表最大文件打开数(max number of open files)


注意::

    hard limit不能大于/proc/sys/fs/nr_open
    假如hard limit大于nr_open，注销后无法正常登录




