.. _python_string:

字符串
######

常用内置方法
============

大小写::

    capitalize() 将字符串的第一个字符转换为大写。
    lower() 转换字符串中所有大写字符为小写。
    upper() 转换字符串中的小写字母为大写。
    swapcase() 将字符串中大写转换为小写，小写转换为大写。

查找相关::

    count(str, beg= 0,end=len(string)) 
        返回str在 string 里面出现的次数，如果beg或者end指定则返回指定范围内str出现的次数
    endswith(suffix, beg=0, end=len(string)) 
        检查字符串是否以指定子字符串 suffix 结束，如果是，返回 True，否则返回 False。
        如果 beg 和 end 指定值，则在指定范围内检查。
    startswith(substr, beg=0,end=len(string)) 
        检查字符串是否以指定子字符串 substr 开头，如果是，返回 True，否则返回 False。
        如果 beg 和 end 指定值，则在指定范围内检查。
    find(str, beg=0, end=len(string)) 
        检测 str 是否包含在字符串中，如果指定范围 beg 和 end，则检查是否包含在指定范围内，
        如果包含，返回开始的索引值，否则返回 -1。
    rfind(str, beg=0,end=len(string)) 
        类似于 find() 函数，不过是从右边开始查找。
    isnumeric() 
        如果字符串中只包含数字字符，则返回 True，否则返回 False。

增加/去除指定字符::

    ljust(width[, fillchar])
        返回一个原字符串左对齐，并使用fillchar（默认空格）填充至长度width的新字符串。
    rjust(width[, fillchar])
        返回一个原字符串右对齐，并使用fillchar（默认空格）填充至长度width的新字符串。
    lstrip([chars]) 
        截掉字符串左边的空格或指定字符。
    rstrip([chars]) 
        删除字符串末尾的空格或指定字符。
    strip([chars]) 
        在字符串上执行lstrip()和rstrip()。

分隔/替换::

    partition(sub) 
        找到子字符串sub，把字符串分为一个三元组(pre_sub,sub,fol_sub)，
        如果字符串中不包含sub则返回('原字符串','','')。
    rpartition(sub)
        类似于partition()方法，不过是从右边开始查找。
    replace(old, new [, max]) 
        把 将字符串中的old替换成new，如果max指定，则替换不超过max次。
    split(str="", num) 
        不带参数默认是以空格为分隔符切片字符串，
        如果num参数有设置，则仅分隔num个子字符串，返回切片后的子字符串拼接的列表。
    splitlines([keepends]) 
        按照行('\r', '\r\n', \n')分隔，返回一个包含各行作为元素的列表，
        如果参数keepends为 False，不包含换行符，如果为 True，则保留换行符。
    maketrans(intab, outtab) 
        创建字符映射的转换表，第一个参数是字符串，表示需要转换的字符，第二个参数也是字符串表示转换的目标。
    translate(table, deletechars="") 
        根据参数table给出的表，转换字符串的字符，要过滤掉的字符放到deletechars参数中。



字符串格式化
============

format 格式化函数::

    str8 = "{0} Love {1}".format('I', 'XXX')  # 位置参数
    # I Love XXX
    
    str8 = "{a} Love {b}".format(b='I', a='XXX')  # 关键字参数
    # XXX Love I

Python 字符串格式化符号::

    符号     描述
    %c      格式化字符及其ASCII码
    %s      格式化字符串，用str()方法处理对象
    %r      格式化字符串，用rper()方法处理对象
    %d      格式化整数
    %o      格式化无符号八进制数
    %x      格式化无符号十六进制数
    %X      格式化无符号十六进制数（大写）
    %f      格式化浮点数字，可指定小数点后的精度
    %e      用科学计数法格式化浮点数
    %E      作用同%e，用科学计数法格式化浮点数
    %g      根据值的大小决定使用%f或%e
    %G      作用同%g，根据值的大小决定使用%f或%E

实例::

    print('%c' % 97)  # a
    print('%c %c %c' % (97, 98, 99))  # a b c
    print('%d + %d = %d' % (4, 5, 9))  # 4 + 5 = 9
    print("我叫 %s 今年 %d 岁!" % ('小明', 10))  # 我叫 小明 今年 10 岁!
    print('%o' % 10)  # 12
    print('%x' % 10)  # a
    print('%X' % 10)  # A
    print('%f' % 27.658)  # 27.658000
    print('%e' % 27.658)  # 2.765800e+01
    print('%E' % 27.658)  # 2.765800E+01
    print('%g' % 27.658)  # 27.658
    text = "I am %d years old." % 22
    print("I said: %s." % text)  # I said: I am 22 years old..
    print("I said: %r." % text)  # I said: 'I am 22 years old.'

格式化操作符辅助指令::

    符号      功能
    m.n m   是显示的最小总宽度,n 是小数点后的位数（如果可用的话）
    -       用作左对齐
    +       在正数前面显示加号( + )
    #       在八进制数前面显示零('0')，在十六进制前面显示'0x'或者'0X'(取决于用的是'x'还是'X')
    0       显示的数字前面填充'0'而不是默认的空格

实例::

    print('%5.1f' % 27.658)  # ' 27.7'
    print('%.2e' % 27.658)  # 2.77e+01
    print('%10d' % 10)  # '        10'
    print('%-10d' % 10)  # '10        '
    print('%+d' % 10)  # +10
    print('%#o' % 10)  # 0o12
    print('%#x' % 108)  # 0x6c
    print('%010d' % 5)  # 0000000005


字符串提取
==========

提取方法如下::

    用法                      说明
    [ : ]                   提取全部
    [start : ]              提取 start 至結束
    [ : end]                提取开头到 end - 1
    [start : end]           提取 start 至 end - 1
    [start : end : step]    提取 start 至 end - 1，间隔为step (step为负的时候则从右边开始，start与end需反过来摆放)


实例1::

    str = '12345678'
    print str[0:1]
    >> 1             # 输出str位置0开始到位置1以前的字符
    print str[1:6]
    >> 23456         # 输出str位置1开始到位置6以前的字符
    num = 18
    str = '0000' + str(num)# 合并字符串
    print str[-5:]   # 输出字符串右5位
    >> 00018

实例2-索引::

    a = 'bcd'    
    print(a[0]) # 'b' 
    print(a[-1]) # 'd'

实例3-反序排列::

    a = 'abcde'
    print(a[::-1]) #'edcba' 可以变成反序排列
    print(a[-2:0:-1]) #'dcb'



字符串替换-replace
==================

::

    str = 'akakak'
    str = str.replace('k',' 8')      # 将字符串里的k全部替换为8
    print str
    >> 'a8a8a8'# 输出结果

实例1::

    name = 'Henny'
    #name[0] = 'P' #错误!!!!!!
    a = name.replace('H', 'P') #'Penny'
    print(a)
    print('P' + name[1:]) #'Penny'



字符串查找-find
===============

::

    str = 'a,hello'
    print str.find('hello')      # 在字符串str里查找字符串hello
    >> 2# 输出结果

获取字符串长度::

    a = 'abc'
    print(len(a))

检查开头結束字串是否为特定字串，返回True或False::

    poem = 'abcdef'
    print(poem.startswith('ab'))    # True
    print(poem.endswith('eef'))     # False

查搜索索引, 查搜索串个数::

    poem = 'abcdefbcd'
    print(poem.find('bc'))      # 1(第一次出现搜索字串的index)
    print(poem.rfind('bc'))     # 6(最后一次出现搜索字串的index)
    print(poem.count('bc'))     # 2(查询字串出现次数)

查询字符串中是否都是字母或数字，返回True或False::

    poem = 'abc@def'
    print(poem.isalnum())   # False
    
    poem = 'abcdef23'
    print(poem.isalnum())   # True


字符分割-split
==============

实例1::

    str = 'a,b,c,d'
    strlist = str.split(',')     # 用逗号分割str字符串，并保存到列表

实例2::

    todos = 'get gloves,get mask,give cat vitamins,call ambulance'
    print(todos.split(','))
    print(todos.split())   # 默认会切割\n(换行) 、 \t(tab)与空格三种


字符合并-join
=============

实例1::

    sep=":"
    items=sep.join(strlist)
    print items       # 'a:b:c:d'

实例2::

    crypto_list = ['Yeti', 'Bigfoot', 'Loch Ness Monster']
    print(', '.join(crypto_list))

建立重复字符串::

    print('a' * 5) # 'aaaaa'


其他
====

字符串的方法::

    name = 'Swaroop'
    if name.startswith('Swa'):
        print('Yes, the string starts with "Swa"')
    if 'a' in name:
        print('Yes, it contains the string "a"')
    if name.find('war') != -1: #得到字符串里含有子字符串对应的位置,没有为-1
        print('Yes, it contains the string "war"')

    delimiter = '_*_'
    mylist = ['Brazil', 'Russia', 'India', 'China']
    print delimiter.join(mylist)  # Brazil_*_Russia_*_India_*_China

方便的string內建function::

    setup = 'a duck goes into a bar...'
    print(setup.strip('.'))                      #刪除結尾特定符号 'a duck goes into a bar'
    print(setup.capitalize())                    #字串第一個字符大写 'A duck goes into a bar...'
    print(setup.title())                         #每个单词的首字母大写'A Duck Goes Into A Bar...'
    print(setup.upper())                         #全部大写 'A DUCK GOES INTO A BAR...'
    print(setup.lower())                         #全部小写'a duck goes into a bar...'
    print(setup.swapcase())                      #大小写交换 'A DUCK GOES INTO A BAR...'
    print(setup.center(30))                      #将字符串中心移动至30个字符的中间 '  a duck goes into a bar...   '
    print(setup.ljust(30))                       #左对齐 'a duck goes into a bar...     '
    print(setup.rjust(30))                       #右对齐 '     a duck goes into a bar...'
    print(setup.replace('duck', 'marmoset'))     #'a marmoset goes into a bar...'
    print(setup.replace('a ', 'a famous ', 100)) #只替换前100个'a '



说明::

    单引号指示字符串,所有的空白，即空格和制表符都照原样保留
    双引号中的字符串与单引号中的字符串的使用完全相同
    三引号，你可以指示一个多行的字符串;在三引号中自由的使用单引号和双引号

    自然字符串——不需要如转义符那样的特别处理的字符串:

    r"Newlines are indicated by \n"
    # '\\1'或r'\1'一样

    Unicode字符串——国际文本的标准方法(要在字符串前加上前缀u或U)::

    u"This is a Unicode string."







