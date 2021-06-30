箱型图
######

箱型图：又称为盒须图、盒式图、盒状图或箱线图，是一种用作显示一组数据分散情况资料的统计图::

    包含一组数据的：最大值、最小值、中位数、上四分位数（Q1）、下四分位数（Q3）、异常值
    ① 中位数 → 一组数据平均分成两份，中间的数
    ② 下四分位数Q1 → 是将序列平均分成四份，计算(n+1)/4与(n-1)/4两种，一般使用(n+1)/4
    ③ 上四分位数Q3 → 是将序列平均分成四份，计算(1+n)/4*3=6.75
    ④ 内限 → T形的盒须就是内限，最大值区间Q3+1.5IQR,最小值区间Q1-1.5IQR （IQR=Q3-Q1）
    ⑤ 外限 → T形的盒须就是内限，最大值区间Q3+3IQR,最小值区间Q1-3IQR （IQR=Q3-Q1）
    ⑥ 异常值 → 内限之外 - 中度异常，外限之外 - 极度异常
    plt.plot.box(),plt.boxplot()

# plt.plot.box()绘制::

    fig,axes = plt.subplots(2,1,figsize=(10,6))
    df = pd.DataFrame(np.random.rand(10, 5), columns=['A', 'B', 'C', 'D', 'E'])
    color = dict(boxes='DarkGreen', whiskers='DarkOrange', medians='DarkBlue', caps='Gray')
    # 箱型图着色
    # boxes → 箱线
    # whiskers → 分位数与error bar横线之间竖线的颜色
    # medians → 中位数线颜色
    # caps → error bar横线颜色

    df.plot.box(ylim=[0,1.2],
               grid = True,
               color = color,
               ax = axes[0])

    df.plot.box(vert=False, 
                positions=[1, 4, 5, 6, 8],
                ax = axes[1],
                grid = True,
               color = color)
    # vert：是否垂直，默认True
    # position：箱型图占位


.. image:: /images/languages/pythons/opensources/matplotlib_box_demo1.png

实例::

    df = pd.DataFrame(np.random.rand(10, 5), columns=['A', 'B', 'C', 'D', 'E'])

    plt.figure(figsize=(10,4))
    # 创建图表、数据

    f = df.boxplot(sym = 'o',  # 异常点形状，参考marker
                   vert = True,  # 是否垂直
                   whis = 1.5,  # IQR，默认1.5，也可以设置区间比如[5,95]，代表强制上下边缘为数据95%和5%位置
                   patch_artist = True,  # 上下四分位框内是否填充，True为填充
                   meanline = False,showmeans=True,  # 是否有均值线及其形状
                   showbox = True,  # 是否显示箱线
                   showcaps = True,  # 是否显示边缘线
                   showfliers = True,  # 是否显示异常值
                   notch = False,  # 中间箱体是否缺口
                   return_type='dict'  # 返回类型为字典
                  ) 
    plt.title('boxplot')

    for box in f['boxes']:
        box.set( color='b', linewidth=1)        # 箱体边框颜色
        box.set( facecolor = 'b' ,alpha=0.5)    # 箱体内部填充颜色
    for whisker in f['whiskers']:
        whisker.set(color='k', linewidth=0.5,linestyle='-')
    for cap in f['caps']:
        cap.set(color='gray', linewidth=2)
    for median in f['medians']:
        median.set(color='DarkBlue', linewidth=2)
    for flier in f['fliers']:
        flier.set(marker='o', color='y', alpha=0.5)
    # boxes, 箱线
    # medians, 中位值的横线,
    # whiskers, 从box到error bar之间的竖线.
    # fliers, 异常值
    # caps, error bar横线
    # means, 均值的横线,

实例3::

    # plt.boxplot()绘制
    # 分组汇总

    df = pd.DataFrame(np.random.rand(10,2), columns=['Col1', 'Col2'] )
    df['X'] = pd.Series(['A','A','A','A','A','B','B','B','B','B'])
    df['Y'] = pd.Series(['A','B','A','B','A','B','A','B','A','B'])

    df.boxplot(by = 'X')
    df.boxplot(column=['Col1','Col2'], by=['X','Y'])
    # columns：按照数据的列分子图
    # by：按照列分组做箱型图









