lsof命令
########

说明::

    lsof是系统管理/安全的尤伯工具。
    将这个工具称之为lsof真实名副其实，因为它是指“列出打开文件（lists openfiles）”
    而有一点要切记，在Unix中一切（包括网络套接口）都是文件

    lsof也是有着最多开关的Linux/Unix命令之一。
    它有许多选项支持使用-和+前缀

* 官网: http://people.freebsd.org/~abe/

关键选项
========

当你给它传递选项时，默认行为是对结果进行“或”运算::

    因此，如果你正是用-i来拉出一个端口列表，同时又用-p来拉出一个进程列表，
    那么默认情况下你会获得两者的结果。

下面的一些其它东西需要牢记::

    默认 : 没有选项，lsof列出活跃进程的所有打开文件
    组合 : 可以将选项组合到一起，如-abc，但要当心哪些选项需要参数
    -a : 结果进行“与”运算（而不是“或”）
    -l : 在输出显示用户ID而不是用户名
    -h : 获得帮助
    -t : 仅获取进程ID
    -U : 获取UNIX套接口地址
    -F : 格式化输出结果，用于其它命令。可以通过多种方式格式化，如-F pcfn（用于进程id、命令名、文件描述符、文件名，并以空终止）

lsof各列信息::

    COMMAND：进程的名称
    PID：进程标识符
    PPID：父进程标识符（需要指定-R参数）
    USER：进程所有者
    PGID：进程所属组
    FD：文件描述符，应用程序通过文件描述符识别该文件。如cwd、txt等:
    TYPE：文件类型，如DIR、REG等，常见的文件类型:
    DEVICE：指定磁盘的名称
    SIZE：文件的大小
    NODE：索引节点（文件在磁盘上的标识）
    NAME：打开文件的确切名称

获取网络信息
============

使用-i显示所有连接::

    语法: lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
    -i<条件> 列出符合条件的进程。（4、6、协议、:端口、 @ip)

实例::

    $ lsof  -i
    COMMAND  PID USER   FD   TYPE DEVICE SIZE NODE NAME
    dhcpcd 6061 root 4u  IPv4  4510 UDP *:bootpc
    sshd  7703 root 3u  IPv6  6499 TCP *:ssh  (LISTEN)
    sshd  7892 root 3u  IPv6  6757 TCP 10.10.1.5:ssh->192.168.1.5:49901  (ESTABLISHED)


使用-i 6仅获取IPv6流量::

    $ lsof  -i 6

仅显示TCP连接::

    $ lsof  -i TCP
    COMMAND  PID USER   FD   TYPE DEVICE SIZE NODE NAME
    sshd  7703 root 3u  IPv6  6499 TCP *:ssh  (LISTEN)
    sshd  7892 root 3u  IPv6  6757 TCP 10.10.1.5:ssh->192.168.1.5:49901  (ESTABLISHED)

使用-i:port来显示与指定端口相关的网络信息::

    $ lsof  -i :22
    $ lsof -i :smtp
    $ lsof -i udp:53

    //使用@host来显示指定到指定主机的连接
    $ lsof  -i@172.16.12.5

    //使用@host:port显示基于主机与端口的连接:
    $ lsof  -i@172.16.12.5:22

找出指定类型端口::

    // 监听端口
    $ lsof  -i -sTCP:LISTEN
    or
    $ lsof  -i |  grep  -i LISTEN

    // 已建立的连接:
    $ lsof  -i -sTCP:ESTABLISHED
    or
    $ lsof  -i |  grep  -i ESTABLISHED

用户信息
========

* 你也可以获取各种用户的信息，以及它们在系统上正干着的事情，包括它们的网络活动、对文件的操作等。

使用-u显示指定用户打开了什么::


    $ lsof  -u gordon
    -- snipped --
    Dock  155 gordon  txt REG 14,2  2798436  823208  /usr/lib/libicucore.A.dylib
    Dock  155 gordon  txt REG 14,2  1580212  823126  /usr/lib/libobjc.A.dylib
    Dock  155 gordon  txt REG 14,2  2934184  823498  /usr/lib/libstdc++.6.0.4.dylib
    Dock  155 gordon  txt REG 14,2  132008  823505  /usr/lib/libgcc_s.1.dylib
    Dock  155 gordon  txt REG 14,2  212160  823214  /usr/lib/libauto.dylib
    -- snipped --

使用-u user来显示除指定用户以外的其它所有用户所做的事情::

    $ lsof  -u ^daniel
    $ lsof -g gid 显示归属 gid 的进程情况


杀死指定用户所做的一切事情::

    $ kill  -9  `lsof -t -u daniel`

命令和进程
==========

* 可以查看指定程序或进程由什么启动，这通常会很有用，而你可以使用lsof通过名称或进程ID过滤来完成这个任务。

使用-c查看指定的命令正在使用的文件和网络连接::


    $ lsof  -c syslog-ng
    COMMAND    PID USER   FD   TYPE     DEVICE    SIZE       NODE NAME
    syslog-ng 7547 root  cwd    DIR 3,3  4096  2  /
    syslog-ng 7547 root  rtd    DIR 3,3  4096  2  /
    syslog-ng 7547 root  txt    REG 3,3  113524  1064970  /usr/sbin/syslog-ng
    -- snipped --

使用-p查看指定进程ID已打开的内容::

    $ lsof  -p 10075

-t选项只返回PID::

    $ lsof  -t -c Mail

文件和目录
==========

* 通过查看指定文件或目录，你可以看到系统上所有正与其交互的资源——包括用户、进程等。

显示与指定目录交互的所有一切::

    $ lsof  /var/log/messages/
    COMMAND    PID USER   FD   TYPE DEVICE   SIZE   NODE NAME
    syslog-ng 7547 root 4w REG 3,3  217309  834024  /var/log/messages

显示与指定文件交互的所有一切::

    $ lsof  /home/daniel/firewall_whitelist.txt

递归::

    $ lsof +d /DIR/ 显示目录下被进程打开的文件
        没有「+d选项」的话，似乎就不列出当前路径下被打印的文件了

    $ lsof +D /DIR/ 同上，但是会搜索目录下的所有目录，时间相对较长

    $ lsof -d FD 显示指定文件描述符的进程

    实例:
    // 递归查找某个目录中所有打开的文件
    lsof +D /usr/lib

    // 递归查找某个目录中所有打开的文件
    lsof +D /usr/lib
    lsof | grep '/usr/lib'     // 这个反应快



高级用法
========

* 与tcpdump类似，当你开始组合查询时，它就显示了它强大的功能。

显示daniel连接到1.1.1.1所做的一切::

    $ lsof  -u daniel -i @1.1.1.1

同时使用-t和-c选项以给进程发送 HUP 信号::

    $ kill  -HUP `lsof -t -c sshd`

lsof +L1显示所有打开的链接数小于1的文件::

    $ lsof  +L1

显示某个端口范围的打开的连接::

    $ lsof  -i @fw.google.com:2150=2180

实操
====

恢复被删除的文件
----------------

原理::

    当进程打开了某个文件时，只要该进程保持打开该文件，即使将其删除，它依然存在于磁盘中。
    当文件删除时，进程并不知道文件已经被删除，它仍然可以向打开该文件时提供给它的文件描述符进行读取和写入。
    除了该进程之外，这个文件是不可见的，因为已经删除了其相应的目录索引节点。

    在/proc 目录下，其中包含了反映内核和进程树的各种文件。
    /proc目录挂载的是在内存中所映射的一块区域，所以这些文件和目录并不存在于磁盘中，
    因此当我们对这些文件进行读取和写入时，实际上是在从内存中获取相关信息。

    大多数与 lsof 相关的信息都存储于以进程的 PID 命名的目录中，即 /proc/1234 中包含的是 PID 为 1234 的进程的信息。
    每个进程目录中存在着各种文件，它们可以使得应用程序简单地了解进程的内存空间、文件描述符列表、
        指向磁盘上的文件的符号链接和其他系统信息。
    lsof 程序使用该信息和其他关于内核内部状态的信息来产生其输出。
    所以lsof 可以显示进程的文件描述符和相关的文件名等信息。

    也就是我们通过访问进程的文件描述符可以找到该文件的相关信息。
    当系统中的某个文件被意外地删除了，只要这个时候系统中还有进程正在访问该文件，
        那么我们就可以通过 lsof 从 /proc 目录下恢复该文件的内容。

实例::
    
    恢复一个被删除的文件 test_recover

初始状态::

    $ ls 
    test_recover test_recover2 
    $ less test_recover 
    goodfile 
    it is very good!! 
    it is used to test how to recover a deleted file with lsof.

删除文件 test_recover::

    $ rm test_recover 
    说明: 我们已经将文件删除，但是由于 less 还在运行，所以这个文件虽然我们看不见了
      但是 less 不知道它删除了， less 还是可以对文件进行读写的，也就是说这个文件的数据实际还存在于磁盘上

查看删除的文件的信息::

    $ lsof |grep test_recover 
    less 22197 quietheart 4r REG  8,8  87  1837925 /home/quietheart/test/lsof_test/test_recover (deleted)
    说明: 通过 lsof 我们可以看到被删除的文件的信息

根据删除文件的信息恢复删除的文件::

    $ cd /proc/22197/fd
    $ ls 
    0  1  2  3  4 
    $ cat 4 
    goodfile 
    it is very good!! 
    it is used to test how to recover a deleted file with lsof. 



列说明
======

FD列说明::

    1. cwd：表示current work dirctory，即：应用程序的当前工作目录，这是该应用程序启动的目录，除非它本身对这个目录进行更改
    2. txt ：该类型的文件是程序代码，如应用程序二进制文件本身或共享库，如上列表中显示的 /sbin/init 程序
    3. lnn：library references (AIX);
    4. er：FD information error (see NAME column);
    5. jld：jail directory (FreeBSD);
    6. ltx：shared library text (code and data);
    7. mxx ：hex memory-mapped type number xx.
    8. m86：DOS Merge mapped file;
    9. mem：memory-mapped file;
    10. mmap：memory-mapped device;
    11. pd：parent directory;
    12. rtd：root directory;
    13. tr：kernel trace file (OpenBSD);
    14. v86  VP/ix mapped file;
    15. 0：表示标准输出
    16. 1：表示标准输入
    17. 2：表示标准错误
  一般在标准输出、标准错误、标准输入后还跟着文件状态模式：r、w、u等
    1. u：表示该文件被打开并处于读取/写入模式
    2. r：表示该文件被打开并处于只读模式
    3. w：表示该文件被打开并处于
    4. 空格：表示该文件的状态模式为unknow，且没有锁定
    5. -：表示该文件的状态模式为unknow，且被锁定
  同时在文件状态模式后面，还跟着相关的锁
    1. N：for a Solaris NFS lock of unknown type;
    2. r：for read lock on part of the file;
    3. R：for a read lock on the entire file;
    4. w：for a write lock on part of the file;（文件的部分写锁）
    5. W：for a write lock on the entire file;（整个文件的写锁）
    6. u：for a read and write lock of any length;
    7. U：for a lock of unknown type;
    8. x：for an SCO OpenServer Xenix lock on part      of the file;
    9. X：for an SCO OpenServer Xenix lock on the      entire file;
    10. space：if there is no lock.


TYPE列说明::

  （1）DIR：表示目录
  （2）CHR：表示字符类型
  （3）BLK：块设备类型
  （4）UNIX： UNIX 域套接字
  （5）FIFO：先进先出 (FIFO) 队列
  （6）IPv4：网际协议 (IP) 套接字




  
参考
====

* https://www.jianshu.com/p/a3aa6b01b2e1
* lsof手册页在线版本: http://www.netadmintools.com/html/lsof.man.html
* https://zhuanlan.zhihu.com/p/109244512



