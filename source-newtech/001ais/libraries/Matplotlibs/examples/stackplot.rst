面积图
======

.. note:: 面积图与线图非常相似。它们也被称为堆栈图。这些图可用于跟踪构成一个整体类别的两个或多个相关组的随时间变化，面积图或堆栈图用于显示不同属性中随时间变化的趋势。

说明::

    stacked：是否堆叠，默认情况下，区域图被堆叠
    为了产生堆积面积图，每列必须是正值或全部负值！
    当数据有NaN时候，自动填充0，图标签需要清洗掉缺失值

让我们将一天内的工作进行分类，比如睡觉，吃饭，工作和玩耍::

    import matplotlib.pyplot as plt
    days = [1,2,3,4,5]  
    sleeping =[7,8,6,11,7]
    eating = [2,3,4,3,2]
    working =[7,8,7,2,2]
    playing = [8,5,7,8,13]  
    plt.plot([],[],color='m', label='Sleeping', linewidth=5)
    plt.plot([],[],color='c', label='Eating', linewidth=5)
    plt.plot([],[],color='r', label='Working', linewidth=5)
    plt.plot([],[],color='k', label='Playing', linewidth=5)  
    plt.stackplot(days, sleeping,eating,working,playing, colors=['m','c','r','k'])  
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('Stack Plot')
    plt.legend()
    plt.show()

stacked值为True和False的区别::

    fig,axes = plt.subplots(2,1,figsize = (8,6))

    df1 = pd.DataFrame(np.random.rand(10, 4), columns=['a', 'b', 'c', 'd'])
    df2 = pd.DataFrame(np.random.randn(10, 4), columns=['a', 'b', 'c', 'd'])

    df1.plot.area(colormap = 'Greens_r',alpha = 0.5,ax = axes[0])
    df2.plot.area(stacked=False,colormap = 'Set2',alpha = 0.5,ax = axes[1])









