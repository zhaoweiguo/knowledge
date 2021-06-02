ndarray.random
##############


print(dir(nd.random))::

    [
     'normal',    从均匀分布采样（uniform）
     'poisson',   从泊松分布采样（poisson）
     'uniform'    从正态分布采样（normal）
     ...
     ]


uniform
-------

说明::

    Draw random samples from a uniform distribution.
    从均匀分布中抽取随机样本。

格式::

    mxnet.ndarray.random.uniform(low=0, high=1, shape=_Null, dtype=_Null, 
        ctx=None, out=None, **kwargs)

实例::

    >>> mx.nd.random.uniform(0, 1)
    [ 0.54881352]
    <NDArray 1 @cpu(0)
    >>> mx.nd.random.uniform(0, 1, ctx=mx.gpu(0))
    [ 0.92514056]
    <NDArray 1 @gpu(0)>
    >>> mx.nd.random.uniform(-1, 1, shape=(2,))
    [ 0.71589124  0.08976638]
    <NDArray 2 @cpu(0)>
    >>> low = mx.nd.array([1,2,3])
    >>> high = mx.nd.array([2,3,4])
    >>> mx.nd.random.uniform(low, high, shape=2)
    [[ 1.78653979  1.93707538]
     [ 2.01311183  2.37081361]
     [ 3.30491424  3.69977832]]
    <NDArray 3x2 @cpu(0)>

normal
------

说明::

    从正态（高斯）分布中抽取随机样本。
    Draw random samples from a normal (Gaussian) distribution.


格式::

    normal([loc, scale, shape, dtype, ctx, out])
    mxnet.ndarray.random.normal(loc=0, scale=1, shape=_Null, dtype=_Null, 
        ctx=None, out=None, **kwargs)

参数::

    1. loc (float or NDArray, optional) 
       – Mean (centre) of the distribution.
       - 均值
    2. scale (float or NDArray, optional) 
       – Standard deviation of the distribution.
       - 标准差
    3. shape (int or tuple of ints, optional) 
       – The number of samples to draw.
       - 实例数
    4. dtype ({'float16', 'float32', 'float64'}, optional) 
       – Data type of output samples. Default is ‘float32’
       - 数据类型
    5. ctx (Context, optional) 
       – Device context of output. Default is current context. 
       - Overridden by loc.context when loc is an NDArray.
    
    out (NDArray, optional) 
        – Store output to an existing NDArray.


实例::

    >>> mx.nd.random.normal(0, 1)
    [ 2.21220636]
    <NDArray 1 @cpu(0)>
    >>> mx.nd.random.normal(0, 1, ctx=mx.gpu(0))
    [ 0.29253659]
    <NDArray 1 @gpu(0)>
    >>> mx.nd.random.normal(-1, 1, shape=(2,))
    [-0.2259962  -0.51619542]
    <NDArray 2 @cpu(0)>
    >>> loc = mx.nd.array([1,2,3])
    >>> scale = mx.nd.array([2,3,4])
    >>> mx.nd.random.normal(loc, scale, shape=2)
    [[ 0.55912292  3.19566321]
     [ 1.91728961  2.47706747]
     [ 2.79666662  5.44254589]]
    <NDArray 3x2 @cpu(0)>
    # 标准差为1的正态分布
    >>> mx.nd.random.normal(scale=1, shape=(2, 3))
    [[ 1.1017746   1.1337967   1.1405879 ]
     [ 1.2673576  -2.0345824  -0.32537818]]
    <NDArray 2x3 @cpu(0)>

randn
-----

格式::

    mxnet.ndarray.random.randn(*shape, **kwargs)

实例::

    >>> mx.nd.random.randn()
    2.21220636
    <NDArray 1 @cpu(0)>
    >>> mx.nd.random.randn(2, 2)
    [[-1.856082   -1.9768796 ]
    [-0.20801921  0.2444218 ]]
    <NDArray 2x2 @cpu(0)>
    >>> mx.nd.random.randn(2, 3, loc=5, scale=1)
    [[4.19962   4.8311777 5.936328 ]
    [5.357444  5.7793283 3.9896927]]
    <NDArray 2x3 @cpu(0)>


poisson
-------

说明::

    Draw random samples from a Poisson distribution.
    从泊松分布中抽取随机样本。

格式::

    mxnet.ndarray.random.poisson(lam=1, shape=_Null, dtype=_Null, ctx=None, out=None, **kwargs)

实例::

    >>> mx.nd.random.poisson(1)
    [ 1.]
    <NDArray 1 @cpu(0)>
    >>> mx.nd.random.poisson(1, shape=(2,))
    [ 0.  2.]
    <NDArray 2 @cpu(0)>
    >>> lam = mx.nd.array([1,2,3])
    >>> mx.nd.random.poisson(lam, shape=2)
    [[ 1.  3.]
     [ 3.  2.]
     [ 2.  3.]]
    <NDArray 3x2 @cpu(0)>

