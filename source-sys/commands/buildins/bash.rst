bash命令
########

bash的命令语法是Bourne shell命令语法的超集。数量庞大的Bourne shell脚本大多不经修改即可以在bash中执行，只有那些引用了Bourne特殊变量或使用了Bourne的内置命令的脚本才需要修改。bash的命令语法很多来自Korn shell（ksh）和C shell（csh），例如命令行编辑，命令历史，目录栈，$RANDOM和$PPID变量，以及POSIX的命令置换语法：$(...)。作为一个交互式的shell，按下TAB键即可自动补全已部分输入的程序名，文件名，变量名等等。

使用'function'关键字时，Bash的函数声明与Bourne/Korn/POSIX脚本不兼容（Korn shell 有同样的问题）。不过Bash也接受Bourne/Korn/POSIX的函数声明语法。因为许多不同，Bash脚本很少能在Bourne或Korn解释器中运行，除非编写脚本时刻意保持兼容性。然而，随着Linux的普及，这种方式正变得越来越少。不过在POSIX模式下，Bash更加符合POSIX。

bash的语法对Bourne shell的不足的扩展
====================================

花括号扩展
----------
花括号扩展是一个从C shell借鉴而来的特性，它产生一系列指定的字符串（按照原先从左到右的顺序）。这些字符串不需要是已经存在的文件。

如::

    $ echo a{p,c,d,b}e
    ape ace ade abe
    $ echo {a,b,c}{d,e,f}
    ad ae af bd be bf cd ce cf

如::

    $ echo {1..10}
    1 2 3 4 5 6 7 8 9 10
    $ echo file{1..4}.txt
    file1.txt file2.txt file3.txt file4.txt


使用整数
--------

与Bourne shell不同的是bash不用另外生成进程即能进行整数运算。bash使用((...))命令和$[...]变量语法来达到这个目的::

    VAR=55             # 将整数55赋值给变量VAR
    ((VAR = VAR + 1))  # 变量VAR加1。注意这里没有'$'
    ((++VAR))          # 另一种方法给VAR加1。使用C语言风格的前缀自增
    ((VAR++))          # 另一种方法给VAR加1。使用C语言风格的后缀自增
    echo $((VAR * 22)) # VAR乘以22并将结果送入命令
    echo $[VAR * 22]   # 同上，但为过时用法

((...))命令可以用于条件语句，因为它的退出状态是0或者非0（大多数情况下是1），可以用于是与非的条件判断::

    if((VAR == Y * 3 + X * 2))
    then
         echo yes
    fi

    ((Z > 23)) && echo Yes


输入输出重定向
--------------

bash拥有传统Bourne shell缺乏的I/O重定向语法。bash可以同时重定向标准输出和标准错误，这需要使用下面的语法::

    $ command &> file
    // 等价的Bourne shell语法
    $ command > file 2>&1


进程内的正则表达式
------------------

bash 3.0支持进程内的正则表达式，使用下面的语法::

    $ [[ string =~ regex ]]

实例::

    if [[ abcfoobarbletch =~ 'foo(bar)bl(.*)' ]]
    then
         echo The regex matches!
         echo $BASH_REMATCH      -- outputs: foobarbletch
         echo ${BASH_REMATCH[1]} -- outputs: bar
         echo ${BASH_REMATCH[2]} -- outputs: etch
    fi


转义字符
--------

$'string' 形式的字符串会被特殊处理。字符串会被展开成string，并像C语言那样将反斜杠及紧跟的字符进行替换

关联数组
--------

Bash 4.0 开始支持关联数组，通过类似AWK的方式，对于多维数组提供了伪支持::

    $ declare -A a         # 声明一个名为a的伪二位数组
    $ i=1; j=2
    $ a[$i,$j]=5           # 将键 "$i,$j" 与值 5 对应
    $ echo ${a[$i,$j]}


移植性
------

调用Bash时指定 --posix 或者在脚本中声明 set -o posix ，可以使得Bash几乎遵循 POSIX 1003.2 标准。

键盘快捷键
----------

Bash默认使用emacs的快捷键，可以通过 set -o vi 让它使用Vi的快捷键


进程管理
--------

Bash有两种执行命令的模式：批处理模式、并发模式::

    1. 要以批处理模式执行命令（即按照顺序），必须用;分隔
    // 当command1执行完毕，即执行command2  
    $ command1 ; command2

    2. 要并发执行两个命令，它们必须用&分隔
    // 并发执行两个命令
    $ command1 & command2
    注: 在这种情况下，command1 在后台执行（通过&），从而立即将控制返回到shell，以执行command2

总结::

    一般命令在前台执行（fg），执行完毕后，控制返回给用户
    在命令后面加上&，它会在后台执行（bg）,并将特殊的环境变量「$!」设置为该任务的进程id。这时shell可以并发执行其他命令。
    按Ctrl+z可以挂起前台运行的程序
    注: 挂起的程序可以用fg恢复到前台，或者用bg恢复到后台
    后台程序试图写入数据到终端设备时（与写入标准输出不同）可能被阻塞
    
    shell可以:
    等待一个后台任务执行完成，只需使用wait命令，加上进程ID或者任务序号；
    也可以等待所有的后台任务，只需使用不加参数的wait

Bash启动脚本相关
================

相关文件::

    ~/.bash_profile
    ~/.bashrc
    ~/.bash_history
    ~/.bash_logout
    ~/.bash_login


可继承的环境变量
----------------

设置可继承的环境变量::

    这些环境变量可以被子进程继承
    ~/.bash_profile
    /etc/bash_profile

* Bourne shell登陆时使用 ~/.profile 来设置环境变量，这些环境变量可以被子进程继承
* Bash可以以兼容的方式使用Bourne shell的~/.profile::
    
    // 只需在Bash自有的脚本中显式执行下面这行代码
    . ~/.profile

别名和函数
----------

* 在Bash当中，~/.bashrc 是交互式子shell启动时执行的脚本
* rc的含义 [1]_ ::
    
    run command
    // 这是最开始的含义, 现在已经超越了run command

* 在登录式shell中使用 ~/.bashrc 定义的函数::

    // 可以在 ~/.bash_login 的环境变量后面加上这样一行
    . ~/.bashrc

登录与退出时执行的命令
----------------------

最初登录时，csh 执行::

    ~/.login
    // 可以执行一些只在登录时执行的操作，例如显示系统负载、硬盘状态、是否收到新邮件、在日志中记录登录时间，等等

Bourne shell 可以在 ~/.bash_profile 文件中手工模拟这种行为::

    可以在 ~/.bash_profile 文件的环境变量设置和函数定义的后面添加这样一行



参考
====

* bash命令: https://man.linuxde.net/bash

.. [1] https://unix.stackexchange.com/questions/3467/what-does-rc-in-bashrc-stand-for