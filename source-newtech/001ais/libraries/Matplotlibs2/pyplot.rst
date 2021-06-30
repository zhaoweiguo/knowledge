pyplot [1]_
###########

引入::

    from matplotlib import pyplot as plt
    from matplotlib import pyplot



matplotlib.pyplot.subplots::

    from matplotlib import pyplot as plt
    plt.subplots(1, len(images), figsize=(12, 12))   # 

matplotlib.pyplot.scatter::

    参数:
    x, y:
        scalar or array-like, shape (n, )
        The data positions.
    s: 
        scalar or array-like, shape (n, ), optional
        The marker size in points**2. 
        Default is rcParams['lines.markersize'] ** 2.
    c:
        color, sequence, or sequence of colors, optional
    alpha:
        scalar, optional, default: None
        The alpha blending value, between 0 (transparent) and 1 (opaque).

    实例:
    plt.scatter(features[:, 1].asnumpy(), labels.asnumpy(), s=15, c=colors, alpha=0.1);

plt.rcParams::

    # 设置图的尺寸
    plt.rcParams['figure.figsize'] = figsize



.. [1] https://matplotlib.org/api/pyplot_summary.html