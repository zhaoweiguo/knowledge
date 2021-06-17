.. _base64:

baseXX命令使用
##########################

* 常用的Base64算法的实现有三种方式::
  
    1. 第一种是sun公司提供的Base64算法
    2. 第二种是bouncycastle提供的加密算法（以下简称BC包）
    3. 第三种是apache的codec包（以下简称codec包）
       
其中codec提供了 :ref:`RFC2045 <rfc2045>` 标准的Base64实现，每76个字符加一个换行符，如果当前行不足76个字符，也要在最后加上加换行符！

说明::

    Base64是常见的可读性编码算法，所谓Base64，即是说在编码过程中使用了64种字符:
        大写A到Z、小写a到z、数字0到9、“+”和“/”

    Base58是Bitcoin中使用的一种编码方式，主要用于产生Bitcoin的钱包地址。
    相比Base64，Base58不使用数字"0"，字母大写"O"，字母大写"I"，和字母小写"i"，以及"+"和"/"符号。

    IPFS 也使用了 Base58


加密::

    base64 <file>
    echo "<str>" | base64

    // 让base64输出在单行上，避免折行
    cat ~/.docker/config.json |base64 -w 0


解密::

    base64 -d <file>
    echo "<str>" | base64 -d


openssl base64::

    $ echo "zhaohang" |openssl base64
    $ echo "emhhb2hhbmcK" |openssl base64 -d



Shell中使用
-----------

base64 命令::

    $ echo "you are so cool"|base64
    eW91IGFyZSBzbyBjb29sCg==

    $ echo "eW91IGFyZSBzbyBjb29sCg=="|base64 -d
    you are so cool
    //中文
    $ echo "你真帅"|base64
    5L2g55yf5biFCg==

    $ echo "5L2g55yf5biFCg=="|base64 -d
    你真帅

openssl命令::

    $ openssl enc -base64 <<< "good boy"
    Z29vZCBib3kK

    $ openssl enc -base64 -d <<< "Z29vZCBib3kK"
    good boy

Python 使用base64
-----------------
编码 和 解码::

    $ python -c "import base64; print base64.b64encode('you are so cool')"
    eW91IGFyZSBzbyBjb29s

    $ python -c "import base64; print base64.b64decode('eW91IGFyZSBzbyBjb29s')"
    you are so cool

注意无法对unicode直接base64编码, 所以请注意字符编码问题::

    $ python -c "import base64; print base64.b64encode('酷')"
    6YW3

    $ python -c "import base64; print base64.b64encode(u'酷')"
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/base64.py", line 53, in b64encode
        encoded = binascii.b2a_base64(s)[:-1]
    UnicodeEncodeError: 'ascii' codec can't encode characters in position 0-2: ordinal not in range(128)






