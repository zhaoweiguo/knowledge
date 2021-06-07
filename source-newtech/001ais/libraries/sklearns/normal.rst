常用
####


安装::

    $ pip install -U scikit-learn
    $ conda install scikit-learn

SKlearn包含的机器学习方式::

    分类，回归，无监督，数据降维，数据预处理等等，包含了常见的大部分机器学习方法


强大数据库
==========

1.鸢尾花数据集::

    from sklearn.datasets import load_iris
    data = load_iris()
    #导入数据和标签
    data_X = data.data
    data_y = data.target 

2.波士顿房价数据集::

    from sklearn import datasets
    loaded_data = datasets.load_boston()
    #导入数据
    data_X = loaded_data.data
    data_y = loaded_data.target

通用学习模式
============

鸢尾花数据集::

    from sklearn.model_selection import train_test_split
    from sklearn import datasets

    #k近邻函数
    from sklearn.neighbors import KNeighborsClassifier
    iris = datasets.load_iris()

    #导入数据和标签
    iris_X = iris.data
    iris_y = iris.target

    #划分为训练集和测试集数据
    X_train, X_test, y_train, y_test = train_test_split(iris_X, iris_y, test_size=0.3)
    #print(y_train)

    #设置knn分类器
    knn = KNeighborsClassifier()

    #进行训练
    knn.fit(X_train, y_train)

    #使用训练好的knn进行数据预测
    print(knn.predict(X_test))
    print(y_test)

波士顿房价数据集::

    import matplotlib.pyplot as plt
    from sklearn import datasets
    #调用线性回归函数
    from sklearn.linear_model import LinearRegression

    #导入数据集
    #这里将全部数据用于训练，并没有对数据进行划分
    #上例中, 将数据划分为训练和测试数据，后面会讲到交叉验证
    loaded_data = datasets.load_boston()
    data_X = loaded_data.data
    data_y = loaded_data.target

    #设置线性回归模块
    model = LinearRegression()
    #训练数据，得出参数
    model.fit(data_X, data_y)

    #利用模型，对新数据，进行预测，与原标签进行比较
    print(model.predict(data_X[:4,:]))
    print(data_y[:4]) 

