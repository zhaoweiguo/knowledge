API-Series
############

Constructor
===========

结构::

    Series(data=None, index=None, dtype=None, name=None, copy=False, fastpath=False)

说明::

    Read a comma-separated values (csv) file into DataFrame.


Series的创建::

    序列的创建主要有三种方式:
    1. 通过一维数组创建序列
      In [40]: arr1 = np.arange(10)
          ...: print(arr1)
          ...: s1 = pd.Series(arr1)
          ...: print(s1)
      [0 1 2 3 4 5 6 7 8 9]
      0    0
      1    1
      2    2
      3    3
      4    4
      5    5
      6    6
      7    7
      8    8
      9    9
      dtype: int64
    2. 通过字典的方式创建序列
       In [41]: dic1 = {'a':10,'b':20,'c':30,'d':40,'e':50}
          ...: print(dic1)
          ...: print(type(dic1))
      {'a': 10, 'b': 20, 'c': 30, 'd': 40, 'e': 50}
      <class 'dict'>
    3. 通过DataFrame中的某一行或某一列创建序列



Attributes
==========

Series.index::

    The index (axis labels) of the Series.
    返回值类型:
      Series.index








