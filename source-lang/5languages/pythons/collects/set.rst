集合set{}
#########

.. note:: 集合就好比沒有value的dictionary，一样没有顺序，使用大括弧{}。使用set()可以转换其他类型至集合，dictionary转换至set只会保留key值。in也可以检查特定元素是否存在其中。

.. note:: 由于key不能重复，所以，在set中，没有重复的key。集合的两个特点：无序 (unordered) 和唯一 (unique)


集合的创建
==========

先创建对象再加入元素::

    basket = set()     # 在创建空集合的时候只能使用s = set()，因为s = {}创建的是空字典
    basket.add('apple')
    basket.add('banana')
    print(basket)  # {'banana', 'apple'}

直接把一堆元素用花括号括起来::

    even_numbers = {0, 2, 4, 6, 8}
    print(empty_set, even_numbers)    # set() {0, 2, 4, 6, 8}

使用set(value)工厂函数，把列表或元组转换成集合::

    print(set( 'letters' ))     # {'l', 's', 'e', 'r', 't'}
    print(set( ['D', 'A', 'P', 'M'] ))      # {'A', 'D', 'P', 'M'}
    print(set( ('U', 'Echoes', 'Atom') ))   # {'Echoes', 'Atom', 'U'}
    print(set( {'apple': 'red', 'orange': 'orange'} ))    # {'orange', 'apple'}

技巧-去掉列表中重复的元素::

    lst = [0, 1, 2, 3, 4, 5, 5, 3, 1]

    a = set(lst)
    print(list(a))  # [0, 1, 2, 3, 4, 5]

访问集合中的值
==============

使用len()內建函数得到集合的大小::

    s = set(['Google', 'Baidu', 'Taobao'])
    print(len(s))  # 3

使用for把集合中的数据一个个读取出来::

    s = set(['Google', 'Baidu', 'Taobao'])
    for item in s:
        print(item)
        
    # Baidu
    # Google
    # Taobao

通过in或not in判断一个元素是否在集合中已经存在::

    s = set(['Google', 'Baidu', 'Taobao'])
    print('Taobao' in s)  # True
    print('Facebook' not in s)  # True

集合的内置方法
==============

元素操作::

    set.add(elmnt)用于给集合添加元素
    set.update(set)用于修改当前集合

    set.remove(item) 用于移除集合中的指定元素(不存在时发生错误)
    set.discard(value) 用于移除指定的集合元素(不存在时不发生错误)
    set.pop() 用于随机移除一个元素

数学意义上的集合操作::

    1. 交集:
       set.intersection(set1, set2) 
       set1 & set2

    2. 并集
       set.union(set1, set2) 
       set1 | set2

    3. 差集
       set.difference(set)
       set1 - set2

    4. 异或
       set.symmetric_difference(set)
       set1 ^ set2 

    5. 被包含
       set.issubset(set)
       set1 <= set2 

    6. 包含
       set.issuperset(set)
       set1 >= set2

    7. 不相交
       set.isdisjoint(set)   # 不相交返回 True











