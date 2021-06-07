.. _python_unicode:

Unicode
#######

* \u 加上4位16进制的数字表示Unicode 中的 256 个基本语言，前两位为类别，后两位为索引
* \U 加上8位16进制的数字表示超出上述范围內的字符，最左一位须为0，\N{name}用来指定字符名称 
* 完整清单 [1]_

转换函数
========

unicodedata模块提供了下面两个方向的转换函数::

    lookup() - 接受不区分大小写的标准名称，返回一個Unicode的字符;
    name() - 接受一个的Unicode字符，返回大写形式的名称。

实例::

    def unicode_test(value):
        import unicodedata
        name = unicodedata.name(value)
        value2 = unicodedata.lookup(name)
        print('value="%s", name="%s", value2="%s"' % (value, name, value2))
        
    unicode_test('A')       # value="A", name="LATIN CAPITAL LETTER A", value2="A"
    unicode_test('$')       # value="$", name="DOLLAR SIGN", value2="$"
    unicode_test('\u00a2')  # value="¢", name="CENT SIGN", value2="¢"
    unicode_test('\u20ac')  # value="€", name="EURO SIGN", value2="€"
    unicode_test('\u2603')  # value="☃", name="SNOWMAN", value2="☃"


    # 想知道é这个符号的编码
    place = 'café'
    print(place)
    unicode_test('é')       # value="é", name="LATIN SMALL LETTER E WITH ACUTE", value2="é"
    print('é'.encode('unicode-escape'))   # b'\\xe9'
    unicode_test('\u00e9')  # value="é", name="LATIN SMALL LETTER E WITH ACUTE", value2="é"

使用utf-8进行编码与解码::

    将字符串编码为字节
    将字节解码为字符串

使用encode()来编码字符串成我们看得懂的:

+------------------+-------------------------------------------------------+
| 编码             | 说明                                                  |
+==================+=======================================================+
| 'ascii'          | ASCII 编码                                            |
+------------------+-------------------------------------------------------+
| 'utf-8'          | 最常用的编码                                          |
+------------------+-------------------------------------------------------+
| 'latin-1'        | ISO 8859-1 编码                                       |
+------------------+-------------------------------------------------------+
| 'cp-1252'        | Windows 常用编码                                      |
+------------------+-------------------------------------------------------+
| 'unicode-escape' | Python 中 Unicode 的文本格式， \uxxxx 或者 \Uxxxxxxxx |
+------------------+-------------------------------------------------------+

#编码::

    snowman = '\u2603'
    print(snowman)          # ☃
    print(snowman.encode('unicode-escape'))   # b'\\u2603'
    print(len(snowman))           # 1
    ds = snowman.encode('utf-8')

    print(len(ds))      # 3
    print(ds)           # b'\xe2\x98\x83'
    print('☃')          # ☃


#解码::

    place = 'caf\u00e9'
    print(place)          # café

    place_bytes = place.encode('utf-8')
    print(place_bytes)    # b'caf\xc3\xa9'

    place2 = place_bytes.decode('utf-8')
    print(place2)         # café











.. [1] http://www.unicode.org/charts/charindex.html