实例-缺失值的处理
#################

现实生活中的数据是非常杂乱的，其中缺失值也是非常常见的，对于缺失值的存在可能会影响到后期的数据分析或挖掘工作，那么我们该如何处理这些缺失值呢？常用的有三大类方法，即删除法、填补法和插值法::

    1. 删除法：
       当数据中的某个变量大部分值都是缺失值，可以考虑删除改变量
       当缺失值是随机分布的，且缺失的数量并不是很多时，也可以删除这些缺失的观测
    2. 替补法：
       对于连续型变量，如果变量的分布近似或就是正态分布的话，可以用均值替代那些缺失值；
       如果变量是有偏的，可以使用中位数来代替那些缺失值；
       对于离散型变量，我们一般用众数去替换那些存在缺失的观测。
    3. 插补法：
       插补法是基于蒙特卡洛模拟法，结合线性模型、广义线性模型、决策树等方法计算出来的预测值替换缺失值。

以变量:ref:`stu_score2 <pandas_example_sql>`_ 为例::

    In [114]: s = stu_score2['Score']
         ...: print(s)
    0      NaN
    1     76.0
    2      NaN
    3      NaN
    4     79.0
    5      NaN
    6      NaN
    7      NaN
    8      NaN
    9      NaN
    10     NaN
    11    92.0
    12     NaN
    13     NaN
    14    86.0
    15     NaN
    16     NaN
    17     NaN
    18    77.0
    Name: Score, dtype: float64

结合sum函数和isnull函数来检测数据中含有多少缺失值::

    In [116]: print(sum(pd.isnull(s)))
    14

删除法(使用dropna函数)
======================

直接删除缺失值::

    In [115]: print(s.dropna())
    1     76.0
    4     79.0
    11    92.0
    14    86.0
    18    77.0
    Name: Score, dtype: float64

默认情况下，dropna会删除任何含有缺失值的行::

    // 使用新实例再演示一次
    In [117]: df = pd.DataFrame([
        [1,1,2],[3,5,np.nan],[13,21,34],[55,np.nan,10],
        [np.nan,np.nan,np.nan],[np.nan,1,2]
      ],columns=('x1','x2','x3'))
         ...: print(df)
         x1    x2    x3
    0   1.0   1.0   2.0
    1   3.0   5.0   NaN
    2  13.0  21.0  34.0
    3  55.0   NaN  10.0
    4   NaN   NaN   NaN
    5   NaN   1.0   2.0

数据中只要含有缺失值NaN,该数据行就会被删除::

    In [118]: print(df.dropna())
         ...:
         x1    x2    x3
    0   1.0   1.0   2.0
    2  13.0  21.0  34.0

如果使用参数how=’all’，则表明只删除所有行为缺失值的观测::

    In [119]:  print(df.dropna(how='all'))
         x1    x2    x3
    0   1.0   1.0   2.0
    1   3.0   5.0   NaN
    2  13.0  21.0  34.0
    3  55.0   NaN  10.0
    5   NaN   1.0   2.0

替补法(使用fillna函数)
======================

用0填补所有缺失值::

    print(df.fillna(0))

    另:用123填补
    print(df.fillna(123))

采用前项填充::

    print(df.fillna(method='ffill'))

采用后项填充::

    print(df.fillna(method='bfill'))

使用常量填充不同的列::

    print(df.fillna({'x1':1111,'x2':2222,'x3':3333}))

众数、均值或中位数填充::

    x1_median=df['x1'].median()
    x2_mean=df['x2'].mean()
    x3_mean=df['x3'].mean()

    print(x1_median)
    print(x2_mean)
    print(x3_mean)
    print(df.fillna({'x1':x1_median,'x2':x2_mean,'x3':x3_mean}))


.. note:: 很显然，在使用填充法时，相对于常数填充或前项、后项填充，使用各列的众数、均值或中位数填充要更加合理一点，这也是工作中常用的一个快捷手段。





