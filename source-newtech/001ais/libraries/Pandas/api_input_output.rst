API-输入输出
############

Flat file
=============

csv文档：read_csv函数::

    dataset = pd.read_csv('/Users/mayuet/Desktop/winequality-red.csv', sep=';')

    *args:
    有时需要在'path'前加r
    index_col=0 — 指定第一列为index
    sep=';' — 指定分隔符
    header=None — csv自动识别第一行为表头，若第一行不是表头，需要指定None
    nrows=500 — 指定读取的行数
    encoding='utf-8' — 若导入中文，需设置该参数

Special Case：数据量过大 — 使用chunk size::

    data = pd.read_csv('info.csv', sep=',', engine='python', iterator=True)
    loop = True
    chunkSize = 1000  #设定分块读取的大小
    chunks = []
    index = 0
    while loop:
       try:
          print(index)
          chunk = data.get_chunk(chunkSize)  #从文档中读取一块
          chunks.append(chunk)  #读取内容插入list
          index += 1  #准备读取下一行
       except StopIteration:  #当遍历失败时停止
          loop = False
          print('Iteration is stopped')
    print('开始合并')
    data = pd.concat(chunks, ignore_index=True)  #将小块合并起来


Excel
=====


excel文档：read_excel函数::

    dataset = pd.read_excel('winequality-red.xlsx', index_col=0, parse_dates=True)

    *args:
    同read_csv函数


JSON
====


json文档：json包::

    import json
    with open('winequality-red.json') as f:
       data = json.load(f)
       for dict_data in data:  #遍历每个字典
          print(dict_data)

导出数据
========

保存到csv：to_csv函数::

    data.to_csv('result.csv')  #会自动新建一个result.csv

    注意：也有sep、header这些参数，但中文会乱码

保存到excel：ExcelWriter工具::

    with pd.ExcelWriter('result.xlsx') as writer:
       data.to_excel(writer, sheet_name='sheet1', index=False, startrow=0, startcol=0)

保存到txt：writelines函数::

    # 分享一个修改txt的demo #
    with open(r'winequality-red.txt', mode='r') as f:
       data = list()
       lines = (line.replace('"', '') for line in f)
       for line in lines;
          data.append(line)
    with open (r'target.txt', mode='w') as file:
       file.writelines(data) 



其他
====

txt文档：open函数::

    with open('winequality-red.txt', mode='r') as f:
       print(f.read())  #返回文档全部内容
       print(f.readlines())  #逐行返回文档全部内容
       print(f.readline())  #返回一行内容


遍历文件夹中的文档：os包::

    import os
    path = os.getcwd()
    os.listdir(path)  #生成文件名的list

















