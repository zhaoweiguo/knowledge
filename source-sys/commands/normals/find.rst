.. _find:

find命令使用
############

::

    find [路径] <表达式>

* 查找文件::

      -name <表达式> 根据文件名查找文件
      -perm mode,[-mode],[/mode],[+mode]
      -printf <format>
      -iname <表达式> 根据文件名查找文件,忽略大小写
      -path <表达式> 根据路径查找文件
      -ipath <表达式> 根据路径查找文件,忽略大小写
      -amin <分钟> 过去 N 分钟内访问过的文件
      -atime <天数> 过去 N 天内访问过的文件
      -cmin <分钟> 过去 N 分钟内修改过的文件
      -ctime <天数> 过去 N 天内修改过的文件
      -anewer <参照文件> 比参照文件更晚被读取过的文件
      -cnewer <参照文件> 比参照文件更晚被修改过的文件
      -size <大小> 根据文件大小查找文件,单位 b c w k M G
      -type <文件类型> 根据文件类型查找文件。b 块设备 c 字符设备 d 目录 p 管道文件 f 普通文件 l 链接 s 端口文件
      -user <用户名> 按归属用户查找文件
      -uid <uid> 按 UID 查找文件
      -group <群组名> 按归属群组查找文件
      -gid <gid> 按 GID 查找文件
      -empty 查找空文件



示例
====

1. 基本查找
-----------

忽略大小写查找::

    $ find . -iname text

找到指定文件(过滤文件夹)::

    $ find . -name abc -type f


2. 根据他们的权限查找
---------------------

基本命令::

    find . -perm 664
    find . -perm -664

查找没有 777 权限的文件::

    $ find . -type f ! -perm 777

三种特殊权限—suid、 sgid 和粘滞位 (sticky)::

    查找具有 644 个权限的 SGID 文件:
    find . -type f -perm 2664

    找到具有 551 权限的粘滞位文件:
    find . -perm 1551

按rwx查找::

    //找可被ower和group写的
    find . -perm -220
    find . -perm -g+w,u+w

    查找所有可读文件:
    find . -perm -u=r
    查找所有可执行文件:
    find . -perm -u=x

空文件/目录::

    查找所有空文件:
    find . -type f -empty

    查找所有空目录:
    find . -type d -empty

    所有隐藏文件:
    find . -type f -name ".*"



其他::

    1. 注: linux下还可以用/代替-
    find . -perm /220
    find . -perm /u+w,g+w
    find . -perm /u=w,g=w



3. 基于所有者和组查找
---------------------

用户::

    在所有者 root 的 /root 目录下查找名为 test.c 的所有文件:
    find / -user root -name test.c

    查找~目录下属于用户 gordon 的所有文件:
    find ~ -user gordon 

组::

    查找 /home 目录下属于 Group Developer 的所有文件:
    find /home -group developer


4. 根据日期和时间查找
---------------------

按天查修改的文件::

    查找最近 50 天修改的文件:
    $ find . -mtime -50

    查找最近 50-100 天修改的文件:
    $ find . -mtime +50 -mtime -100

按天查访问的文件::

    查找最近 50 天访问的文件:
    $ find . -atime 50

按小时查文件::

    过去 1 小时内查找更改的文件:
    $ find . -cmin -60

    最近 1 小时内查找修改的文件:
    $ find . -mmin -60

    最近 1 小时内访问的文件
    $ find . -amin -60


5. 根据大小查找
===============

找到 50MB 的文件::

    $ find . -size 50M

查找大小在 50MB 到 100MB 之间::

    $ find . -size +50M -size -100M


详细选项
========

说明::

    a   The access time of the file reference
    B   The birth time of the file reference
    c   The inode status change time of reference
    m   The modification time of the file reference
    t   reference is interpreted directly as a time
    使用实例:
    mmin, amin, cmin
    mtime, atime, ctime


    UID 是 Set User ID
    SGID 是 Set Group ID


-type 选项::

    b      block (buffered) special
    c      character (unbuffered) special
    d      directory
    p      named pipe (FIFO)
    f      regular file
    l      symbolic link; 
    s      socket
    D      door (Solaris)



::

    9 8 7 6 5 4 3 2 1 0
    - r w x r - x r - x

第 9 位表示文件类型::

    p: 表示命名管道文件
    d: 表示目录文件
    l: 表示符号连接文件
    -: 表示普通文件
    s: 表示 socket 文件
    c: 表示字符设备文件
    b: 表示块设备文件

第 8-6 位、5-3 位、2-0 位分别表示文件所有者的权限，同组用户的权限，其他用户的权限，其形式为 rwx::

    r 表示可读
    w 表示可写
    x 表示可执行
    - 表示没有权限

SUID 与 SGID
============

SUID 与 SGID::

    1. -rwsr-xr-x 表示 SUID 和所有者权限中可执行位(即x)被设置
    2. -rwSr--r-- 表示 SUID 被设置，但所有者权限中可执行位(即x)没有被设置
    3. -rwxr-sr-x 表示 SGID 和同组用户权限中可执行位(即x)被设置
    4. -rw-r-Sr-- 表示 SGID 被设置，但同组用户权限中可执行位(即x)没有被设置

    ps: UNIX 的实现中，文件权限用 12 个二进制位表示
    11 10 9 8 7 6 5 4 3 2 1 0
    S  G  T r w x r w x r w x

    第 11 位为 SUID 位，第 10 位为 SGID 位，第 9 位为 sticky 位，第 8-0 位对应于上面的三组 rwx 位
    例如:
    上面的 -rwsr-xr-x 的值为：
    1 0 0   1 1 1  1 0 1  1 0 1

    -rw-r-Sr-- 的值为：
    0 1 0   1 1 0  1 0 0  1 0 0

    给文件加 SUID 和 SUID 的命令如下:
    chmod u+s filename 设置 SUID 位
    chmod u-s filename 去掉 SUID 设置
    chmod g+s filename 设置 SGID 位
    chmod g-s filename 去掉 SGID 设置


OPERATORS
=========

使用::

    1. ( expression )

    2. ! expression
     -not expression

    3. -false  Always false.
    4. -true   Always true.

    5. expression -and expression
      expression -a expression
      expression expression

    6. expression -or expression
      expression -o expression

实例::

    find / -type f \( -perm -4000 -o -perm -2000 \)  –print




其他
====


* 实例::

    // 找出当前目录下普通文件列表
    find . -type f
    // 找出当前目录下文件夹列表
    find . -type d

    //使用正则
    find . -name "[a-z]*"    //找出以a-z开头的文件

    //可以通过下述指令查找硬链接
    find / -xdev -samefile /etc/resolv.conf

    // 指定路径为1的文件夹列表(即当前目录下文件夹列表,不包含.和..)
    find . -mindepth 1 -maxdepth 1 -type d



常见问题1::

  find: paths must precede expression: webfd
  Usage: find [-H] [-L] [-P] [-Olevel] [-D help|tree|search|stat|rates|opt|exec] [path...] [expression]

  // 原因
  即出现这个提示是因为星号代表为当前目录下所有的文件，然后被当做shell展开
  这就是网上说的多文件的查找的时候需要增加单引号
  This happens because *.c has been expanded by the shell resulting in find 

  // 解决方法
  $ find . -name '*.c' -print
  或
  $ find . -name \*.c -print


排除功能::

  % 在当前目录中，排除子目录source/ 和 blog/ ，查找所有的rst文件
  % -prune -o: 总计算为true,只展示此目录,不往此目录下继续执行
  find . -path "./blog" -prune -o -path "./source" -prune -o -name *.rst

  % 查找文件名为非*.c的文件
  find . ! -name "*.c" 

  % 
  find . -not -path  '*.svn*' -print  
  or
  find .  ! -path  '*.svn*' -print 


过滤::

    // 过滤指定文件夹
    files=( $(find . -name '*.go' -not -path './vendor/*') )
    
    // 过滤多个文件夹
    find . -name '*.go' -not -path  './cli/*' -not -path  './internal/*'



实践
====

找出当前目录下更改时间在5日以前的文件并删除它们::

    find . -type f -mtime +5 -exec rm {} \;









