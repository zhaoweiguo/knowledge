性能相关
================



查看进程最可靠地方::

    /proc/<PID>/<file>
    如:
    // 查看进程的内存数据
    /proc/<PID>/statm
    611450 185001 883 18 0 593431 0

    1. size :- total program size (611450 X 4096/1024 = 2445800kB = 2388M)
    2. resident :- resident set size (185001 X 4096/1024 = 740004kB = 722M)
    3. share :- shared pages (883 X 4096 = 3532)
    4. trs :- text (code) (18 X 4096/1024 = 72kB = VmExe )
    5. drs :- data/stack
    6. lrs :- library (593431 X 4096/1024 = 2373724kB = VmData +VmStk)
    7. dt :- dirty pages


修改用户进程可打开文件数限制::

    /etc/pam.d指的是验证登陆配置, /etc/pam.d/login 是登陆配置文件,实例:

        //增加如下一行
        // 调用pam_limits.so模块来设置系统对该用户可使用的各种资源数量的最大限制(包括用户可打开的最大文件数限制)
        // 而pam_limits.so模块就会从/etc/security/limits.conf文件中读取配置来设置这些限制值
        session required /lib/security/pam_limits.so

    查看Linux系统级的最大打开文件数限制(Linux系统级硬限制):

        /proc/sys/fs/file-max

    文件句柄、进程限制:

        /etc/security/limit.conf
        %修改文件句柄
        *     soft    nofile  65535
        *     hard    nofile  65535
        *     soft    noproc  11111
        *     hard    noproc  11111
        %注: root用户的话可以用命令ulimit -n 65535
















