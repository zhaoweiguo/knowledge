.. _pandas_example_subset:

实例-subset
###########

导入一个student数据集::

    import pandas as pd

    stu_dic = {
      'Age':[14,13,13,14,14,12,12,15,13,12,11,14,12,15,16,12,15,11,15],
      'Height':[69,56.5,65.3,62.8,63.5,57.3,59.8,62.5,62.5,59,51.3,64.3,56.3,66.5,72,64.8,67,57.5,66.5],
      'Name':['Alfred','Alice','Barbara','Carol','Henry','James','Jane','Janet','Jeffrey','John','Joyce','Judy','Louise','Marry','Philip','Robert','Ronald','Thomas','Willam'],
      'Sex':['M','F','F','F','M','M','F','F','M','M','F','F','F','F','M','M','M','M','M'],
      'Weight':[112.5,84,98,102.5,102.5,83,84.5,112.5,84,99.5,50.5,90,77,112,150,128,133,85,112]
    }
    student = pd.DataFrame(stu_dic)

查询数据的前5行或末尾5行::

    In [63]: student.head()
        ...:
    Out[63]:
       Age  Height     Name Sex  Weight
    0   14    69.0   Alfred   M   112.5
    1   13    56.5    Alice   F    84.0
    2   13    65.3  Barbara   F    98.0
    3   14    62.8    Carol   F   102.5
    4   14    63.5    Henry   M   102.5

    In [64]: student.tail()
    Out[64]:
        Age  Height    Name Sex  Weight
    14   16    72.0  Philip   M   150.0
    15   12    64.8  Robert   M   128.0
    16   15    67.0  Ronald   M   133.0
    17   11    57.5  Thomas   M    85.0
    18   15    66.5  Willam   M   112.0

查询指定的行::

    In [65]: print(student.loc[[0,2,4,5,7]])
       Age  Height     Name Sex  Weight
    0   14    69.0   Alfred   M   112.5
    2   13    65.3  Barbara   F    98.0
    4   14    63.5    Henry   M   102.5
    5   12    57.3    James   M    83.0
    7   15    62.5    Janet   F   112.5

查询指定的列::

    In [66]: print(student[['Name','Height','Weight']].head())
          Name  Height  Weight
    0   Alfred    69.0   112.5
    1    Alice    56.5    84.0
    2  Barbara    65.3    98.0
    3    Carol    62.8   102.5
    4    Henry    63.5   102.5

也可以通过loc索引标签查询指定的列::

    In [67]: print(student.loc[:,['Name','Height','Weight']].head())
          Name  Height  Weight
    0   Alfred    69.0   112.5
    1    Alice    56.5    84.0
    2  Barbara    65.3    98.0
    3    Carol    62.8   102.5
    4    Henry    63.5   102.5

查询出所有12岁以上的女生信息::

    In [68]: print(student[(student['Sex']=='F') & (student['Age']>12)])
        Age  Height     Name Sex  Weight
    1    13    56.5    Alice   F    84.0
    2    13    65.3  Barbara   F    98.0
    3    14    62.8    Carol   F   102.5
    7    15    62.5    Janet   F   112.5
    11   14    64.3     Judy   F    90.0
    13   15    66.5    Marry   F   112.0

查询出所有12岁以上的女生姓名、身高和体重::

    In [69]: print(student[(student['Sex']=='F') & (student['Age']>12)][['Name','Height','Weight']])
           Name  Height  Weight
    1     Alice    56.5    84.0
    2   Barbara    65.3    98.0
    3     Carol    62.8   102.5
    7     Janet    62.5   112.5
    11     Judy    64.3    90.0
    13    Marry    66.5   112.0

统计离散变量的观测数、唯一值个数、众数水平及个数::

    In [83]: print(student['Sex'].describe())
    count     19
    unique     2
    top        M
    freq      10
    Name: Sex, dtype: object






