转义
####


转义字符是很多程序语言、数据格式和通信协议的形式文法的一部分。对于一个给定的字母表，一个转义字符的目的是开始一个字符序列，使得转义字符开头的该字符序列具有不同于该字符序列单独出现时的语义。因此转义字符开头的字符序列被叫做转义序列。

各种 Escape
===========


Unicode Character Escape Sequences 单码字符转义序列

::

    unicode <-> utf8/gbk <-> string-escape
    unicode <-> unicode-escape


AscII Escape
------------


AscII Escape-常见转义字符::

    \n: 换行
    \t: tab键


string-escape
-------------


string-escape是对二进制的字节流，一个字节一个字节转义，并对每个字节以16进制输出，比如::

    python2>> print "中".encode("string-escape")
    \xe4\xb8\xad  #注意，这是一个字符串'\\xe4\\xb8\\xad'
    # 这里是将"中"的utf-8编码值（E4B8AD）输出成一个可见字符串

    python2>> "中".encode("string-escape")
    '\\xe4\\xb8\\xad'

    python2>> u"中".encode("gbk").encode("string-escape")
    '\\xd6\\xd0'

实例::

    python2>>"\\x41\\x42\\x43\\xe4\\xb8\\xad"
    '\\x41\\x42\\x43\\xe4\\xb8\\xad'
    python2>>len("\\x41\\x42\\x43\\xe4\\xb8\\xad")
    24

    python2>>"\x41\x42\x43\xe4\xb8\xad"
    'ABC\xe4\xb8\xad'
    python2>>len("\x41\x42\x43\xe4\xb8\xad")
    6

unicode-escape
--------------

unicode-escape是对unicode编码的字节流，两个字节两个字节转义，并对每两个字节一起以16进制输出::

    python2>> print u"中".encode("unicode-escape")
    \u4e2d
    这里是将“中”的unicode编码值（4E2D）输出


如果文件中存储的内容是"\x41\x42\x43\xe4\xb8\xad",那么python2程序去读到的是字符串其实是："\\x41\\x42\\x43\\xe4\\xb8\\xad",也就是说，读到的内容，需要先decode("string-escape")，然后再decode("utf-8")::

    python2>>"\x41\x42\x43\xe4\xb8\xad".decode('string-escape').decode('utf-8')
    u'ABC\u4e2d'
    python2>>"\\x41\\x42\\x43\\xe4\\xb8\\xad".decode('string-escape').decode('utf-8')
    u'ABC\u4e2d'

    python2>>print "\x41\x42\x43\xe4\xb8\xad".decode('string-escape').decode('utf-8')
    ABC中
    python2>>print "\\x41\\x42\\x43\\xe4\\xb8\\xad".decode('string-escape').decode('utf-8')
    ABC中

    python2>>"\x41\x42\x43\xe4\xb8\xad".decode("utf-8")
    u'ABC\u4e2d'
    python2>>"\\x41\\x42\\x43\\xe4\\xb8\\xad".decode('utf-8')
    u'\\x41\\x42\\x43\\xe4\\xb8\\xad'

    python2>>print "\x41\x42\x43\xe4\xb8\xad".decode("utf-8")
    ABC中
    python2>>print "\\x41\\x42\\x43\\xe4\\xb8\\xad".decode('utf-8')
    \x41\x42\x43\xe4\xb8\xad


    >>> "中"
    '\xe4\xb8\xad'
    >>> u"中"
    u'\u4e2d'
    >>> u"中".encode('utf-8')
    '\xe4\xb8\xad'
    >>> u'\u4e2d'.encode('utf-8')
    '\xe4\xb8\xad'


nginx实例::

    # nginx日志post类型打印结果
    >>>print "{\x22id\x22:117,\x22name\x22:\x22test-drone\x22,\x22web_url\x22:\x22http://github.com/zhaoweiguo/test-drone\x22}".decode("utf-8")
    {"id":117,"name":"test-drone","web_url":"http://github.com/zhaoweiguo/test-drone"}


其他
----

HTML 转义符、java 转义符、xml 转义符、 oracle 转义符、sql 转义符 、sqlserver 转义符、php 转义符、asp 转义符、vb 转义符、 javascript 转义符等等，还有网址中的百分号。

例如::

    1. HTML:
        &lt;   &gt; &amp;   &quot;  &copy;
        对应:
        <      >     &      "       ©
    2. XML: 只有 5 个转义符: &lt; &gt;&amp; &quot; &apos;


控制字符
========

转义字符不属于控制字符；控制字符也不属于转义字符。如果控制字符的定义是非图形的字符，或者对输出设备（打印机、文本终端）有特殊意义的字符，那么针对这些设备的转义字符也是控制字符。但是程序设计用的转义字符是图形字符，因此它们不是控制字符。相反地，大多数 ASCII 控制字符单独都具有控制功能，因此它们不是转义字符。


参考
=====

* 参考1: https://blog.csdn.net/ggggiqnypgjg/article/details/72783356

