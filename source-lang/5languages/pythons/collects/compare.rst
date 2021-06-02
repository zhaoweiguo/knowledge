不同集合对比
############


列表(list)与Tuples
==================

两者差异在于::

    1. List可以改变其內容，增減长度 or 替换等等皆可以
    2. Tuples一旦赋值之后，就不能再修改
    3. 以性能和内存使用量来说，Tuples皆较佳

list,tuple,dict实例::

        marx_list = ['Groucho', 'Chico', 'Harpo']
        marx_tuple = 'Groucho', 'Chico', 'Harpo'
        marx_dict = {'Groucho': 'banjo', 'Chico': 'piano', 'Harpo': 'harpo'} 
        print(marx_list[2])         # Harpo
        print(marx_tuple[2])        # Harpo
        print(marx_dict['Harpo'])   # Harpo

集合实例
======================

不同容器之间的使用差别::

    marx_list = ['Groucho', 'Chico', 'Harpo']
    marx_tuple = 'Groucho', 'Chico', 'Harpo'
    marx_dict = {'Groucho': 'banjo', 'Chico': 'piano', 'Harpo': 'harpo'} 
    print(marx_list[2])          # harpo
    print(marx_tuple[2])         # harpo
    print(marx_dict['Harpo'])    # harpo


容器中可以包含不同类型的元素，也可以包含其他的容器物件::

    dict_of_lists = {'Stooges': ['Moe', 'Curly', 'Larry'],
                    'Marxes': ['Groucho', 'Chico', 'Harpo'],
                    'Pythons': ['Chapman', 'Cleese', 'Gilliam', 'Jones', 'Palin']}
    print(dict_of_lists)
    print(dict_of_lists['Marxes'])      # ['Groucho', 'Chico', 'Harpo']
    print(dict_of_lists['Marxes'][1])   # Chico


判断一个数据类型 X 是不是可变类型
=================================

说明::

    1. 麻烦方法
        先使用 id(X) 函数，再对 X 进行某种操作，再使用id(X)函数，比较操作前后的 id，
        a. 如果不一样，则 X 不可变，
        b. 如果一样，则 X 可变。
    2. 便捷方法
        用 hash(X)，
        a. 只要不报错，证明 X 可被哈希，即不可变，
        b. 反过来不可被哈希，即可变

id函数实例::

    i = 1
    print(id(i))  # 140732167000896
    i = i + 2
    print(id(i))  # 140732167000960

    l = [1, 2]
    print(id(l))  # 4300825160
    l.append('Python')
    print(id(l))  # 4300825160

hash函数实例::

    print(hash('Name'))  # 7047218704141848153

    print(hash((1, 2, 'Python')))  # 1704535747474881831

    print(hash([1, 2, 'Python']))
    # TypeError: unhashable type: 'list'
    
    print(hash({1, 2, 3}))
    # TypeError: unhashable type: 'set'

.. note:: 数值、字符和元组 都能被哈希，因此它们是不可变类型。列表、集合、字典不能被哈希，因此它是可变类型。






