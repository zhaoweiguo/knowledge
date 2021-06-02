饼图
====

.. note:: 饼图是指圆形图，它被分解成段，即饼图。它基本上用于显示百分比或比例数据，其中每个饼图片代表一个类别。

plt.pie函数::

    plt.pie(x, explode=None, 
        labels=None, 
        colors=None, autopct=None, pctdistance=0.6, shadow=False, labeldistance=1.1, 
        startangle=None, 
        radius=None, 
        counterclock=True, wedgeprops=None, textprops=None, center=(0, 0), frame=False, hold=None, data=None)

参数含义::

    第一个参数：数据
    explode：指定每部分的偏移量
    labels：标签
    colors：颜色
    autopct：饼图上的数据标签显示方式
    pctdistance：每个饼切片的中心和通过autopct生成的文本开始之间的比例
    labeldistance：被画饼标记的直径,默认值：1.1
    shadow：阴影
    startangle：开始角度
    radius：半径
    frame：图框
    counterclock：指定指针方向，顺时针或者逆时针



我将圆圈划分为4个扇区或切片，分别代表相应的类别（玩耍，睡觉，吃饭和工作）以及他们持有的百分比::

    import matplotlib.pyplot as plt 
    slices = [7,2,2,23]
    activities = ['sleeping','eating','working','playing']
    cols = ['c','m','r','b'] 
    plt.pie(slices,  labels=activities, colors=cols, startangle=90, shadow= True, explode=(0,0.1,0,0), autopct='%1.1f%%') 
    plt.title('Pie Plot')
    plt.show()

实例::

    s = pd.Series(3 * np.random.rand(4), index=['a', 'b', 'c', 'd'], name='series')
    plt.axis('equal')  # 保证长宽相等
    plt.pie(s,
           explode = [0.1,0,0,0],
           labels = s.index,
           colors=['r', 'g', 'b', 'c'],
           autopct='%.2f%%',
           pctdistance=0.6,
           labeldistance = 1.2,
           shadow = True,
           startangle=0,
           radius=1.5,
           frame=False)








