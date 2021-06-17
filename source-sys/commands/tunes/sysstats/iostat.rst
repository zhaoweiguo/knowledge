.. _iostat:

iostat命令
###################
iostat是I/O statistics（输入/输出统计）的缩写，用来动态监视系统的磁盘操作活动::
  
  iostat[参数][时间][次数]

命令参数::

  -C 显示CPU使用情况
  -d 显示磁盘使用情况

  -k 以 KB 为单位显示
  -m 以 M 为单位显示

  -N 显示磁盘阵列(LVM) 信息
  -n 显示NFS 使用情况
  -p[磁盘] 显示磁盘和分区的情况
  -t 显示终端和CPU的信息
  -x 显示详细信息
  -V 显示版本信息


结果说明::

  tps：该设备每秒的传输次数(Indicate the number of transfers per second that were issued to the device.)“一次传输”意思是“一次I/O请求”.多个逻辑请求可能会被合并为“一次I/O请求”.“一次传输”请求的大小是未知的

  kB_read/s：每秒从设备（drive expressed）读取的数据量
  kB_wrtn/s：每秒向设备（drive expressed）写入的数据量
  kB_read：读取的总数据量
  kB_wrtn：写入的总数量数据量

使用-x参数的请求::

  rrqm/s：每秒这个设备相关的读取请求有多少被Merge了（当系统调用需要读取数据的时候，VFS将请求发到各个FS，如果FS发现不同的读取请求读取的是相同Block的数据，FS会将这个请求合并Merge）；wrqm/s：每秒这个设备相关的写入请求有多少被Merge了。

  rsec/s：每秒读取的扇区数；wsec/：每秒写入的扇区数。r/s：The number of read requests that were issued to the device per second；w/s：The number of write requests that were issued to the device per second；

  await：每一个IO请求的处理的平均时间（单位是微秒毫秒）。这里可以理解为IO的响应时间，一般地系统IO响应时间应该低于5ms，如果大于10ms就比较大了

  %util：在统计时间内所有处理IO时间，除以总共统计时间。例如，如果统计间隔1秒，该设备有0.8秒在处理IO，而0.2秒闲置，那么该设备的%util = 0.8/1 = 80%，所以该参数暗示了设备的繁忙程度。一般地，如果该参数是100%表示设备已经接近满负荷运行了（当然如果是多磁盘，即使%util是100%，因为磁盘的并发能力，所以磁盘使用未必就到了瓶颈）。






实战::

  1. 显示所有设备负载情况
  iostat
  
  2. 定时显示所有信息
  每隔 2秒刷新显示，且显示3次
  iostat 2 3

  3.只显示cpu信息
  iostat -c 1 3

  4.
  -d 显示设备（磁盘）使用状态
  -k 单位KB
  1 10 数据显示每隔1秒刷新一次，共显示10次
  作用:查看TPS和吞吐量信息
  iostat -d -k 1 10
  
  5. 显示更详细信息
  作用:查看设备使用率（%util）和响应时间（await）
  iostat -d -x -k 1 10



  



扩展::

  rrqm/s:   每秒进行 merge 的读操作数目.即 delta(rmerge)/s
  wrqm/s:  每秒进行 merge 的写操作数目.即 delta(wmerge)/s
  r/s:           每秒完成的读 I/O 设备次数.即 delta(rio)/s
  w/s:         每秒完成的写 I/O 设备次数.即 delta(wio)/s
  rsec/s:    每秒读扇区数.即 delta(rsect)/s
  wsec/s:  每秒写扇区数.即 delta(wsect)/s
  rkB/s:      每秒读K字节数.是 rsect/s 的一半,因为每扇区大小为512字节.(需要计算)
  wkB/s:    每秒写K字节数.是 wsect/s 的一半.(需要计算)
  avgrq-sz: 平均每次设备I/O操作的数据大小 (扇区).delta(rsect+wsect)/delta(rio+wio)
  avgqu-sz: 平均I/O队列长度.即 delta(aveq)/s/1000 (因为aveq的单位为毫秒).
  await:    平均每次设备I/O操作的等待时间 (毫秒).即 delta(ruse+wuse)/delta(rio+wio)
  svctm:   平均每次设备I/O操作的服务时间 (毫秒).即 delta(use)/delta(rio+wio)
  %util:      一秒中有百分之多少的时间用于 I/O 操作,或者说一秒中有多少时间 I/O 队列是非空的.即 delta(use)/s/1000 (因为use的单位为毫秒)

说明::

  如果 %util 接近 100%,说明产生的I/O请求太多,I/O系统已经满负荷,该磁盘
  可能存在瓶颈.
  idle小于70% IO压力就较大了,一般读取速度有较多的wait.
  同时可以结合vmstat 查看查看b参数(等待资源的进程数)和wa参数(IO等待所占用的CPU时间的百分比,高过30%时IO压力高)
  另外 await 的参数也要多和 svctm 来参考.差的过高就一定有 IO 的问题.
  avgqu-sz 也是个做 IO 调优时需要注意的地方,这个就是直接每次操作的数据的大小,如果次数多,但数据拿的小的话,其实 IO 也会很小.如果数据拿的大,才IO 的数据会高.也可以通过 avgqu-sz × ( r/s or w/s ) = rsec/s or wsec/s.也就是讲,读定速度是这个来决定的.





