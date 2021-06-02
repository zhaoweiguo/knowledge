列表list[]
##############


List可以使用 [] 或是 list() 來创建空的，或是直接加入值进去，使用逗号区分即可。內容可以重复出现，且具有順序性::

    empty_list = []
    weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
    big_birds = ['emu', 'ostrich', 'cassowary']

使用 list() 来作为转换其他类型到List::

    print(list('cat'))      # ['c', 'a', 't']

    a_tuple = ('ready', 'fire', 'aim')
    print(list(a_tuple))    # ['ready', 'fire', 'aim']

提取內容時跟字符串一样使用[ ]， index 从0开始，-1为最后一个::

    XD = ['a', 'b', 'c', 'd']
    print(XD[0])    # a
    print(XD[1])    # b
    print(XD[-1])   # d
    print(XD[-2])   # c

    XD[0] = 'QQ'

    print(XD[0:2])      # ['QQ', 'b']
    print(XD[2:-2])     # []
    print(XD[::2])      # ['QQ', 'c']

.. note:: List里面可以包含不同类型的Object，当然也包括List


可以使用List的內建函数append()来向后面添加元素:

+-------------------------------+------------------------------------------------------------+
| 语法                          | 效果                                                       |
+===============================+============================================================+
| list.extend()或 +=            | 合并list                                                   |
+-------------------------------+------------------------------------------------------------+
| list.insert()                 | 在指定位置插入元素，若位置超过最大长度則放在最后面。       |
+-------------------------------+------------------------------------------------------------+
| del Object                    | 用来刪除某个位置的元素，剩余元素会自动往前填补             |
+-------------------------------+------------------------------------------------------------+
| list.remove()                 | 用来移除指定元素                                           |
+-------------------------------+------------------------------------------------------------+
| list.pop()                    | 类似剪出的效果，可以將指定位置的元素剪出來，默认index为 -1 |
+-------------------------------+------------------------------------------------------------+
| list.index(x[, start[, end]]) | 找查指定元素第一次出现的index                              |
+-------------------------------+------------------------------------------------------------+
| in Object                     | 判断指定元素是否存在                                       |
+-------------------------------+------------------------------------------------------------+
| list.count(obj)               | 计算指定元素出現次数                                       |
+-------------------------------+------------------------------------------------------------+


实例1::

    XD = ['a', 'b']
    XD2 = ['e', 'f']

    XD.append('QQ~')    # ['a', 'b', 'QQ~']
    XD.extend(XD2)      # ['a', 'b', 'QQ~', 'e', 'f']
    XD += XD2           # ['a', 'b', 'QQ~', 'e', 'f', 'e', 'f']
    XD.append(XD2)      # ['a', 'b', 'QQ~', 'e', 'f', 'e', 'f', ['e', 'f']]
    XD.insert(2, 'c')   # ['a', 'b', 'c', 'QQ~', 'e', 'f', 'e', 'f', ['e', 'f']]
    XD.insert(500, 'ker')   # ['a', 'b', 'c', 'QQ~', 'e', 'f', 'e', 'f', ['e', 'f'], 'ker']
    del XD[8]           # ['a', 'b', 'c', 'QQ~', 'e', 'f', 'e', 'f', 'ker']
    XD.remove('e')      # ['a', 'b', 'c', 'QQ~', 'f', 'e', 'f', 'ker']
    QQ = XD.pop(3)      # ['a', 'b', 'c', 'f', 'e', 'f', 'ker'] QQ~

    print(XD.index('f'))    # 3
    print('ker' in XD)      # True
    print(XD.count('f'))    # 2

实例2::

    print(', '.join(['a', 'b', 'c']))       # a, b, c
    print(', '.join('abc'))                 # a, b, c
    print(', '.join(('a', 'b', 'c')))       # a, b, c
    print('a, b, c'.split(', '))            # ['a', 'b', 'c']


::

    shoplist.sort()     #自排序

列表综合::

    listone = [2, 3, 4]
    listtwo = [2*i for i in listone if i > 2]
    print listtwo

    //結果
    [6, 8]


列表list::

    shoplist = ['apple', 'mango', 'carrot', 'banana']   #列表
    print '一共', len(shoplist), '个列表'   #打印列表个数
    for item in shoplist:        #打印列表中的各值
        print item
    shoplist.sort()     #自排序
    del shoplist[0]     #从列表中删除一条


序列::

    shoplist = ['apple', 'mango', 'carrot', 'banana']
    print('Item 0 is', shoplist[0])          #'apple'
    print('Item -2 is', shoplist[-2])        #'carrot'
    print('Item 1 to 3 is', shoplist[1:3])   #['mango', 'carrot']
    print('Item 0 to 3 is', shoplist[:3])   #['apple', 'mango', 'carrot']
    print('Item 1 to last is', shoplist[1:])   #['mango', 'carrot', 'banana']

    name = 'swaroop'
    print('characters 1 to 3 is', name[1:3])     #'wa'

   

切片
====

通用写法::

    start : stop : step

实例::

    1. 格式: "start :"
    week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
    print(week[3:])  # ['Thursday', 'Friday']
    print(week[-3:])  # ['Wednesday', 'Thursday', 'Friday']

    2. 格式: ": stop"
    print(week[:3])  # ['Monday', 'Tuesday', 'Wednesday']
    print(week[:-3])  # ['Monday', 'Tuesday']

    3. 格式: "start : stop"
    print(week[1:3])  # ['Tuesday', 'Wednesday']
    print(week[-3:-1])  # ['Wednesday', 'Thursday']

    4. 格式: "start : stop : step"

    5. 格式: " : "
        复制列表中的所有元素（浅拷贝）


浅拷贝与深拷贝
==============

python 的三种赋值方式::

    直接赋值(传址)
    浅拷贝(copy)
    深拷贝(deepcopy)

.. figure:: /images/languages/pythons/basic_copy1.png

   直接赋值(传址)


直接赋值(传址)::

    shoplist = ['apple', 'mango', 'carrot', 'banana']
    mylist = shoplist    #此乃引用


.. note:: 使用 '=' 设定变量则会是传址，等同于前面說的标签概念，把两张标签贴在同一个物件上(number or srting 除外) 这样当我改变Object后，则Object上所有的标签所指到的值都会跟着改变， 若要改成赋值的话可以使用copy() 、 list.list() 与 list[:] 来达到目的



.. note:: 浅拷贝，拷贝的是父对象，不会拷贝到内部的子对象。

.. figure:: /images/languages/pythons/basic_copy2.png

   浅拷贝

浅拷贝::

    方式1:
    c = a.copy()

    方式2:
    e = a[:]

    方式3:
    d = list(a)


浅拷贝vs直接赋值实例::

    1. 不修改内部子对象时，浅copy不会被修改
    list1 = [123, 456, 789, 213]
    list2 = list1
    list3 = list1[:]

    print(list2)  # [123, 456, 789, 213]
    print(list3)  # [123, 456, 789, 213]
    list1.sort()
    print(list2)  # [123, 213, 456, 789] 
    print(list3)  # [123, 456, 789, 213]

    2. 修改内部子对象时，浅copy也会被修改
    list1 = [[123, 456], [789, 213]]
    list2 = list1
    list3 = list1[:]

    print(list2)  # [[123, 456], [789, 213]]
    print(list3)  # [[123, 456], [789, 213]]
    list1[0][0] = 111
    print(list2)  # [[111, 456], [789, 213]]
    print(list3)  # [[111, 456], [789, 213]]


.. figure:: /images/languages/pythons/basic_copy3.png

   深拷贝

深拷贝vs浅拷贝实例::

    import copy
    a=[1,2,[3,4],5]
    b=copy.deepcopy(a)  # 深拷贝
    c=a[:]              # 浅拷贝
    print(b) # 结果为 [1,2,[3,4],5]

    # 1. 更改a的数据(浅拷贝和深拷贝都不变)
    a.append(6)
    print(a)    # [1,2,[3,4],5,6]
    print(b)    # [1,2,[3,4],5]
    print(c)    # [1,2,[3,4],5]

    # 2. 子对象数据（深层数据）的更改(浅拷贝变, 深拷贝不变)
    a[2].append(7)
    print(a)    # [1,2,[3,4,7],5，6]
    print(b)    # [1,2,[3,4],5]
    print(c)    # [1,2,[3,4,7],5]



