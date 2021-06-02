字典dict/map{}
##############

.. note:: 为一种没有顺序的的容器，其使用的是大括弧{}，里面包含键值与值(key : value)

.. note:: 序列是以连续的整数为索引，与此不同的是，字典以"关键字"为索引，关键字可以是任意不可变类型，通常用字符串或数值。字典是 Python 唯一的一个 映射类型，字符串、元组、列表属于序列类型。

关键点::

    字典 定义语法为 {元素1, 元素2, ..., 元素n}

    大括号 -- 把所有元素绑在一起
    逗号 -- 将每个键值对分开
    冒号 -- 将键和值分开

    字典 是无序的 键:值（key:value）对集合，键必须是互不相同的

实例::

    ab = {
       'key1' : 'value1',
       'key2' : 'value2',
       'key3' : 'value3',
       'key4' : 'value4'
     }
     print("key1's value is %s" % ab['key1'])

     # 1. 增加
     ab['key5'] = 'value5'

     # 2. 删除一条记录
     del ab['key3']

     # 3. 查询
     ab['key1']            => 'value1'
     ab['key_not_exist']   => 报错: KeyError

     # 4. 查询（默认值）
     ab.get('key1', 'abc')    => 'value1'
     ab.get('key_not_exist', 'abc')    => 'abc'  # 查不到使用默认值

     # 6. 打印字典组中全部数据
     for key, value in ab.items():
         print ('key %s 的 value is %s' % (key, value))

     if 'key1' in ab:   # 或 ab.has_key('key1')
         print ("\nkey1的 value is %s" % ab['key1'])

实例::

    1. 初使化
    dic = { 'a':'v','b':'w', }  #最后一个逗号可以省略
    dic_ = { 'd':'y','c':'x' }
    print(dic, dic_)

    2. 数组(tuple)转化为dict
    方法1:
    lol1 = [ ['a', 'b'], ['c', 'd'], ['e', 'f'] ]
    lol2 = [ ('a', 'b'), ('c', 'd'), ('e', 'f') ]
    lol3 = ( ['a', 'b'], ['c', 'd'], ['e', 'f'] )
    print(dict(lol1), dict(lol2), dict(lol3))

    方法2:
    tos1 = [ 'ab', 'cd', 'ef' ]
    tos2 = ( 'ab', 'cd', 'ef' )
    print(dict(tos1), dict(tos2))
    # {'a': 'b', 'c': 'd', 'e': 'f'} {'a': 'b', 'c': 'd', 'e': 'f'}

    3. 替换
    3.1 dict元素替换
    print(dic_['c'])
    dic_['c'] = 'z'
    print(dic_['c'])

    3.2 dict替换
    dic.update(dic_)
    print(dic)

    4. 删除
    del dic['d']
    print(dic)

    5. 元素是否存在
    print('a' in dic)

    6. dict转化为数组(tuple)
    print(dic.keys())         # dict_keys(['a', 'b', 'c'])
    print(dic.values())       # dict_values(['v', 'w', 'x'])
    print(list(dic.items()))  # [('a', 'v'), ('b', 'w'), ('c', 'x')]

    7. 值传递vs引用传递
    7.1. 引用传递(直接赋值)
    dic_new = dic
    dic_new['a'] = 'n'
    print(dic, dic_new)

    7.2. 值传递(浅复制)
    dic_cp = dic.copy()
    dic_cp['a'] = 'm'
    print(dic, dic_cp)

内置方法
========

dict.fromkeys(seq[, value])::

    用于创建一个新字典，以序列 seq 中元素做字典的键，value 为字典所有键对应的初始值。

    seq = ('name', 'age', 'sex')
    dic1 = dict.fromkeys(seq)
    print(dic1)
    # {'name': None, 'age': None, 'sex': None}

    dic2 = dict.fromkeys(seq, 10)
    print(dic2)
    # {'name': 10, 'age': 10, 'sex': 10}

    dic3 = dict.fromkeys(seq, ('小马', '8', '男'))
    print(dic3)
    # {'name': ('小马', '8', '男'), 'age': ('小马', '8', '男'), 'sex': ('小马', '8', '男')}

dict.keys()::

    返回一个可迭代对象，可以使用 list() 来转换为列表，列表为字典中的所有键

    dic = {'Name': 'lsgogroup', 'Age': 7}
    print(dic.keys())  # dict_keys(['Name', 'Age'])
    lst = list(dic.keys())  # 转换为列表
    print(lst)  # ['Name', 'Age']

dict.values()::

    返回一个迭代器，可以使用 list() 来转换为列表，列表为字典中的所有值。

    dic = {'Sex': 'female', 'Age': 7, 'Name': 'Zara'}
    print(dic.values())
    # dict_values(['female', 7, 'Zara'])

    print(list(dic.values()))
    # [7, 'female', 'Zara']

dict.items()::

    以列表返回可遍历的 (键, 值) 元组数组。

    dic = {'Name': 'Lsgogroup', 'Age': 7}
    print(dic.items())
    # dict_items([('Name', 'Lsgogroup'), ('Age', 7)])

    print(tuple(dic.items()))
    # (('Name', 'Lsgogroup'), ('Age', 7))

    print(list(dic.items()))
    # [('Name', 'Lsgogroup'), ('Age', 7)]

dict.get(key, default=None)::

    返回指定键的值，如果值不在字典中返回默认值。

    dic = {'Name': 'Lsgogroup', 'Age': 27}
    print("Age 值为 : %s" % dic.get('Age'))  # Age 值为 : 27
    print("Sex 值为 : %s" % dic.get('Sex', "NA"))  # Sex 值为 : NA
    print(dic)  # {'Name': 'Lsgogroup', 'Age': 27}

dict.setdefault(key, default=None)::

    和get()方法 类似, 如果键不存在于字典中，将会添加键并将值设为默认值。

    dic = {'Name': 'Lsgogroup', 'Age': 7}
    print("Age 键的值为 : %s" % dic.setdefault('Age', None))  # Age 键的值为 : 7
    print("Sex 键的值为 : %s" % dic.setdefault('Sex', None))  # Sex 键的值为 : None
    print(dic)  
    # {'Age': 7, 'Name': 'Lsgogroup', 'Sex': None}

dict.pop(key[,default])::

    删除字典给定键 key 所对应的值，返回值为被删除的值。
    key 值必须给出。
    若key不存在，则返回 default 值。

    dic1 = {1: "a", 2: [1, 2]}
    print(dic1.pop(1), dic1)  # a {2: [1, 2]}

    # 设置默认值，必须添加，否则报错
    print(dic1.pop(3, "nokey"), dic1)  # nokey {2: [1, 2]}

dict.popitem()::

    随机返回并删除字典中的一对键和值，如果字典已经为空，却调用了此方法，就报出KeyError异常。

    dic1 = {1: "a", 2: [1, 2]}
    print(dic1.popitem())  # {2: [1, 2]}
    print(dic1)  # (1, 'a')

dict.clear()::

    用于删除字典内所有元素。

    dic = {'Name': 'Zara', 'Age': 7}
    print("字典长度 : %d" % len(dic))  # 字典长度 : 2
    dic.clear()
    print("字典删除后长度 : %d" % len(dic))  
    # 字典删除后长度 : 0





