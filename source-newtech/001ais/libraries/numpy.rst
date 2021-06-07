.. _numpy:

numpy
#####

* 官网 [1]_
* 文档 [2]_
* 索引 [3]_
* 中文版 [4]_
* github [5]_


引入::

    $ import numpy as np

NumPy（Numerical Python的简称）是Python数值计算最重要的基础包。大多数提供科学计算的包都是用NumPy的数组作为构建基础。

NumPy的部分功能如下::

    1. ndarray，一个具有矢量算术运算和复杂广播能力的快速且节省空间的多维数组
    2. 用于对整组数据进行快速运算的标准数学函数（无需编写循环）
    3. 用于读写磁盘数据的工具以及用于操作内存映射文件的工具
    4. 线性代数、随机数生成以及傅里叶变换功能
    5. 用于集成由C、C++、Fortran等语言编写的代码的A C API

NumPy之于数值计算特别重要的原因之一，是因为它可以高效处理大数组的数据::

    In [2]: import numpy as np
       ...: my_arr = np.arange(1000000)
       ...: my_list = list(range(1000000))

    In [6]: %time for _ in range(10): my_arr2 = my_arr * 2
    CPU times: user 20.8 ms, sys: 20.7 ms, total: 41.5 ms
    Wall time: 41.1 ms

    In [7]: %time for _ in range(10): my_list2 = [x * 2 for x in my_list]
    CPU times: user 538 ms, sys: 112 ms, total: 650 ms
    Wall time: 651 ms


.. image:: /images/languages/pythons/opensources/numpy_func.jpg


NumPy的ndarray：一种多维数组对象::

    In [3]: import numpy as np
       ...: data = np.random.randn(2, 3)
       ...: print(data)
       ...:
    [[ 0.35775698 -1.78119191 -0.80584732]
     [ 2.15299456  0.04187989 -0.18685547]]

    #所有元素都乘以10
    In [4]: print('data * 10: \n', data * 10)
    data * 10:
     [[  3.57756982 -17.81191913  -8.05847316]
     [ 21.52994562   0.41879885  -1.86855466]]

    In [5]: print('data shape:', data.shape)
       ...: print('data dtype:', data.dtype)
    data shape: (2, 3)
    data dtype: float64

    In [11]: print(np.zeros(10))
        ...: print(np.zeros((3, 6)))
        ...: print(np.empty((2, 3, 2)))
    [0. 0. 0. 0. 0. 0. 0. 0. 0. 0.]
    [[0. 0. 0. 0. 0. 0.]
     [0. 0. 0. 0. 0. 0.]
     [0. 0. 0. 0. 0. 0.]]
    [[[-2.00000000e+000  1.49457942e-154]
      [ 2.10077583e-312  6.79038654e-313]
      [ 2.22809558e-312  2.14321575e-312]]

     [[ 2.35541533e-312  6.79038654e-313]
      [ 2.22809558e-312  2.14321575e-312]
      [ 2.46151512e-312  2.41907520e-312]]]

    In [12]: print(np.arange(15))
    [ 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14]

ndarray的数据类型::

    In [13]: arr1 = np.array([1, 2, 3], dtype=np.float64)
        ...: arr2 = np.array([1, 2, 3], dtype=np.int32)
        ...:
        ...: print(arr1.dtype)
        ...: print(arr2.dtype)
    float64
    int32

.. note:: 索引和切片与内置list相同



通用函数:快速的元素级数组函数
=============================


.. image:: /images/languages/pythons/opensources/numpy_func1.jpg

.. image:: /images/languages/pythons/opensources/numpy_func2.jpg

.. image:: /images/languages/pythons/opensources/numpy_func3.jpg


sqrt和exp函数::

    In [31]: arr = np.arange(10)
        ...:
        ...: print(arr)
        ...: print(np.sqrt(arr))
        ...: print(np.exp(arr))
    [0 1 2 3 4 5 6 7 8 9]
    [0.         1.         1.41421356 1.73205081 2.         2.23606798
     2.44948974 2.64575131 2.82842712 3.        ]
    [1.00000000e+00 2.71828183e+00 7.38905610e+00 2.00855369e+01
     5.45981500e+01 1.48413159e+02 4.03428793e+02 1.09663316e+03
     2.98095799e+03 8.10308393e+03]

random和maximum命令::

    In [32]: x = np.random.randn(8)
        ...: y = np.random.randn(8)
        ...:
        ...: print(x)
        ...: print(y)
        ...: print(np.maximum(x, y))
    [-0.38405455 -0.99029294 -0.42023275  0.8897072  -0.2891113   1.2796723
     -0.2019518   0.23640106]
    [ 0.63131513 -1.40453141 -0.96596068  0.95133804 -0.86885599 -0.66267199
     -0.95051251  0.13153113]
    [ 0.63131513 -0.99029294 -0.42023275  0.95133804 -0.2891113   1.2796723
     -0.2019518   0.23640106]

modf返回浮点数数组的小数和整数部分::

    In [33]: arr = np.random.randn(7) * 5
        ...: print(arr)
        ...:
        ...: remainder, whole_part = np.modf(arr)
        ...: print(remainder)
        ...: print(whole_part)
    [-0.22441841  0.59618988 -1.2827303  -2.9008093   5.80343059  5.73925452  -4.07858587]
    [-0.22441841  0.59618988 -0.2827303  -0.9008093   0.80343059  0.73925452  -0.07858587]
    [-0.  0. -1. -2.  5.  5. -4.]

将条件逻辑表述为数组运算::

    xarr = np.array([1.1, 1.2, 1.3, 1.4, 1.5])
    yarr = np.array([2.1, 2.2, 2.3, 2.4, 2.5])
    cond = np.array([True, False, True, True, False])

    1. 使用python内置方法, 有两个问题: a. 处理速度不是很快 b. 无法用于多维数组
    result = [(x if c else y)
      for x, y, c in zip(xarr, yarr, cond)]
    print(result)
    [1.1000000000000001, 2.2000000000000002, 1.3, 1.3999999999999999, 2.5]

    2. 数组级别操作（速度快）
    result = np.where(cond, xarr, yarr)
    print(result)


    In [3]: arr = np.random.randn(4, 4)
       ...: print(arr)
       ...: print(arr > 0)
       ...: print(np.where(arr > 0, 2, -2))
    [[-0.60044813  1.18248591  1.44088919 -0.18970201]
     [ 0.79217038  0.91348077  0.03984553  1.58252457]
     [ 1.03533365 -1.63077865 -1.00532788 -0.59828079]
     [ 0.68810174  0.0709139   1.0416629   0.3819959 ]]
    [[False  True  True False]
     [ True  True  True  True]
     [ True False False False]
     [ True  True  True  True]]
    [[-2  2  2 -2]
     [ 2  2  2  2]
     [ 2 -2 -2 -2]
     [ 2  2  2  2]]

    In [4]: print(np.where(arr > 0, 2, arr))
    [[-0.60044813  2.          2.         -0.18970201]
     [ 2.          2.          2.          2.        ]
     [ 2.         -1.63077865 -1.00532788 -0.59828079]
     [ 2.          2.          2.          2.        ]]

.. image:: /images/languages/pythons/opensources/numpy_func4.png

数学和统计方法::

    arr = np.random.randn(5, 4)
    print(arr)
    print(arr.mean())
    print(np.mean(arr))
    print(arr.sum())

    print(arr.mean(axis=1))   // 计算行的平均值
    print(arr.sum(axis=0))    // 计算每列的和

    // 累加函数(cumsum)
    In [5]: arr = np.array([0, 1, 2, 3, 4, 5, 6, 7])
       ...: print(arr.cumsum())   // 累加
       ...: print(arr.cumprod())  // 累乘
    [ 0  1  3  6 10 15 21 28]
    [0 0 0 0 0 0 0 0]

    // 多维数组
    In [6]: arr = np.array([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
       ...: print(arr)
       ...: print(arr.cumsum(axis=0))   // 列累加
       ...: print(arr.cumprod(axis=1))  // 行累乘
    [[0 1 2]
     [3 4 5]
     [6 7 8]]
    [[ 0  1  2]
     [ 3  5  7]
     [ 9 12 15]]
    [[  0   0   0]
     [  3  12  60]
     [  6  42 336]]

.. image:: /images/languages/pythons/opensources/numpy_func5.png


排序算法的特征在于执行速度，最坏情况性能

+-----------------------+------+-------------+----------+--------+
| 种类                  | 速度 | 最坏情况    | 工作空间 | 稳定性 |
+=======================+======+=============+==========+========+
| 'quicksort'(快速排序) | 1    | O(n^2)      | 0        | 否     |
+-----------------------+------+-------------+----------+--------+
| 'mergesort'(归并排序) | 2    | O(n*log(n)) | ~n/2     | 是     |
+-----------------------+------+-------------+----------+--------+
| 'heapsort'(堆排序)    | 3    | O(n*log(n)) | 0        | 否ˇ    |
+-----------------------+------+-------------+----------+--------+

排序::

    // 实例1
    In [21]: a = np.array([[3,7],[9,1]])
        ...: print ('我们的数组是:', a)
        ...: print ('调用 sort() 函数：', np.sort(a))
        ...: print ('沿轴 0 排序：', np.sort(a, axis =  0))
        ...: # 在 sort 函数中排序字段
        ...: dt = np.dtype([('name',  'S10'),('age',  int)])
        ...: a = np.array([("raju",21),("anil",25),("ravi",  17),("amar",27)],dtype = dt)
        ...: print ('我们的数组是：', a)
        ...: print ('按 name 排序：', np.sort(a, order =  'name'))

    我们的数组是: [[3 7] [9 1]]
    调用 sort() 函数： [[3 7] [1 9]]
    沿轴 0 排序： [[3 1] [9 7]]
    我们的数组是： [(b'raju', 21) (b'anil', 25) (b'ravi', 17) (b'amar', 27)]
    按 name 排序： [(b'amar', 27) (b'anil', 25) (b'raju', 21) (b'ravi', 17)]

排序numpy.argsort()::

    In [24]: x = np.array([3,  1,  2])
        ...: print ('我们的数组是：', x)
        ...: y = np.argsort(x)
        ...: print ('对 x 调用 argsort() 函数：', y)
        ...: print ('以排序后的顺序重构原数组：', x[y])
        ...: print ('使用循环重构原数组：')
        ...: for i in y:
        ...:     print (x[i])
        ...:
    我们的数组是： [3 1 2]
    对 x 调用 argsort() 函数： [1 2 0]
    以排序后的顺序重构原数组： [1 2 3]
    使用循环重构原数组：
    1
    2
    3

排序numpy.lexsort()::

    使用键序列执行间接排序。 键可以看作是电子表格中的一列
    该函数返回一个索引数组，使用它可以获得排序数据
    注意，最后一个键恰好是 sort 的主键
    In [25]: nm =  ('raju','anil','ravi','amar')
        ...: dv =  ('f.y.',  's.y.',  's.y.',  'f.y.')
        ...: ind = np.lexsort((dv, nm))
        ...: print ('调用 lexsort() 函数：', ind)
        ...: print ('使用这个索引来获取排序后的数据：')
        ...: print ([nm[i]  +  ", "  + dv[i]  for i in ind])
    调用 lexsort() 函数： [3 1 0 2]
    使用这个索引来获取排序后的数据：
    ['amar, f.y.', 'anil, s.y.', 'raju, f.y.', 'ravi, s.y.']

唯一化以及其它的集合逻辑::

    // 找出数组中的唯一值并返回已排序的结果
    In [26]: names = np.array(['Bob', 'Joe', 'Will', 'Bob', 'Will', 'Joe', 'Joe'])
        ...: print(np.unique(names))
        ...: ints = np.array([3, 3, 3, 2, 2, 1, 1, 4, 4])
        ...: print(np.unique(ints))
        ...: print(sorted(set(names)))   // 等价的纯Python代码
    ['Bob' 'Joe' 'Will']
    [1 2 3 4]
    ['Bob' 'Joe' 'Will']


.. image:: /images/languages/pythons/opensources/numpy_func6.jpg

用于数组的文件输入输出::

    In [30]: arr = np.arange(10)
        ...: np.save('some_array', arr)         // 保存数组到文件some_array.npy
        ...: print(np.load('some_array.npy'))   // 加载文件
    [0 1 2 3 4 5 6 7 8 9]

    通过np.savez可以将多个数组保存到一个未压缩文件中
    In [31]: np.savez('array_archive.npz', a=arr, b=arr)
        ...:
        ...: arch = np.load('array_archive.npz')
        ...: print(arch['b'])
    [0 1 2 3 4 5 6 7 8 9]

    如果要将数据压缩，可以使用numpy.savez_compressed
    In [32]: np.savez_compressed('arrays_compressed.npz', a=arr, b=arr)

线性代数::

    In [33]: x = np.array([[1., 2., 3.], [4., 5., 6.]])
        ...: y = np.array([[6., 23.], [-1, 7], [8, 9]])
        ...:
        ...: print(x)
        ...: print(y)
        ...: print(x.dot(y))  // x.dot(y)等价于np.dot(x, y)：
        ...:
    [[1. 2. 3.] [4. 5. 6.]]
    [[ 6. 23.] [-1.  7.] [ 8.  9.]]
    [[ 28.  64.] [ 67. 181.]]

    In [34]: print (x @ np.ones(3))   // 中缀运算符
    [ 6. 15.]
    In [35]: print(np.dot(x, np.ones(3)))
    [ 6. 15.]

.. image:: /images/languages/pythons/opensources/numpy_func7.jpg


.. image:: /images/languages/pythons/opensources/numpy_func8.png



.. [1] https://numpy.org/
.. [2] https://numpy.org/doc/
.. [3] https://numpy.org/doc/1.18/genindex.html
.. [4] https://www.runoob.com/numpy/numpy-tutorial.html
.. [5] https://github.com/numpy/numpy