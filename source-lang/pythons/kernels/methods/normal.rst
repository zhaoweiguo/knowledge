函数
####

.. sidebar:: 函数/方法

    .. contents::

基础
====

python函数::

    如果一个Python函数、类方法或属性的名字以两个下划线开始(但不是结束), 它是私有的
    类方法或者是私有 (只能在它们自已的类中使用) 或者是公有 (任何地方都可使用)

    def <funName>():    #定义
    ... ...

    <funName>() # 调用


实例1::

    def func(x):
        global y        #全局变量
        print 'x is', x #打印变量
        x = 2    #修改变量

    x = 50  #函数外修改
    func(x) #执行函数

    //——使用默认参数值::
    def say(message, times = 1):
        print message * times

    say('Hello')
    say('World', 5)

    //实例3——ifelse、return語句::
    def maximum(x, y):
        if x > y:
            return x
        else:
            return y
    print maximum(2, 3)

DocStrings(文档字符串, 它通常被简称为 ``docstrings``, DocStrings是一个重要的工具, 由于它帮助你的程序文档更加简单易懂, 你应该尽量使用它)::

    def printMax(x, y):
        '''Prints the maximum of two numbers.
        The two values must be integers.'''     # 文档字串
        x = int(x) # convert to integers, if possible
        y = int(y)

        if x > y:
            print x, 'is maximum'
        else:
            print y, 'is maximum'

        printMax(3, 5)
        print printMax.__doc__  #文档打印

参数
========

参数类型::

    位置参数
    默认参数
    可变参数
    命名关键字参数
    关键字参数

参数定义的顺序::

    位置参数、默认参数、可变参数和关键字参数。
    or
    位置参数、默认参数、命名关键字参数和关键字参数。


可变参数(\*args)-自动组装成元组::

    // 加了星号(*)的变量名会存放所有未命名的变量参数
    格式:
      def functionname(arg1, arg2=v, *args):

    实例:
    def printinfo(arg1, *args):
        print(arg1)
        for var in args:
            print(var)


    printinfo(10)  # 10
    printinfo(70, 60, 50)
    # 70
    # 60
    # 50

关键字参数(\*\*kw)-自动组装成字典::

    **kw - 关键字参数
    格式:
      def functionname(arg1, arg2=v, args, **kw):

    实例:
    def printinfo(arg1, *args, **kwargs):
        print(arg1)
        print(args)
        print(kwargs)

    printinfo(70, 60, 50)
    # 70
    # (60, 50)
    # {}

    printinfo(70, 60, 50, a=1, b=2)
    # 70
    # (60, 50)
    # {'a': 1, 'b': 2}


命名关键字参数(\*, nkw)::

    格式:
      def functionname(arg1, arg2=v, args, *, nkw, *kw):
    说明:
      *, nkw - 命名关键字参数，用户想要输入的关键字参数，定义方式是在nkw 前面加个分隔符 *
      如果要限制关键字参数的名字，就可以用「命名关键字参数」
      使用命名关键字参数时，要特别注意不能缺少参数名。

    实例:
    def printinfo(arg1, *, nkw, **kwargs):
        print(arg1)
        print(nkw)
        print(kwargs)

    printinfo(70, nkw=10, a=1, b=2)
    # 70
    # 10
    # {'a': 1, 'b': 2}

    printinfo(70, 10, a=1, b=2)
    # TypeError: printinfo() takes 1 positional argument but 2 were given
    原因:
        没有写参数名nwk，因此 10 被当成「位置参数」，
        而原函数只有 1 个位置函数，现在调用了 2 个，因此程序会报错


变量作用域
==========

全局变量global::

    关键字: global

    实例:
    num = 1
    def fun1():
        global num  # 需要使用 global 关键字声明
        print(num)  # 1
        num = 123
        print(num)  # 123
    fun1()
    print(num)  # 123

闭包::

    是函数式编程的一个重要的语法结构，是一种特殊的内嵌函数。
    如果在一个内部函数里对外层非全局作用域的变量进行引用，那么内部函数就被认为是闭包
    通过闭包可以访问外层非全局作用域的变量，这个作用域称为 闭包作用域
    闭包的返回值通常是函数。

    实例:
    def funX(x):
        def funY(y):
            return x * y

        return funY

    i = funX(8)
    print(type(i))  # <class 'function'>
    print(i(5))  # 40

全局变量nonlocal::

    如果要修改闭包作用域中的变量则需要 nonlocal 关键字

    def outer():
        num = 10

        def inner():
            nonlocal num  # nonlocal关键字声明
            num = 100
            print(num)

        inner()
        print(num)

    outer()

    # 100
    # 100


Lambda 表达式
=============

在 Python 里有两类函数::

    第一类：用 def 关键词定义的正规函数
    第二类：用 lambda 关键词定义的匿名函数

格式::

    lambda argument_list: expression

    说明:
      lambda - 定义匿名函数的关键词。
      argument_list - 函数参数
      expression - 只是一个表达式

.. note:: expression 中没有 return 语句，因为 lambda 不需要它来返回，表达式本身结果就是返回值。匿名函数拥有自己的命名空间，且不能访问自己参数列表之外或全局命名空间里的参数。



可以这样认为，lambda 作为一个表达式，定义了一个匿名函数，如::

    例:
    g = lambda x:x+1

    可看作:
    def g(x):
         return x+1

.. note:: 　　lambda 定义了一个匿名函数。lambda 并不会带来程序运行效率的提高，只会使代码更简洁。


全局函数方便使用的，filter, map, reduce::

    foo = [2, 18, 9, 22, 17, 24, 8, 12, 27]
    print(filter(lambda x: x % 3 == 0, foo))
    print(map(lambda x: x * 2 + 10, foo))
    print(reduce(lambda x, y: x + y, foo))

实例::

    def make_repeater(n):
        return lambda s: s*n

    twice = make_repeater(2)

    print(twice('word'))











