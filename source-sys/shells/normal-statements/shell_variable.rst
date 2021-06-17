变量 [1]_
###########

Shell中变量的原形:${var}
------------------------

实例::

    [root@bogon sh]# aa='ajax'
    [root@bogon sh]# echo $aa
    ajax
    [root@bogon sh]# echo $aa_AA

    [root@bogon sh]# echo ${aa}_AA
    ajax_AA

批量修改一个目录里文件名::

    [root@bogon ~]# cat modify_suffix.sh
    #!/bin/bash
    dst_path=$1
    for file in `ls $dst_path`
    do
        if [ -d $1/$file ]
                 then echo `$0 $1/$file`
        elif [ -f $1/$file ]
                then    mv $1/$file $1/${file}._mod
        else
            echo $1/${file} is unknow file type
        fi
    done;
    ./modify_suffix.sh  ./f
    将 ./f 下的所有文件文件名添加了.mod

实例::

    $> file="modify_suffix.sh.tar.gz"
    $> echo "${file%%.*}"
    modify_suffix
    $> echo "${file%.*}"
    modify_suffix.sh.tar
    $> echo "${file#*.}"
    sh.tar.gz
    $> echo "${file##*.}"
    gz

$(cmd)
------

::

    [root@bogon t]# ls
    1.txt  2.txt
    [root@bogon t]# echo $(ls)
    1.txt 2.txt

说明::

    echo $(ls) 执行过程
    shell扫描一遍命令行,发现了$(cmd)结构,便将$(cmd)中的cmd执行一次,得到其标准输出,
    再将此输出放到原来命令 echo $(ls)中的 $(ls)位置，即替换了$(ls),再执行echo命令
    如下：
    echo $(ls)被替换成了echo 1.txt 2.txt
    这里要注意的是$(cmd)中的命令的错误输出是不会被替换的，替换的只是标准输出

实例::

    [root@bogon t]# var=$(cat 3.txt)
    cat: 3.txt: 没有那个文件或目录
    [root@bogon t]# echo $var

    $var显然是空的

一串的命令执行()和{}
--------------------

说明::

    ()和{}都是对一串的命令进行执行,但有所区别：
    相同点：
    ()和{}都是把一串的命令放在括号里面,并且命令之间用;号隔开
    不同点
    ()只是对一串命令重新开一个子shell进行执行,{}对一串命令在当前shell执行
    ()最后一个命令可以不用分号,{}最后一个命令要用分号
    ()里的第一个命令和左边括号不必有空格,{}的第一个命令和左括号之间必须要有一个空格
    ()和{}中括号里面的某个命令的重定向只影响该命令,但括号外的重定向则影响到括号里的所有命令

::

    $> var=test
    $> echo $var
    test
    $> (var=notest;echo $var)
    notest
    $> echo $var
    test
    $> { var=notest;echo $var;}
    notest
    $> echo $var
    notest

::

    $> { var1=test1;var2=test2;echo $var1>a;echo $var2;}
    test2
    $> cat a
    test1
    $> { var1=test1;var2=test2;echo $var1;echo $var2;}>a
    $> cat a
    test1
    test2
    脚本实例
    $> (
        echo "1"
        echo "2"
    ) | awk '{print NR,$0}'
    1 1
    2 2

4.几种特殊的替换结构
---------------------

${var:=string} ::

    说明: $var为空时, 把string赋值给了var
    $>  echo ${a:=bbc}
    bbc
    $>  echo $a
    bbc

${var:-string} ::

    // 若变量var为空或者未定义,则用在命令行中用string来替换${var:-string}
    // 否则变量var不为空时,则用变量var的值来替换${var:-string}
    

    说明: $var为空时, 是一种赋值默认值的常见做法
    $>  echo ${a:-bcc}
    bcc
    $>  echo $a

    $>  a=ajax
    $>  echo ${a:-bcc}
    ajax

${var:+string} ::

    // 与${var:-string}相反
    // 只有当var不是空的时候才替换成string,若var为空时则不替换或者说是替换成变量var的值,即空值

${var:?string} ::

    // 若变量var不为空,则用变量var的值来替换${var:?string}
    // 若变量var为空,则把string输出到标准错误中,并从脚本中退出。
    // 可利用此特性来检查是否设置了变量的值

    $> echo ${a:?bbc}
    -bash: a: bbc
    $> a=ajax
    $> echo ${a:?bbc}
    ajax
    $> a=ajax
    $> echo ${a:-`date`}
    ajax
    $> unset a
    $> echo ${a:-`date`}
    2017年 02月 21日 星期二 10:13:46 CST
    $> echo ${a:-$(date)}
    2017年 02月 21日 星期二 10:13:59 CST
    $> b=bbc
    $> echo ${a:-$b}
    bbc

$((exp)) POSIX标准的扩展计算::

    // 这种计算是符合C语言的运算符,也就是说只要符合C的运算符都可用在$((exp)),包括三目运算符
    // 注意:这种扩展计算是整数型的计算,不支持浮点型和字符串等
    // 若是逻辑判断,表达式exp为真则为1,假则为0

    $> echo $(3+2)
    -bash: 3+2: 未找到命令

    $> echo $((3+2))
    5
    $> echo $((3.5+2))
    -bash: 3.5+2: 语法错误: 无效的算术运算符 （错误符号是 ".5+2"）
    $> echo $((3>2))
    1
    $> echo $((3>2?'a':'b'))
    -bash: 3>2?'a':'b': 语法错误: 期待操作数 （错误符号是 "'a':'b'"）
    $> echo $((3>2?a:b))
    a
    $> echo $((a=3+2))
    5
    $> echo $((a++))
    5
    $> echo $a
    6
    $> echo $((++a))
    7
    $> echo $a
    7

四种模式匹配替换结构::

    ${var%pattern}
    ${var%%pattern}
    ${var#pattern}
    ${var##pattern}

    ${var%pattern},${var%%pattern} 从右边开始匹配
    ${var#pattern},${var##pattern} 从左边开始匹配
    ${var%pattern} ,${var#pattern} 表示最短匹配,匹配到就停止,非贪婪
    ${var%%pattern},${var##pattern} 是最长匹配

    * 表示零个或多个任意字符
    ?表示零个或一个任意字符
    [...]表示匹配中括号里面的字符
    [!...]表示不匹配中括号里面的字符

    实例:
    说明: 输出的内容是var去掉pattern的那部分字符串的值
    $> f=a.tar.gz
    $> echo ${f##*.}
    gz
    $> echo ${f%%.*}
    a
    $> var=abcdccbbdaa
    $> echo ${var%%d*}
    abc
    $> echo ${var%d*}
    abcdccbb
    $> echo ${var#*d}
    ccbbdaa
    $> echo ${var##*d}
    aa




.. [1] https://www.cnblogs.com/HKUI/p/6423918.html