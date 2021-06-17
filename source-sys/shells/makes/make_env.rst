环境变量
###############

MAKECMDGOALS [1]_ ::

    存放你所指定的终极目标的列表
    如:
    make clean   # MAKECMDGOALS就是clean
    # 你没有指定目标，那么，这个变量是空值

    这个变量可以让你使用在一些比较特殊的情形下:
    sources = foo.c bar.c  
    ifneq ( $(MAKECMDGOALS),clean)  
    include $(sources:.c=.d)  
    endif
    # 只要我们输入的命令不是“make clean”，那么 makefile 会自动包含“foo.d”和“bar.d”这两个 makefile


BASH_SOURCE [2]_
::
    
    // BASH_SOURCE[0] 等价于 BASH_SOURCE, 取得当前执行的shell文件所在的路径及文件名
    // 实例:
    $> cat /home/abc/test.sh
    #!/bin/sh
    echo "${BASH_SOURCE[0]}"
    echo "${BASH_SOURCE]}"
    echo "$( dirname "${BASH_SOURCE[0]}" )"
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    echo $DIR

    $> cd /home
    $> source ./abc/test.sh
    ./abc/test.sh
    ./abc/test.sh
    ./abc/
    /home/abc







.. [1] https://blog.csdn.net/eddy_liu/article/details/8217835
.. [2] https://blog.csdn.net/zhaozhencn/article/details/21103367