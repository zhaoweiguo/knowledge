.. _python_simple:

python收集
====================

import相关::

    # 此模块import它上一层的模块
    import sys
    sys.path.append("..")

    //实例:
    import pymongo

运算符与表达式::

    ** 幂 
    // 取整除
    %  取模


控制流基本格式::

    //if操作
    if guess == number:
        print 'a1'
    elif guess == number2:
        print 'a2'
    else:
        print 'a3'

    //while操作
    while True:
        s = raw_input('Enter something : ')
        if s == 'quit':
            break
        elif s == 'continue':
            continue

    //for操作
    for i in range(1, 5):
        print i
    else:
        print i+1
    //


    range(1, 5)
    // [1, 2, 3, 4]


模块::

    import sys
    print 'The command line arguments are:'
    for i in sys.argv:
        print i
    print '\n\nThe PYTHONPATH is', sys.path, '\n'


    如果你想要直接输入argv变量, 而不用每次使用它时打sys:
    from sys import argv

    //dir函数:
    import sys
    dir(sys)    # get list of attributes for sys module



输入/输出::

    # 往文件里写数据
    f = file('poem.txt', 'w')
    f.write("<...>")
    f.close()

    # 读文件里的数据
    f = file('poem.txt')
    while True:
        line = f.readline()
        if len(line) == 0: # 长度为0意味着EOF
            break
        print line,
    f.close()

    # file.seek(0)的使用:
    file.seek(0)是重新定位在文件的第0位及开始位置 
    file = open("test.txt","rw")  #注意这行的变动
    file.seek(3)  #定位到第3个
    for i in file:
        print i
    # 现在到了最后一位了
    for i in file:
        print i
    # 不会显示任何结果
    file.seek(0) #定位到第0个
    for i in file:
        print i


储存器(Python提供一个标准的模块，称为pickle。使用它你可以在一个文件中储存任何Python对象，之后你又可以把它完整无缺地取出来。这被称为 持久地 储存对象)::

    # 储存与取储存
    import cPickle as p

    shoplistfile = 'shoplist.data'      #文件名
    shoplist = ['apple', 'mango', 'carrot']     #列表内容
    f = file(shoplistfile, 'w')   # 以写的方式打开文件
    p.dump(shoplist, f)           # 把列表内容存放到之前指定的文件中
    f.close()

    del shoplist
    f = file(shoplistfile)      # 以读的方式打开文件
    storedlist = p.load(f)      # 打开文件
    print storedlist



