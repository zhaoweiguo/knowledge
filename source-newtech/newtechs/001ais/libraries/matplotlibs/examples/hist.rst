直方图
======

plt.hist函数::

    plt.hist(x, 
        bins=10, range=None, normed=False, weights=None, cumulative=False, bottom=None, 
        histtype='bar', 
        align='mid', 
        orientation='vertical',rwidth=None, log=False, color=None, label=None, 
        stacked=False, hold=None, data=None, **kwargs)


参数含义::

    bin：箱子的宽度
    normed 标准化
    histtype 风格，bar，barstacked，step，stepfilled
    orientation 水平还是垂直{‘horizontal’, ‘vertical’}
    align : {‘left’, ‘mid’, ‘right’}, optional(对齐方式)
    stacked：是否堆叠

条形图和直方图之间的区别：直方图用于显示分布，而条形图用于比较不同的实体::

    import matplotlib.pyplot as plt
    population_age = [22,55,62,45,21,22,34,42,42,4,2,102,95,85,55,110,120,70,65,55,111,115,80,75,65,54,44,43,42,48]
    bins = [0,10,20,30,40,50,60,70,80,90,100]
    plt.hist(population_age, bins, histtype='bar', color='b', rwidth=0.8)
    plt.xlabel('age groups')
    plt.ylabel('Number of people')
    plt.title('Histogram')
    plt.show()

实例::

    # 直方图
    s = pd.Series(np.random.randn(1000))
    s.hist(bins = 20,
           histtype = 'bar',
           align = 'mid',
           orientation = 'vertical',
           alpha=0.5,
           normed =True)
    # 密度图
    s.plot(kind='kde',style='k--')


# 堆叠直方图::

    plt.figure(num=1)
    df = pd.DataFrame({'a': np.random.randn(1000) + 1, 'b': np.random.randn(1000),
                        'c': np.random.randn(1000) - 1, 'd': np.random.randn(1000)-2},
                       columns=['a', 'b', 'c','d'])
    df.plot.hist(stacked=True,
                 bins=20,
                 colormap='Greens_r',
                 alpha=0.5,
                 grid=True)
    # 使用DataFrame.plot.hist()和Series.plot.hist()方法绘制

    df.hist(bins=50)
    # 生成多个直方图







