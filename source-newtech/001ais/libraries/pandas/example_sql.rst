.. _pandas_example_sql:

利用pandas实现SQL操作
#####################

增:添加新行或增加新列
=====================

::

    In [91]:dic = {
        'Name':['LiuShunxiang','Zhangshan'],
        'Sex':['M','F'],
        'Age':[27,23],
        'Height':[165.7,167.2],
        'Weight':[61,63]
    }
    In [92]:student2 = pd.DataFrame(dic)
        ...:print(student2)
               Name Sex  Age  Height  Weight
    0  LiuShunxiang   M   27   165.7      61
    1     Zhangshan   F   23   167.2      63

将student2中的数据新增到 :ref:`student <pandas_example_subset>` 中，可以通过concat函数实现::

    student3 = pd.concat([student,student2])
    print(student3)

在student2中新增一列学生成绩::

    // 对于新增的列没有赋值，就会出现空NaN的形式
    In [93]: print(pd.DataFrame(student2, 
          columns=['Age','Height','Name','Sex','Weight','Score']))
       Age  Height          Name Sex  Weight  Score
    0   27   165.7  LiuShunxiang   M      61    NaN
    1   23   167.2     Zhangshan   F      63    NaN

删:删除表,观测行或变量列
========================

删表::

    In [102]: del student2 #删除数据框student2, 通过del命令可以删除python的所有对象
         ...: print(student2)
    ---------------------------------------------------------------------------
    NameError                                 Traceback (most recent call last)
    <ipython-input-103-a5f84f69c799> in <module>
    ----> 1 print(student2)

    NameError: name 'student2' is not defined

删除原数据中的第1,2,4,7行的数据::

    In [102]: print(student.drop([0,1,3,6]))
        Age  Height     Name Sex  Weight
    2    13    65.3  Barbara   F    98.0
    4    14    63.5    Henry   M   102.5
    5    12    57.3    James   M    83.0
    7    15    62.5    Janet   F   112.5
    8    13    62.5  Jeffrey   M    84.0
    ...

删除所有14岁以下的学生::

    // 其实这个删除就是保留删除条件的反面数据
    // 即: 取出大于14岁的学生
    In [102]: print(student[student['Age']>14])

删除指定的列::

    // 不论是删除行还是删除列，都可以通过drop方法实现，只需要设定好删除的轴即可
    // 即调整drop方法中的axis参数
    // 默认该参数为0，表示删除行观测，如果需要删除列变量，则需设置为1
    print(student.drop(['Height','Weight'],axis=1).head())

改:修改原始记录的值
===================

student3中姓名为LiuShunxiang的学生身高错了，应该是173::

    In [102]: student3.loc[student3['Name'] == 'LiuShunxiang','Height']=173
         ...: print(student3[student3['Name'] == 'LiuShunxiang'][['Name','Height']])

               Name  Height
    0  LiuShunxiang   173.0

聚合:groupby函数实现数据的聚合
==============================

根据性别分组，计算各组别中学生身高和体重的平均值::

    print(student.groupby('Sex').mean())

如果不想对年龄计算平均值的话，就需要剔除改变量::

    print(student.drop('Age',axis=1).groupby('Sex').mean())

groupby还可以使用多个分组变量，例如根据年龄和性别分组，计算身高与体重的平均值::

    print(student.groupby(['Sex','Age']).mean())

对每个分组计算多个统计量::

    print(student.drop('Age',axis=1).groupby('Sex').agg([np.mean,np.median]))

使用sort_index和sort_values实现序列和数据框的排序工作::

    Data = pd.Series(np.array(np.random.randint(1,20,10)))
    print(Data)
    print(Data.sort_index())
    print(Data.sort_values(ascending=False))

在数据框中一般都是按值排序::

    print(student.sort_values(by = ['Age','Height']))

多表连接
========

构造一个新表::

    dic2 = {
        'Name':['Alf','Alice','Bar','Car','Henry','Jef','Jud','Philip','Rob','Willam'],
        'Score':[88,76,89,67,79,90,92,86,73,77]}
    score = pd.DataFrame(dic2)
    print(score)

把学生表student与学生成绩表score做一个关联::

    stu_score1 = pd.merge(student, score, on='Name')
    print(stu_score1)

.. note:: 默认情况下，merge函数实现的是两个表之间的内连接，即返回两张表中共同部分的数据

可以通过how参数设置连接的方式，left为左连接；right为右连接；outer为外连接::

    stu_score2 = pd.merge(student, score, on='Name', how='left')
    print(stu_score2)





