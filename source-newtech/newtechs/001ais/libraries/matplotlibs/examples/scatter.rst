散点图
======

plt.scatter函数::

    plt.scatter(x, y, s=20, c=None, marker='o', cmap=None, norm=None, vmin=None, vmax=None, 
            alpha=None, linewidths=None,
            verts=None, edgecolors=None, hold=None, data=None, **kwargs)

参数含义::

    s：散点的大小
    c：散点的颜色
    vmin,vmax：亮度设置，标量
    cmap：colormap


一个变量确定水平轴上的位置，而另一个变量的值确定垂直轴上的位置::

    import matplotlib.pyplot as plt
    x = [1,1.5,2,2.5,3,3.5,3.6]
    y = [7.5,8,8.5,9,9.5,10,10.5] 
    x1=[8,8.5,9,9.5,10,10.5,11]
    y1=[3,3.5,3.7,4,4.5,5,5.2] 
    plt.scatter(x,y, label='high income low saving',color='r')
    plt.scatter(x1,y1,label='low income high savings',color='b')
    plt.xlabel('saving*100')
    plt.ylabel('income*1000')
    plt.title('Scatter Plot')
    plt.legend()
    plt.show()

实例::

    plt.figure(figsize=(8,6))

    x = np.random.randn(1000)
    y = np.random.randn(1000)

    plt.scatter(x,y,marker='.',
               s = np.random.randn(1000)*100,
               cmap = 'Reds_r',
               c = y,
               alpha = 0.8,)
    plt.grid()

散点矩阵scatter_matrix函数::

    # pd.scatter_matrix()散点矩阵
    # pd.scatter_matrix(frame, alpha=0.5, figsize=None, ax=None, 
    # grid=False, diagonal='hist', marker='.', density_kwds=None, hist_kwds=None, range_padding=0.05, **kwds)
    # diagonal：({‘hist’, ‘kde’})，必须且只能在{‘hist’, ‘kde’}中选择1个 → 每个指标的频率图
    # range_padding：(float, 可选)，图像在x轴、y轴原点附近的留白(padding)，该值越大，留白距离越大，图像远离坐标原点

    df = pd.DataFrame(np.random.randn(100,4),columns = ['a','b','c','d'])
    pd.scatter_matrix(df,figsize=(10,6),
                     marker = 'o',
                     diagonal='kde',
                     alpha = 0.5,
                     range_padding=0.5)







