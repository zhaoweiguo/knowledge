魔法方法
########

.. sidebar:: Contents
    
    .. contents::


定义::

    魔法方法总是被双下划线包围，例如__init__
    魔法方法的第一个参数应为cls（类方法） 或者self（实例方法）
        cls：代表一个类的名称
        self：代表一个实例对象的名称


基本魔法方法
==============

__init__(self[, ...])::

    构造器，当一个实例被创建的时候调用的初始化方法

__new__(cls[, ...])::

    在一个对象实例化的时候所调用的第一个方法
    在调用__init__初始化前，先调用__new__

.. note:: __new__() 是一种负责创建类实例的静态方法，它无需使用 staticmethod 装饰器修饰，且该方法会优先 __init__() 初始化方法被调用。


实例::

    class A(object):
        def __init__(self, value):
            print("into A __init__")
            self.value = value

        def __new__(cls, *args, **kwargs):
            print("into A __new__")
            print(cls)
            return object.__new__(cls)


    class B(A):
        def __init__(self, value):
            print("into B __init__")
            self.value = value

        def __new__(cls, *args, **kwargs):
            print("into B __new__")
            print(cls)
            return super().__new__(cls, *args, **kwargs)


    b = B(10)

    # 结果：
    # into B __new__
    # <class '__main__.B'>
    # into A __new__
    # <class '__main__.B'>
    # into B __init__

利用__new__实现单例模式::

    # 1. 普通方案
    class Earth:
        pass

    a = Earth()
    print(id(a))  # 260728291456
    b = Earth()
    print(id(b))  # 260728291624


    # 2. 单例方案
    class Earth:
        __instance = None  # 定义一个类属性做判断

        def __new__(cls):
            if cls.__instance is None:
                cls.__instance = object.__new__(cls)
                return cls.__instance
            else:
                return cls.__instance

    a = Earth()
    print(id(a))  # 512320401648
    b = Earth()
    print(id(b))  # 512320401648

_del__(self)::

    析构器，当一个对象将要被系统回收之时调用的方法

__str__(self)::

    当你打印一个对象的时候，触发__str__
    当你使用%s格式化的时候，触发__str__
    str强转数据类型的时候，触发__str__

__repr__(self)::

    repr是str的备胎
    有__str__的时候执行__str__,没有实现__str__的时候，执行__repr__
    repr(obj)内置函数对应的结果是__repr__的返回值
    当你使用%r格式化的时候 触发__repr__

.. note:: __str__(self) 的返回结果可读性强。也就是说，__str__ 的意义是得到便于人们阅读的信息，就像下面的 '2019-10-11' 一样。__repr__(self) 的返回结果应更准确。怎么说，__repr__ 存在的目的在于调试，便于开发者使用。


运算符
==========


算术运算符::

    方法名                         使用
    __add__(self, other)        self + other
    __sub__(self, other)        self - other
    __mul__(self, other)        self * other
    __floordiv__(self, other)   self // other
    __truediv__(self, other)    self / other
    __mod__(self, other)        self % other
    __pow__(self, other)        self ** other

    __lshift__(self, other)         <<
    __rshift__(self, other)         >>
    __and__(self, other)            &
    __xor__(self, other)            ^
    __or__(self, other)             |

反算术运算符::

    说明:
        反运算魔方方法，与算术运算符保持一一对应，不同之处就是反运算的魔法方法多了一个“r”。
        当文件左操作不支持相应的操作时被调用。
    实例说明:
        >>> a + b
        这里加数是a，被加数是b，因此是a主动，
        反运算就是如果a对象的__add__()方法没有实现或者不支持相应的操作，
        那么 Python 就会调用b的__radd__()方法

    __radd__(self, other)
    __rsub__(self, other)
    __rmul__(self, other)
    __rtruediv__(self, other) 
    __rfloordiv__(self, other)
    __rmod__(self, other)   
    __rdivmod__(self, other)
    __rpow__(self, other[, module])
    __rlshift__(self, other)
    __rrshift__(self, other)
    __rand__(self, other)
    __rxor__(self, other)
    __ror__(self, other)


增量赋值运算符::

    __iadd__(self, other)           +=
    __isub__(self, other)           -=
    __imul__(self, other)           *=
    __itruediv__(self, other)       /=
    __ifloordiv__(self, other)      //=
    __imod__(self, other)           %=
    __ipow__(self, other[, modulo])     **=
    __ilshift__(self, other)            <<=
    __irshift__(self, other)            >>=
    __iand__(self, other)       &=
    __ixor__(self, other)       ^=
    __ior__(self, other)        |=

一元运算符::

    __neg__(self)       定义正号的行为：+x
    __pos__(self)       定义负号的行为：-x
    __abs__(self)       定义当被abs()调用时的行为
    __invert__(self)    定义按位求反的行为：~x


比较函数
========

::

    方法名称                       使用
    __eq__(self, other)         self == other
    __ne__(self, other)         self != other
    __lt__(self, other)         self < other
    __gt__(self, other)         self > other
    __le__(self, other)         self <= other
    __ge__(self, other)         self >= other


采用一般方法写法::

    class Word():
        def __init__(self, text):
            self.text = text

        def equals(self, word2):
            return self.text.lower() == word2.text.lower()

    #创建3个字符Object
    first = Word('ha')
    second = Word('HA')
    third = Word('eh')

    #进行比较
    first.equals(second)  #True
    first.equals(third)   #False

采用特殊方法写法::

    class Word():
        def __init__(self, text):
            self.text = text

        def __eq__(self, word2):
            return self.text.lower() == word2.text.lower()

    #创建3个字符对象
    first = Word('ha')
    second = Word('HA')
    third = Word('eh')

    #进行比较
    first == second  #True
    first == third   #False



属性访问
========

__getattr__(self, name)::

    定义当用户试图获取一个不存在的属性时的行为。
    使用x[key]索引操作符的时候调用

__getattribute__(self, name)::

    定义当该类的属性被访问时的行为
    （先调用该方法，查看是否存在该属性，若不存在，接着去调用__getattr__）。

__setattr__(self, name, value)::

    定义当一个属性被设置时的行为。

__delattr__(self, name)::

    定义当一个属性被删除时的行为。

实例::

    class C:
        def __getattribute__(self, item):
            print('__getattribute__')
            return super().__getattribute__(item)

        def __getattr__(self, item):
            print('__getattr__')

        def __setattr__(self, key, value):
            print('__setattr__')
            super().__setattr__(key, value)

        def __delattr__(self, item):
            print('__delattr__')
            super().__delattr__(item)


    c = C()
    c.x
    # __getattribute__
    # __getattr__

    c.x = 1
    # __setattr__

    del c.x
    # __delattr__

描述符
======

描述符就是将某种特殊类型的类的实例指派给另一个类的属性。

::

    __get__(self, instance, owner)用于访问属性，它返回属性的值。
    __set__(self, instance, value)将在属性分配操作中调用，不返回任何内容。
    __del__(self, instance)控制删除操作，不返回任何内容。

实例::

    class MyDecriptor:
        def __get__(self, instance, owner):
            print('__get__', self, instance, owner)

        def __set__(self, instance, value):
            print('__set__', self, instance, value)

        def __delete__(self, instance):
            print('__delete__', self, instance)


    class Test:
        x = MyDecriptor()


    t = Test()

    1. 调用__get__方法
    t.x
    # __get__ <__main__.MyDecriptor object at 0x7f8cd81ae650> <__main__.Test object at 0x7f8cd81ae290> <class '__main__.Test'>


    2. 调用__set__方法
    t.x = 'x-man'
    # __set__ <__main__.MyDecriptor object at 0x7f8cd81ae650> <__main__.Test object at 0x7f8cd81ae290> x-man

    3. 删除__delete__方法
    del t.x
    # __delete__ <__main__.MyDecriptor object at 0x7f8cd81ae650> <__main__.Test object at 0x7f8cd81ae290>

定制序列
========

__len__(self)::

    对序列对象使用内建的len()函数的时候调用
    __len__(self)     len(self)

__getitem__(self, key)::

    定义获取容器中元素的行为，相当于
    >>> self[key]

__setitem__(self, key, value)::

    定义设置容器中指定元素的行为，相当于
    >>> self[key] = value

__delitem__(self, key)::

    定义删除容器中指定元素的行为，相当于
    >>> del self[key]

【例子】编写一个可改变的自定义列表，要求记录列表中每个元素被访问的次数::

    class CountList:
        def __init__(self, *args):
            self.values = [x for x in args]
            self.count = {}.fromkeys(range(len(self.values)), 0)

        def __len__(self):
            return len(self.values)

        def __getitem__(self, item):
            self.count[item] += 1
            return self.values[item]

        def __setitem__(self, key, value):
            self.values[key] = value

        def __delitem__(self, key):
            del self.values[key]
            for i in range(0, len(self.values)):
                if i >= key:
                    self.count[i] = self.count[i + 1]
            self.count.pop(len(self.values))


    c1 = CountList(1, 3, 5, 7, 9)
    c2 = CountList(2, 4, 6, 8, 10)
    print(c1[1])  # 3
    print(c2[2])  # 6
    c2[2] = 12
    print(c1[1] + c2[2])  # 15
    print(c1.count)
    # {0: 0, 1: 2, 2: 0, 3: 0, 4: 0}
    print(c2.count)
    # {0: 0, 1: 0, 2: 2, 3: 0, 4: 0}
    del c1[1]
    print(c1.count)
    # {0: 0, 1: 0, 2: 0, 3: 0}



迭代器
======

迭代器有两个基本的方法::

    iter(object)    函数用来生成迭代器
    next(iterator[, default])   返回迭代器的下一个项目

实例::

    links = {'B': '百度', 'A': '阿里', 'T': '腾讯'}

    it = iter(links)
    while True:
        try:
            each = next(it)
        except StopIteration:
            break
        print(each)
    # B
    # A
    # T

    it = iter(links)
    print(next(it))  # B
    print(next(it))  # A
    print(next(it))  # T
    print(next(it))  # StopIteration Exception

实例::

    class Fibs:
        def __init__(self, n=10):
            self.a = 0
            self.b = 1
            self.n = n

        def __iter__(self):
            return self

        def __next__(self):
            self.a, self.b = self.b, self.a + self.b
            if self.a > self.n:
                raise StopIteration
            return self.a

    fibs = Fibs(100)
    for each in fibs:
        print(each, end=' ')

    # 1 1 2 3 5 8 13 21 34 55 89

生成器
======

.. note:: 在 Python 中，使用了 yield 的函数被称为生成器（generator）。跟普通函数不同的是，生成器是一个返回迭代器的函数，只能用于迭代操作，更简单点理解生成器就是一个迭代器。在调用生成器运行的过程中，每次遇到 yield 时函数会暂停并保存当前所有的运行信息，返回 yield 的值, 并在下一次执行 next() 方法时从当前位置继续运行。调用一个生成器函数，返回的是一个迭代器对象。


【例子】用生成器实现斐波那契数列::

    def libs(n):
        a = 0
        b = 1
        while True:
            a, b = b, a + b
            if a > n:
                return
            yield a


    for each in libs(100):
        print(each, end=' ')

    # 1 1 2 3 5 8 13 21 34 55 89






















