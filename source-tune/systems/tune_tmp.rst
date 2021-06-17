优化相关临时
############


ulimit修改办法
==============

* 修改文件 ``/etc/security/limits.conf``
* 文件尾部增加::

    // open files(文件句柄数) ulimit -SHn 65535
    * soft nofile 51200
    * hard nofile 51200
    // max user processes(用户进程数) ulimit -SHu 65535
    // ulimit -u进行了限制那么每个linux用户可以派生出来的process就会被限制再这个数值之内
    * soft nproc  65535
    * hard nproc  65535

* 退出控制台，重新登陆使用命令 ``ulimit -n``

Linux下如何查看CPU信息, 包括位数和多核信息
==============================================

* 查看当前操作系统版本信息::

    # uname -a
    Linux redcat 2.6.31-20-generic #58-Ubuntu SMP Fri Mar 12 05:23:09 UTC 2010 i686 GNU/Linux

    # cat /etc/issue
    or
    # cat /etc/redhat-release

    # cat /proc/version （Linux查看当前操作系统版本信息）

    # cat /proc/cpuinfo （Linux查看cpu相关信息，包括型号、主频、内核信息等）



* 查看cpu型号::

    # cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
    2  Intel(R) Core(TM)2 Duo CPU     P8600  @ 2.40GHz
    (看到有2个逻辑CPU, 也知道了CPU型号)

* 查看物理cpu颗数::

    # cat /proc/cpuinfo | grep physical | uniq -c
    2 physical id    : 0
    (说明实际上是1颗2核的CPU)

* 查看cpu运行模式::

    # getconf LONG_BIT
    32
    (说明当前CPU运行在32bit模式下, 但不代表CPU不支持64bit)

* 查看cpu是否支持64bit::

    #cat /proc/cpuinfo | grep flags | grep ' lm ' | wc -l
    2
    (结果大于0, 说明支持64bit计算. lm指long mode, 支持lm则是64bit)

* 查看cpu信息概要::

    #lscpu

Linux 如何查看主机的cpu个数和总内存
===================================
* check_cpu::

    Check_cpu_model=`grep /proc/cpuinfo "model name"|uniq`
    Check_cpu_physical=`grep 'physical id' /proc/cpuinfo | sort | uniq | wc -l`
    Check_cpu_processor=`grep processor /proc/cpuinfo | wc -l`
    Check_cpu_flags=`grep flags /proc/cpuinfo | uniq | egrep -o -w "rm|tm|lm"`

* check_memory::

    Check_mem_use_state=`dmidecode |grep -P -A 5 "Memory Device" |grep Size |grep -v Range`
    Check_mem_support_max=`dmidecode |grep -P "Maximum Capacity"`
    Check_mem_speed=`dmidecode | grep -A16 “Memory Device” | grep ‘Speed’`



按顺序列出内存占用率的进程
==========================
::

    ps -A --sort -rss -o comm,pmem,pcpu |uniq -c |head -15

查看linux版本号的命令
=====================
::

    cat   /proc/version
    uname   -a


实战:

http://blog.sae.sina.com.cn/archives/3945




系统出问题时查看日志方法
==============================
::

    dmesg:日志察看
    lspci
    file /bin/cp
    strings /bin/cp
    md5sum /bin/cp
    fdisk -l
    smartctl /dev/md0
    /etc/init.d/syslog start
    w/who(w gordon, who -HT)
    执行last命令其实是显示/var/log/目录下的wtmp文件内容。Wtmp文件是以二进制格式进行存储的

    查看sc用户登录历史
    >> last sc

    last
    lastlog
    histroy
    lastb(?)

    tty表示显示器,pts表示远程连接


系统出问题时查看日志方法2
===================================
* 频繁重启的原因，如果不是入侵，绝对是硬件,看CPU的温控，内存,之后硬盘( ``>> last`` )::

    reboot   system boot  2.6.18-308.el5   Wed Feb 27 22:35          (12:35)
    reboot   system boot  2.6.18-308.el5   Wed Feb 27 22:31          (12:39)
    reboot   system boot  2.6.18-308.el5   Wed Feb 27 22:26          (12:44)
    reboot   system boot  2.6.18-308.el5   Wed Feb 27 22:22          (12:48)

* 有人尝试密码( ``/var/log/secure`` )::

    Feb 28 05:14:18 ubuntu196 sshd[10555]: Failed password for root from 183.60.159.21 port 38818 ssh2
    Feb 28 05:14:18 ubuntu196 sshd[10557]: pam_unix(sshd:auth): authentication failure; 
    logname= uid=0 euid=0 tty=ssh ruser= rhost=183.60.159.21  user=root

* cron任务，没关系(/var/log/secure)::

    Feb 28 05:17:01 ubuntu196 CRON[10559]: pam_unix(cron:session): session opened for user root by (uid=0)
    Feb 28 05:17:01 ubuntu196 CRON[10559]: pam_unix(cron:session): session closed for user root



cpu负载查询
===================

* 负载一般是由cpu或io造成
* 每个CPU内核的当前活动进程数不大于3的话，那么系统的性能是良好的。如果每个CPU内核的任务数大于5，那么这台机器的性能有严重问题
* 查询负载命令::

    uptime
    top
    dstat(查看具体原因)
    iostat(查看io)



Linux Centos 查看CPU信息、机器型号等硬件信息
================================================

* 查看机器所有硬件信息::

    dmidecode |more
    dmesg |more

* 查看主板信息:

   lspci

* 查看网卡信息::

     ethtool eth0       # 不一定所有网卡都支持此命令
     ethtool -i eth1 加上 -i 参数查看网卡驱动

     dmesg | grep eth0 等看到网卡名字(厂家)等信息



* 查看CPU信息（型号）::

    # cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
    8 Intel(R) Xeon(R) CPU E5410 @ 2.33GHz
    (看到有8个逻辑CPU, 也知道了CPU型号)

    # cat /proc/cpuinfo | grep physical | uniq -c
    4 physical id : 0
    4 physical id : 1
    (说明实际上是两颗4核的CPU)
    # PS: 其实是可能有超线程HT技术，不一定是有4核，也可能是2核4线程

    # getconf LONG_BIT
    32
    (说明当前CPU运行在32bit模式下, 但不代表CPU不支持64bit)

    # cat /proc/cpuinfo | grep flags | grep ‘ lm ‘ | wc -l
    8
    (结果大于0, 说明支持64bit计算. lm指long mode, 支持lm则是64bit)

    再完整看cpu详细信息, 不过大部分我们都不关心而已.
    # dmidecode | grep ‘Processor Information’

    查看内存信息
    # cat /proc/meminfo

    # uname -a
    Linux euis1 2.6.9-55.ELsmp #1 SMP Fri Apr 20 17:03:35 EDT 2007 i686 i686 i386 GNU/Linux
    (查看当前操作系统内核信息)

    # cat /etc/issue | grep Linux
    Red Hat Enterprise Linux AS release 4 (Nahant Update 5)
    (查看当前操作系统发行版信息)

    查看机器型号
    # dmidecode | grep “Product Name”

    查看网卡信息
    # dmesg | grep -i eth




