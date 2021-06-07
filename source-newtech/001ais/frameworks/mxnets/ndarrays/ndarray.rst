ndarray
#######

ones_like
=========

格式::

    mxnet.ndarray.ones_like(data=None, out=None, name=None, **kwargs)

说明::

    Return an array of ones with the same shape and type as the input array.

实例::

    x = [[ 0.,  0.,  0.],
         [ 0.,  0.,  0.]]

    ones_like(x) = [[ 1.,  1.,  1.],
                    [ 1.,  1.,  1.]]


ones
====

格式::

    mxnet.ndarray.ones(shape, ctx=None, dtype=None, **kwargs)

说明::

    Returns a new array filled with all ones, with the given shape and type.

实例::

    >>> mx.nd.ones(1).asnumpy()
    array([ 1.], dtype=float32)
    >>> mx.nd.ones((1,2), mx.gpu(0))
    <NDArray 1x2 @gpu(0)>
    >>> mx.nd.ones((1,2), dtype='float16').asnumpy()
    array([[ 1.,  1.]], dtype=float16)
    >>> a = mx.nd.ones(shape=10)
    [1. 1. 1. 1. 1. 1. 1. 1. 1. 1.]
    <NDArray 10 @cpu(0)>

zeros
=====

格式::

    mxnet.ndarray.zeros(shape, ctx=None, dtype=None, stype=None, **kwargs)

说明::

    Return a new array of given shape and type, filled with zeros.

Parameters::

    shape (int or tuple of int) 
        – The shape of the empty array
    ctx (Context, optional) 
        – An optional device context (default is the current default context)
    dtype (str or numpy.dtype, optional) 
        – An optional value type (default is float32)
    stype (string, optional) 
        – The storage type of the empty array, 如:‘row_sparse’, ‘csr’, etc.

实例::

    >>> mx.nd.zeros((1,2), mx.cpu(), stype='csr')
    <CSRNDArray 1x2 @cpu(0)>
    >>> mx.nd.zeros((1,2), mx.cpu(), 'float16', stype='row_sparse').asnumpy()
    array([[ 0.,  0.]], dtype=float16)









