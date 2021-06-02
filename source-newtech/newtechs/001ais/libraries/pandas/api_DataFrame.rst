API-DataFrame
#############

.. sidebar:: Contents

    .. contents::

Constructor
===============

简介::

    Two-dimensional, size-mutable, potentially heterogeneous tabular data.

结构::

    DataFrame(data=None, index=None, columns=None, dtype=None, copy=False)[source]

Parameters::

    1. data: ndarray (structured or homogeneous), Iterable, dict, or DataFrame
    2. index: Index or array-like
    3. columns: Index or array-like
    4. dtype: dtype, default None
    5. copy: bool, default False




.. note:: DataFrame的创建主要有三种方式

1. 通过二维数组创建数据框::

    In [42]: arr2 = np.array(np.arange(12)).reshape(4,3)
      ...: print(arr2)
    [[ 0  1  2]
     [ 3  4  5]
     [ 6  7  8]
     [ 9 10 11]]
    In [43]: df1 = pd.DataFrame(arr2)
        ...: print(df1)
       0   1   2
    0  0   1   2
    1  3   4   5
    2  6   7   8
    3  9  10  11

2. 通过字典的方式创建数据框::

    In [44]: dic2 = {'a':[1,2,3,4],'b':[5,6,7,8],'c':[9,10,11,12],'d':[13,14,15,16]}
        ...: print(dic2)
    {'a': [1, 2, 3, 4], 
     'b': [5, 6, 7, 8],
     'c': [9, 10, 11, 12], 
     'd': [13, 14, 15, 16]}
    In [47]: df2 = pd.DataFrame(dic2)
        ...: print(df2)
       a  b   c   d
    0  1  5   9  13
    1  2  6  10  14
    2  3  7  11  15
    3  4  8  12  16

3. 通过数据框的方式创建数据框::

    In [49]: df4 = df2[['a','b']]
        ...: print(df4)
       a  b
    0  1  5
    1  2  6
    2  3  7
    3  4  8

Reshaping, sorting, transposing
===============================

DataFrame.pivot_table函数
-------------------------

说明::

    Create a spreadsheet-style pivot table as a DataFrame

结构::

    DataFrame.pivot_table(
        values=None,          # column to aggregate, optional
        index=None,           # Keys to group by on the pivot table index
        columns=None,         # Keys to group by on the pivot table column.
        aggfunc='mean',       # the key is column to aggregate
        fill_value=None,      # Value to replace missing values
        margins=False,        # Add all row / columns
        dropna=True,          # Do not include columns whose entries are all NaN
        margins_name='All',   # 
        observed=False
    )








