API-index
#############

结构::

    Index(data=None, dtype=None, copy=False, name=None, tupleize_cols=True, **kwargs)
    参数:
    data: array-like (1-dimensional)
    dtype: NumPy dtype (default: object)
    copy: bool
    name: object
    tupleize_cols: bool (default: True)

说明::

    Immutable sequence used for indexing and alignment. 
    The basic object storing axis labels for all pandas objects.





实例::

    In [57]: s4 = pd.Series(np.array([1,1,2,3,5,8]))
        ...: print(s4.index)
    RangeIndex(start=0, stop=6, step=1)

    // 设定一个自定义的索引值
    In [59]: s4.index = ['a','b','c','d','e','f']
        ...: print(s4.index)
        ...:
    Index(['a', 'b', 'c', 'd', 'e', 'f'], dtype='object')

    索引值的使用:
    在一维数组中，就无法通过索引标签获取数据，这也是序列不同于一维数组的一个方面
    print('s4[3]: ',s4[3])
    print('s4[e]: ',s4['e'])
    print("s4[1,3,5]: ",s4[[1,3,5]])
    print("s4[['a','b','d','f']]: ",s4[['a','b','d','f']])
    print('s4[:4]: ',s4[:4])
    print("s4['c':]: ",s4['c':])
    print("s4['b':'e']: ",s4['b':'e'])

    // 打印:
    s4[3]:  3
    s4[e]:  5
    s4[1,3,5]:  b    1
    d    3
    f    8
    dtype: int64
    s4[['a','b','d','f']]:  a    1
    b    1
    d    3
    f    8
    dtype: int64
    s4[:4]:  a    1
    b    1
    c    2
    d    3
    dtype: int64
    s4['c':]:  c    2
    d    3
    e    5
    f    8
    dtype: int64
    s4['b':'e']:  b    1
    c    2
    d    3
    e    5
    dtype: int64






