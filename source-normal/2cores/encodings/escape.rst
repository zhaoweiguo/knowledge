转义
####


Unicode Character Escape Sequences 单码字符转义序列

::

    unicode <-> utf8/gbk <-> string-escape
    unicode <-> unicode-escape


string-escape是对二进制的字节流，一个字节一个字节转义，并对每个字节以16进制输出，比如::

    python2>> print "中".encode("string-escape")
    \xe4\xb8\xad  #注意，这是一个字符串'\\xe4\\xb8\\xad'
    # 这里是将"中"的utf-8编码值（E4B8AD）输出成一个可见字符串

    python2>> "中".encode("string-escape")
    '\\xe4\\xb8\\xad'

    python2>> u"中".encode("gbk").encode("string-escape")
    '\\xd6\\xd0'

unicode-escape是对unicode编码的字节流，两个字节两个字节转义，并对每两个字节一起以16进制输出::

    python2>> print u"中".encode("unicode-escape")
    \u4e2d
    这里是将“中”的unicode编码值（4E2D）输出

实例::

    python2>>"\\x41\\x42\\x43\\xe4\\xb8\\xad"
    '\\x41\\x42\\x43\\xe4\\xb8\\xad'
    python2>>len("\\x41\\x42\\x43\\xe4\\xb8\\xad")
    24

    python2>>"\x41\x42\x43\xe4\xb8\xad"
    'ABC\xe4\xb8\xad'
    python2>>len("\x41\x42\x43\xe4\xb8\xad")
    6


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





参考
=====

* 参考1: https://blog.csdn.net/ggggiqnypgjg/article/details/72783356

