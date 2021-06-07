.. _python_regex:

正则表达式
##########

#从标准函数库引入::

    import re


+----------------------------------------+--------------------------------------------------------------+
| function                               | 功能                                                         |
+========================================+==============================================================+
| re.match( pattern, source )            | 查看字串是否以规定的规则开头                                 |
+----------------------------------------+--------------------------------------------------------------+
| re.search( pattern, source )           | 会返回第一次成功的匹配值 (如果有成功)                        |
+----------------------------------------+--------------------------------------------------------------+
| re.findall( pattern, source)           | 会返回所有成功且不重复的匹配值 (如果有成功)                  |
+----------------------------------------+--------------------------------------------------------------+
| re.split( pattern, source )            | 会根据 规则 将 字符串 切分成若干段，返回由这些片段组成的list |
+----------------------------------------+--------------------------------------------------------------+
| re.sub( pattern, replacement, source ) | 把 字串 中所有匹配规则的字串 替換成 replacement              |
+----------------------------------------+--------------------------------------------------------------+

实例::

    import re
    # .group()可以叫出符合正则表达式的字符串部分

    print('----------match----------')
    # 检查'Young Frankenstein'是否以'You'开头
    result = re.match('You', 'Young Frankenstein')
    if result:
        print(result.group())   # You


    print('\n----------compile后match----------')
    # 针对较复杂情況可以先编译一个对象出來加速判断
    youpattern = re.compile('You')
    result = youpattern.match('Young Frankenstein')
    print(result)
    if result:
        print(result.group())   # You

    print('\n----------match使用.*找任何位置----------')
    # "."为除「\n」之外的任何单个字符。  "*"为符合前面的子运算式零次或多次。
    # 组合在一起则成为匹配任意长度任意字元(除「\n」)的规则
    m = re.match('.*Frank', 'Young Frankenstein')
    if m:
        print(m.group())    # Young Frank

    print('\n----------search----------')
    # 可以不用通过".*"來找任意位置的符合值
    m = re.search('Frank', 'Young Frankenstein')
    if m: # search返回物件
        print(m.group())    # Frank
        
    print('\n----------findall----------')
    # 寻找所有符合的
    m = re.findall('n', 'Young Frankenstein')
    print(m) # findall返回了一个列表       # ['n', 'n', 'n', 'n']
    print('共找到', len(m), '个符合值\n')  # 4

    #寻找后方至少有一个字符的
    m = re.findall('n..', 'Young Frankensteinanbcdefn')
    print(m) # findall返回了一个列表: ['ng ', 'nke', 'nst', 'nan']

    #寻找后方有一个字符(可以沒有)的
    m = re.findall('n.?', 'Young Frankenstein')
    print(m) # findall返回了一个列表: ['ng', 'nk', 'ns', 'n']

    print('\n----------split----------')
    # 利用规格做切割字符串
    m = re.split('n', 'Young Frankenstein')
    print(m) # split返回了一个列表: ['You', 'g Fra', 'ke', 'stei', '']

    print('\n----------sub----------')
    # 利用字符串替换字符串
    m = re.sub('n', '?', 'Young Frankenstein')
    print(m) # sub返回了一个列表: You?g Fra?ke?stei?


    #寻找英文单词边界
    m = re.findall(r'\bFra', 'Young Frankenstein')
    print(m) # findall返回了一个列表: ['Fra']



+----------+-------------------------------------------------------------+
| 特殊字元 | 功能                                                        |
+==========+=============================================================+
| .        | 代表任意除 \n 外的字符                                      |
+----------+-------------------------------------------------------------+
| \*       | 表示任意多个字符(包括 0 个)                                 |
+----------+-------------------------------------------------------------+
| ?        | 表示可选字符( 0 个或 1 个)                                  |
+----------+-------------------------------------------------------------+
| \d       | 一个数字字符。等价于[0-9]                                   |
+----------+-------------------------------------------------------------+
| \D       | 一个非数字字符。等价于[^0-9]                                |
+----------+-------------------------------------------------------------+
| \w       | 一个 字母 或 数字 包括下划线字符。等价于 ``[ A-Za-z0-9_ ]`` |
+----------+-------------------------------------------------------------+
| \W       | 一个 非字母 非数字 非下划线字符。等价于 ``[ ^A-Za-z0-9_ ]`` |
+----------+-------------------------------------------------------------+
| \s       | 空白字元。等价于[ \f\n\r\t\v ]                              |
+----------+-------------------------------------------------------------+
| \S       | 非空白字元。等价于[ ^ \f\n\r\t\v ]                          |
+----------+-------------------------------------------------------------+
| \b       | 单词边界（一个 \w 与 \W 之间的范围，顺序可逆）              |
+----------+-------------------------------------------------------------+
| \B       | 非单词边界                                                  |
+----------+-------------------------------------------------------------+



实例2::

    import string
    # 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c'
    printable = string.printable    # 100个ASCII字符
    len(printable)    # 100

    print(printable[0:50])    # 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMN
    print(printable[50:])     # OPQRSTUVWXYZ!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~

    print(re.findall('\d', printable))  #找数字
    print(re.findall('\w', printable))  #找字母与数字
    print(re.findall('\s', printable))  #找空白

实例3::

    source = '''I wish I may, I wish I might
    ... Have a dish of fish tonight。'''

    # 1. 找wish
    print("1.", re.findall('wish', source))

    # 2. 找wish或fish
    print("2.", re.findall('wish|fish', source))

    # 3. 找wish开头
    print("3.", re.findall('^wish', source))

    # 4. 找I wish开头
    print("4.", re.findall('^I wish', source))

    # 5. 找fish结束
    print("5.", re.findall('fish$', source))

    # 6. 找fish tonight(后面可以有无一个字符)
    print("6.", re.findall('fish tonight.$', source))

    # 7. 找fish tonight.(使用转义字符，表示\.为一个点而不是万用字符)
    print("7.", re.findall('fish tonight\.$', source))

    # 8. 找wish与fish
    print("8.", re.findall('[wf]ish', source))

    # 9. 找w、s、h组合出來的字串
    print("9.", re.findall('[wsh]+', source))

    # 10. 找ght开头，后面接着非字母 非数字 非下划线字元
    print("10.", re.findall('ght\W', source))

    # 11. 找I开头，后面是wish，但只返回前面
    print("11.", re.findall('I (?=wish)', source))

    # 12. 找前面开头是I的wish，只返回后面
    print("12.", re.findall('(?<=I) wish', source))

    # 13. 原定希望找到fish然后前面是单词的地方，但是\b被当做是转义字符返回符号了
    print("13.", re.findall('\bfish', source))

    # 14. 所以采用r來声明说我这是一个原始的字符串，不需要自动转换
    print("14.", re.findall(r'\bfish', source))


    print('\n--------------------')
    #用括号规则做区分后可以通过groups()取得分开的tuple，並且可以通过<name>设定名称
    m = re.search(r'(. dish\b).*(\bfish)', source)
    print(m.group())
    print(m.groups())


    m = re.search(r'(?P<DISH>. dish\b).*(?P<FISH>\bfish)', source)
    print(m.group())
    print(m.groups())

    print(m.group('DISH'))
    print(m.group('FISH'))









