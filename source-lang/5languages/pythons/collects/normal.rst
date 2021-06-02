常用
####


针对序列的内置函数::

    list(sub) 把一个可迭代对象转换为列表。
    tuple(sub) 把一个可迭代对象转换为元组。
    str(obj) 把obj对象转换为字符串
    len(s) 返回对象（字符、列表、元组等）长度或元素个数。
    max(sub)返回序列或者参数集合中的最大值
    min(sub)返回序列或参数集合中的最小值
    sum(iterable[, start=0]) 返回序列iterable与可选参数start的总和。
    sorted(iterable, key=None, reverse=False) 对所有可迭代的对象进行排序操作
    reversed(seq) 函数返回一个反转的迭代器
    enumerate(sequence, [start=0]) 将一个可遍历的数据对象(如列表、元组或字符串)组合为一个索引序列
    zip(iter1 [,iter2 [...]]) 将可迭代的对象作为参数，将对象中对应的元素打包成一个个元组，
        然后返回由这些元组组成的对象，这样做的好处是节约了不少的内存。



zip()函数
=========

使用zip()可以对多组Object同时进行循环迭代::

    $ for day, fruit, drink, dessert in zip(days, fruits, drinks, desserts):
         print(day, ": drink", drink, "- eat", fruit, "- enjoy", dessert)
    
    Monday : drink coffee - eat banana - enjoy tiramisu
    Tuesday : drink tea - eat orange - enjoy ice cream
    Wednesday : drink beer - eat peach - enjoy pi


zip转换成list, dict::

    $ english = 'Monday', 'Tuesday', 'Wednesday'
    $ french = 'Lundi', 'Mardi', 'Mercredi'

    $ print('转换成list包tuple')
    $ print(list( zip(english, french) ))
    $ print('转换成Dictionarie')
    $ print(dict( zip(english, french) ))

    转换成list包tuple
    [('Monday', 'Lundi'), ('Tuesday', 'Mardi'), ('Wednesday', 'Mercredi')]
    转换成Dictionarie
    {'Monday': 'Lundi', 'Tuesday': 'Mardi', 'Wednesday': 'Mercredi'}








