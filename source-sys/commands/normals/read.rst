read命令
##############

简介::

    要与Linux交互，脚本获取键盘输入的结果是必不可少的，read可以读取键盘输入的字符。
    shell作为一门语言，自然也具有读数据的功能，read就是按行从文件(或标准输入或给定文件描述符)中读取数据的最佳选择。
    当使用管道、重定向方式组合命令时感觉达不到自己的需求时，不妨考虑下while read line。

格式::

    read [-rs] [-a ARRAY] [-d delim] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [var_name1 var_name2 ...]

.. note::

    read命令用于从标准输入中读取输入单行，并将读取的单行根据IFS变量分裂成多个字段，并将分割后的字段分别赋值给指定的变量列表var_name。第一个字段分配给第一个变量var_name1，第二个字段分配给第二个变量var_name2，依次到结束。如果指定的变量名少于字段数量，则多出的字段数量也同样分配给最后一个var_name，如果指定的变量命令多于字段数量，则多出的变量赋值为空。

    如果没有指定任何var_name，则分割后的所有字段都存储在特定变量REPLY中。

选项说明::

    -a：将分裂后的字段依次存储到指定的数组中，存储的起始位置从数组的index=0开始。
    -d：指定读取行的结束符号。默认结束符号为换行符。
    -n：限制读取N个字符就自动结束读取，如果没有读满N个字符就按下回车或遇到换行符，则也会结束读取。
    -N：严格要求读满N个字符才自动结束读取，即使中途按下了回车或遇到了换行符也不结束。其中换行符或回车算一个字符。
    -p：给出提示符。默认不支持"\n"换行，要换行需要特殊处理，见下文示例。例如，"-p 请输入密码："
    -r：禁止反斜线的转义功能。这意味着"\"会变成文本的一部分。
    -s：静默模式。输入的内容不会回显在屏幕上。
    -t：给出超时时间，在达到超时时间时，read退出并返回错误。也就是说不会读取任何内容，即使已经输入了一部分。
    -u：从给定文件描述符(fd=N)中读取数据。

基本用法示例 [1]_
=================

(1).将读取的内容分配给数组变量，从索引号0开始分配::

    $> read -a array_test
    what is you name?

    $> echo ${array_test[@]}
    what is you name?

    $> echo ${array_test[0]}
    what

(2).指定读取行的结束符号，而不再使用换行符::

    $> read -d '/'
    what is you name \//       # 输入完尾部的"/"，自动结束read
    # 由于没有指定var_name，所以通过$REPLY变量查看read读取的行
    $> echo $REPLY
    what is you name /

(3).限制输入字符::

    // 输入了5个字符后就结束。
    $> # read -n 5
    12345

    $> # echo $REPLY   # 输入12345共5个字符
    12345

    // 如果输入的字符数小于5，按下回车会立即结束读取
    $> read -n 5
    123
    $> echo $REPLY
    123

    //但如果使用的是"-N 5"而不是"-n 5"，则严格限制读满5个字符才结束读取。
    $> read -N 5
    123\n4
    $> read -N 5
    123          # 3后的回车(换行)算是一个字符
    4

(4).使用-p选项给出输入提示::

    $> read -p "pls enter you name: "
    pls enter you name: Junmajinlong

    $> echo $REPLY
    Junmajinlong

    "-p"选项默认不带换行功能，且也不支持"\n"换行。但通过$'string'的方式特殊处理，就可以实现换行的功能。例如:
    $> read -p $'Enter your name: \n'
    Enter your name:
    JunMaJinLong
    关于$'String'和$"String"的作用，见http://www.cnblogs.com/f-ck-need-u/p/8454364.html

(5).禁止反斜线转义功能::

    $> read -r
    what is you name \?

    $> echo $REPLY
    what is you name \?

(6).不回显输入的字符。比如输入密码的时候，不回显输入密码::

    $> read -s -p "please enter your password: "
    please enter your password:

    $> echo $REPLY
    123456

(7).将读取的行分割后赋值给变量::

    $> read var1 var2 var3
    abc def    galsl djks

    $> echo $var1:::$var2:::$var3
    abc:::def:::galsl djks

(8).给出输入时间限制。没完成的输入将被丢弃，所以变量将赋值为空::

    // 如果在执行read前，变量已被赋值，则此变量在read超时后将被覆盖为空
    $> var=5
    $> read -t 3 var
    1
    $> echo $var


1.3 while read line
-------------------

示例数据::

    $> cat test1
    a
    b
    c
    d

用法示例1::

    // 强烈建议，不要在管道后面使用while read line
    // 因为管道会开启子shell，使得while中的命令都在子shell中执行
    // 而且，cat test1会一次性将test1文件所有数据装入内存，如果test1文件足够大，会直接占用巨量内存
    $> cat test1 | while read line;do echo $line;done
    a
    b
    c
    d

用法示例2::

    // 本示例使用输入重定向的方式则每次只占用一行数据的内存，而且是在当前shell环境下执行的
    // while内的变量赋值、数组赋值在退出while后仍然有效
    $> while read line;do echo $line;done <test1
    a
    b
    c
    d

用法示例3::

    // 不要使用示例3，因为它会在每次循环的时候都重新打开test1文件
    // 使得每次都从头开始读数据，而不是每次从上一次标记的地方继续读数据
    $> while read line <test1;do echo $line;done




.. [1] https://www.cnblogs.com/f-ck-need-u/p/7402149.html