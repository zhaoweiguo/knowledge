元组tuple()
===========

.. note:: 也是一个List，差別只在不能做修改，一旦给定后，无法再进行增加 刪除 修改等操作，所以可以当作一个常数的List。元组有不可更改 (immutable) 的性质，因此不能直接给元组的元素赋值，但是只要元组中的元素可更改 (mutable)，那么我们可以直接更改其元素，注意这跟赋值其元素不同



创建为空的时候使用()，一个以上时括号可以省略，但是只有一个时最后一个逗号不可以省略::

    a = ()      # 空Tuples
    b = 'tem',  # b:(tem,) 括号可以省略，但是一个的時候逗号不能省略
    c = 'tem1', 'tem2', 'tem3'  # ('tem1', 'tem2', 'tem3')
    d, e, f = c   # d:'tem1', e:'tem2', f:'tem3'

任意交换变量间的值::

    a = '1'
    b = '2'
    c = '3'
    b, c, a = a, b, c
    print(a, b, c)    # 3 1 2


::

    zoo = ('wolf', 'elephant', 'penguin')
    new_zoo = ('monkey', 'dolphin', zoo)        #第三个元素是一个元组
    # 打印元组
    age = 22
    name = 'Swaroop'
    print('%s is %d years old' % (name, age))

实例——增加一个元素::

    week = ('Monday', 'Tuesday', 'Thursday', 'Friday')
    week = week[:2] + ('Wednesday',) + week[2:]
    print(week)  # ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')

.. note:: 创建元组可以用小括号 ()，也可以什么都不用，为了可读性，建议还是用 ()。

元组中只包含一个元素时，需要在元素后面添加逗号，否则括号会被当作运算符使用::

    x = (1)
    print(type(x))  # <class 'int'>
    x = (1,)
    print(type(x))  # <class 'tuple'>

元组大小和内容都不可更改，因此只有 count 和 index 两种方法::

    count('python') 是记录在元组 t 中该元素出现几次，显然是 1 次
    index(10.31) 是找到该元素在元组 t 的索引，显然是 1

通配符::

    t = 1, 2, 3, 4, 5
    a, b, *rest, c = t
    print(a, b, c)  # 1 2 5
    print(rest)  # [3, 4]

    t = 1, 2, 3, 4, 5
    a, b, *_ = t
    print(a, b)  # 1 2










