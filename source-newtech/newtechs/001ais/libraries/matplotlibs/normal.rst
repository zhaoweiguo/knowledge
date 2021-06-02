基本
####

* 打开 :ref:`matplotlib魔法 <ipython_magic>` 找到 ``%matplotlib``

基本元素
========

图表的基本元素::

    图名
    x轴标签
    y轴标签
    图例
    x轴边界
    y轴边界
    x刻度
    y刻度
    x刻度标签
    y刻度标签

实例::

    # 范围只限定图表的长度，刻度则是决定显示的标尺
    df = pd.DataFrame(np.random.rand(10,2),columns=['A','B'])

    fig = df.plot(figsize=(8,4))  # figsize：创建图表窗口，设置窗口大小

    plt.title('TITLETITLETITLE')  # 图名
    plt.xlabel('XXXXXX')  # x轴标签
    plt.ylabel('YYYYYY') # y轴标签

    plt.legend(loc = 'upper right') # 显示图例，loc表示位置

    # 这里x轴边界范围是0-12
    plt.xlim([0,12])  # x轴边界
    plt.ylim([0,1.5])  # y轴边界

    # 但刻度只是0-9, 刻度标签使得其显示1位小数
    plt.xticks(range(10))  # 设置x刻度
    plt.yticks([0,0.2,0.4,0.6,0.8,1.0,1.2])  # 设置y刻度

    fig.set_xticklabels("%.1f" %i for i in range(10))  # x轴刻度标签
    fig.set_yticklabels("%.2f" %i for i in [0,0.2,0.4,0.6,0.8,1.0,1.2])  # y轴刻度标签


图表样式
========

图表样式各选项::

    linestyle
    color
    marker
    style (linestyle、marker、color)
    alpha
    colormap
    grid

color颜色参考 `这儿 <https://matplotlib.org/gallery/color/named_colors.html#sphx-glr-gallery-color-named-colors-py>`_

实例-linestyle, marker, color::

    s = pd.Series(np.random.randn(100).cumsum())    # 需: import numpy as np,import pandas as pd
    s.plot(linestyle = '--',
           marker = '.',
           color="r",
          grid=True)

实例-透明度与颜色版::

    s.plot(style="--.",alpha = 0.8,colormap = 'Reds_r')

实例-透明度与颜色版2::

    df = pd.DataFrame(np.random.randn(100, 4),columns=list('ABCD')).cumsum()    # 需: import pandas as pd
    df.plot(style = '--.',alpha = 0.8,colormap = 'summer_r')


图标注解
========

实例::

    df = pd.DataFrame(np.random.randn(10,2))
    df.plot(style = '--o')
    plt.text(5,0.5,'Hello',fontsize=12)  


子图绘制
========

函数格式::

    plt.figure(num=None, figsize=None, dpi=None, facecolor=None, edgecolor=None, frameon=True, 
                  FigureClass=<class 'matplotlib.figure.Figure'>, **kwargs)
    plt.subplots(nrows=1, ncols=1, sharex=False, sharey=False, squeeze=True, subplot_kw=None, 
                  gridspec_kw=None, **fig_kw)[source]

figure对象::

    fig1 = plt.figure(num=1, figsize=(8,6))
    plt.plot(np.random.rand(50).cumsum(), 'k--')
    fig2 = plt.figure(num=2,figsize=(8,6))
    plt.plot(50-np.random.rand(50).cumsum(), 'k--')

建子图后填充图表::

    # 先建立子图然后填充图表
    fig = plt.figure(figsize=(10,6), facecolor = 'gray')

    ax1 = fig.add_subplot(2,2,1)  # 左上角
    plt.plot(np.random.rand(50).cumsum(),'k--')
    plt.plot(np.random.randn(50).cumsum(),'b--')

    ax2 = fig.add_subplot(2,2,2)  # 右上角
    ax2.hist(np.random.rand(50),alpha=0.5)

    ax4 = fig.add_subplot(2,2,4)  # 右下角
    df2 = pd.DataFrame(np.random.rand(10, 4), columns=['a', 'b', 'c', 'd'])
    ax4.plot(df2,alpha=0.5,linestyle='--',marker='.')

subplots子图数组填充图标::

    # 创建一个新的figure，并返回一个subplot对象的numpy数组 → plt.subplot
    fig,axes = plt.subplots(2,3,figsize=(10,4))
    ts = pd.Series(np.random.randn(1000).cumsum())

    print(axes.shape, type(axes))     # (2, 3) <class 'numpy.ndarray'>

    # 生成图表对象的数组
    ax1 = axes[0,1]
    ax1.plot(ts)

# plt.subplots 参数调整::

    fig,axes = plt.subplots(2,2,sharex=True,sharey=True) # sharex,sharey：是否共享x，y刻度

    for i in range(2):
        for j in range(2):
            axes[i,j].hist(np.random.randn(500),color='k',alpha=0.5)
            
    # wspace,hspace：用于控制宽度和高度的百分比，比如subplot之间的间距
    plt.subplots_adjust(wspace=0,hspace=0)

多系列图绘制::

    df = pd.DataFrame(np.random.randn(1000, 4), index=ts.index, columns=list('ABCD'))
    df = df.cumsum()
    df.plot(style = '--.',alpha = 0.4,grid = True,figsize = (20,8),
           subplots = True,
           layout = (1,4),
           sharex = False)
    plt.subplots_adjust(wspace=0,hspace=0.2)



