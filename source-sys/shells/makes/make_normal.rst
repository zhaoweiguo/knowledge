make常用命令
==================

Special Built-in Target Names::

    // 当执行make <cmd> 时,如找不到<cmd>就执行它
    .DEFAULT
    // 可以设定指定目标为伪目标
    .PHONY

    // 当前makefile内支持文件后缀的类型列表
    .SUFFIXES
    例:
    .SUFFIXES:             # 删除缺省的后缀列表
    .SUFFIXES: .cpp .obj   #把.cpp和.obj添加到后缀列表中



    // 导出所有的Makefile中的变量(即:有多少变量就执行多少次export xxxx)
    .EXPORT_ALL_VARIABLES

    @mkdir -p $@

各种=号的区别::

    = 是最基本的赋值
    := 是覆盖之前的值
    ?= 是如果没有被赋值过就赋予等号后面的值
    += 是添加等号后面的值

$说明::

    $@  表示目标文件
    $^  表示所有的依赖文件
    $<  表示第一个依赖文件
    $?  表示比目标还要新的依赖文件列表

    $% 仅当目标是函数库文件中，表示规则中的目标成员名。
    例如:
      如果一个目标是“foo.a(bar.o)”，那么，“$%”就是“bar.o”，“$@”就是“foo.a”。
      如果目标不是函数库文件（Unix下是[.a]，Windows下是[.lib]），那么，其值为空。

    $+ 这个变量很像“$^”，也是所有依赖目标的集合。只是它不去除重复的依赖目标。

    $* 这个变量表示目标模式中“%”及其之前的部分
    如果目标是“dir/a.foo.b”，并且目标的模式是“a.%.b”那么:“$*”的值就是“dir/a.foo”
    这个变量对于构造有关联的文件名是比较有较
    如果目标中没有模式的定义，那么“$*”也就不能被推导出，
    但是，如果目标文件的后缀是make所识别的，那么“$*”就是除了后缀的那一部分
    例如:
      如果目标是“foo.c”，因为“.c”是make所能识别的后缀名，所以，“$*”的值就是“foo”
      这个特性是GNU make的，很有可能不兼容于其它版本的make
      所以，你应该尽量避免使用“$*”，除非是在隐含规则或是静态模式中
      如果目标中的后缀是make所不能识别的，那么“$*”就是空值。

原始Makefile::

    main: main.o mytool1.o mytool2.o 
    gcc -o main main.o mytool1.o mytool2.o 
    main.o: main.c mytool1.h mytool2.h 
    gcc -c main.c 
    mytool1.o: mytool1.c mytool1.h 
    gcc -c mytool1.c 
    mytool2.o: mytool2.c mytool2.h 
    gcc -c mytool2.c

简化后::

    main：main.o mytool1.o mytool2.o 
    gcc -o $@ $^ 
    main.o：main.c mytool1.h mytool2.h 
    gcc -c $< 
    mytool1.o：mytool1.c mytool1.h 
    gcc -c $< 
    mytool2.o：mytool2.c mytool2.h 
    gcc -c $< 










