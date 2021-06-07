API-General functions
#####################

.. sidebar:: Contents

    .. contents::


Constructor
===========

简介::

    One-dimensional ndarray with axis labels (including time series).

结构::

    Series(data=None, index=None, dtype=None, name=None, copy=False, fastpath=False)

参数::

    data: array-like, Iterable, dict, or scalar value
    index: array-like or Index (1d)
    dtype: str, numpy.dtype, or ExtensionDtype, optional
    name: str, optional
    copy: bool, default False

实例::

    >>> d = {'a': 1, 'b': 2, 'c': 3}
    >>> ser = pd.Series(data=d, index=['a', 'b', 'c'])
    >>> ser
    a   1
    b   2
    c   3
    dtype: int64

实例::

    >>> d = {'a': 1, 'b': 2, 'c': 3}
    >>> ser = pd.Series(data=d, index=['x', 'y', 'z'])
    >>> ser
    x   NaN
    y   NaN
    z   NaN
    dtype: float64



pivot_table
===========

语法::

    pivot_table(data,values=None,
                index=None,
                columns=None,
                aggfunc='mean',
                fill_value=None,
                margins=False,
                dropna=True,
                margins_name='All')  
    data：需要进行数据透视表操作的数据框
    values：指定需要聚合的字段
    index：指定某些原始变量作为行索引
    columns：指定哪些离散的分组变量
    aggfunc：指定相应的聚合函数
    fill_value：使用一个常数替代缺失值，默认不替换
    margins：是否进行行或列的汇总，默认不汇总
    dropna：默认所有观测为缺失的列
    margins_name：默认行汇总或列汇总的名称为'All'

实例
----



仍然以 :ref:`student <pandas_example_subset>` 表为例，来认识一下数据透视表pivot_table函数的用法::

    // 对一个分组变量（Sex），一个数值变量（Height）作统计汇总
    In [120]: Table1 = pd.pivot_table(student, values=['Height'], columns=['Sex'])
         ...: print(Table1)
    Sex             F      M
    Height  60.588889  63.91

对一个分组变量（Sex），两个数值变量（Height,Weight）作统计汇总::

    In [129]: Table2 = pd.pivot_table(student, values=['Height','Weight'], columns=['Sex'])
         ...: print(Table2)
    Sex             F       M
    Height  60.588889   63.91
    Weight  90.111111  108.95

对两个分组变量（Sex，Age)，两个数值变量（Height,Weight）作统计汇总::

    In [130]: Table3 = pd.pivot_table(student, values=['Height','Weight'], columns=['Sex','Age'])
         ...: print(Table3)
            Sex  Age
    Height  F    11      51.300000
                 12      58.050000
                 13      60.900000
                 14      63.550000
                 15      64.500000
            M    11      57.500000
                 12      60.366667
                 13      62.500000
                 14      66.250000
                 15      66.750000
                 16      72.000000
    Weight  F    11      50.500000
                 12      80.750000
                 13      91.000000
                 14      96.250000
                 15     112.250000
            M    11      85.000000
                 12     103.500000
                 13      84.000000
                 14     107.500000
                 15     122.500000
                 16     150.000000
    dtype: float64

变成列联表的形式: 只需将结果进行非堆叠操作（unstack）即可::

    In [131]: Table4 = pd.pivot_table(student, 
          values=['Height','Weight'], columns=['Sex','Age']).unstack()
         ...: print(Table4)
    Age           11          12    13      14      15     16
           Sex
    Height F    51.3   58.050000  60.9   63.55   64.50    NaN
           M    57.5   60.366667  62.5   66.25   66.75   72.0
    Weight F    50.5   80.750000  91.0   96.25  112.25    NaN
           M    85.0  103.500000  84.0  107.50  122.50  150.0

使用多个聚合函数::

    In [133]: Table5 = pd.pivot_table(student, values=['Height','Weight'], columns=['Sex'],
        aggfunc=[np.mean,np.median,np.std])
         ...: print(Table5)
                 mean         median                std
    Sex             F       M      F       M          F          M
    Height  60.588889   63.91   62.5   64.15   5.018328   4.937937
    Weight  90.111111  108.95   90.0  107.25  19.383914  22.727186

















