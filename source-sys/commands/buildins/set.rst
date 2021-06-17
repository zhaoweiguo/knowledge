set命令
############

功能说明::

    set指令能设置所使用shell的执行方式，可依照不同的需求来做设置

语法::

    set [+-abCdefhHklmnpPtuvx]
    set [--abefhkmnptuvxBCHP] [-o option] [arg ...]

参数说明::

    -a 　标示已修改的变量，以供输出至环境变量。
    -b 　使被中止的后台程序立刻回报执行状态。
    -C 　转向所产生的文件无法覆盖已存在的文件。
    -d 　Shell预设会用杂凑表记忆使用过的指令，以加速指令的执行。使用-d参数可取消。
    -e 　若指令传回值不等于0，则立即退出shell。
    -f　 　取消使用通配符。
    -h 　自动记录函数的所在位置。
    -H Shell 　可利用"!"加<指令编号>的方式来执行history中记录的指令。
    -k 　指令所给的参数都会被视为此指令的环境变量。
    -l 　记录for循环的变量名称。
    -m 　使用监视模式。
    -n 　只读取指令，而不实际执行。
    -p 　启动优先顺序模式。
    -P 　启动-P参数后，执行指令时，会以实际的文件或目录来取代符号连接。
    -t 　执行完随后的指令，即退出shell。
    -u 　当执行时使用到未定义过的变量，则显示错误信息。
    -v 　显示shell所读取的输入值。
    -x 　执行指令后，会先显示该指令及所下的参数。
    
    +<参数> 　取消某个set曾启动的参数(如set +u就是取消set -u的作用)

实例
========

显示环境变量::

    $> set
    BASH=/bin/bash
    BASH_ARGC=()
    BASH_ARGV=()
    BASH_LINENO=()
    BASH_SOURCE=()
    ... ...

set -o pipefail::

    对于set命令-o参数的pipefail选项，linux是这样解释的：
    "If set, the return value of a pipeline is the value of 
        the last (rightmost) command to exit with a non-zero status,
    or zero if all commands in the pipeline exit successfully. This option is disabled by default."

    设置了这个选项以后，包含管道命令的语句的返回值，会变成最后一个返回非零的管道命令的返回值

    # test.sh
    set -o pipefail
    ls ./a.txt |echo "hi" >/dev/null
    echo $?

    运行test.sh，因为当前目录并不存在a.txt文件，输出：
    ls: ./a.txt: No such file or directory
    1 #设置了set -o pipefail，返回从右往左第一个非零返回值，即ls的返回值1

    注释掉set -o pipefail这一行，再次运行，输出：
    ls: ./a.txt: No such file or directory
    0 # 没有set -o pipefail，默认返回最后一个管道命令的返回值

set -o errexit::

    等同于 set -e
    set命令的-e参数，linux自带的说明如下：
    "Exit immediately if a simple command exits with a non-zero status."
    也就是说，在"set -e"之后出现的代码，一旦出现了返回值非零，整个脚本就会立即退出

set -o nounset::

    等同于 set -u
    // 当使用未定义的变量时，输出错误信息并强制退出

set -o xtrace::

    等同于 set -x
    执行echo bar之前，该命令会先打印出来，行首以+表示。这对于调试复杂的脚本是很有用的


上面4个命令常写在一块::

    # 写法一
    set -euxo pipefail

    # 写法二
    set -eux
    set -o pipefail

    # 写法三
    $ bash -euxo pipefail script.sh



代码
==========

* `pipefail实例 <https://github.com/zhaoweiguo/demo_linux/blob/master/shell/set/pipefail.sh>`_










