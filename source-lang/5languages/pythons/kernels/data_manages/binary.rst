.. _python_binary:

二进制
######

bytes and bytearray
===================

bytes 和 bytearray的差別，一个可变一个不可变::

    blist = [1, 2, 3, 255]
    the_bytes = bytes(blist)
    print(the_bytes)      # b'\x01\x02\x03\xff'

    the_byte_array = bytearray(blist)
    print(the_byte_array)   # bytearray(b'\x01\x02\x03\xff')

    the_byte_array[1] = 127 #可变
    print(the_byte_array)   # bytearray(b'\x01\x7f\x03\xff')

使用struct转换二进制文件
========================

使用标准函数库里的struct來作为转换二进制文件::

    < 小端方案
    > 大端方案

+--------+-------------------------+----------+
| 标识符 | 描述                    | 字节     |
+========+=========================+==========+
| x      | 跳过一个字节            | 1        |
+--------+-------------------------+----------+
| b      | 有符号字节              | 1        |
+--------+-------------------------+----------+
| B      | 无符号字节              | 1        |
+--------+-------------------------+----------+
| h      | 有符号短整数            | 2        |
+--------+-------------------------+----------+
| H      | 无符号短整数            | 2        |
+--------+-------------------------+----------+
| i      | 有符号整数              | 4        |
+--------+-------------------------+----------+
| I      | 无符号整数              | 4        |
+--------+-------------------------+----------+
| l      | 有符号长整数            | 4        |
+--------+-------------------------+----------+
| L      | 无符号长整数            | 4        |
+--------+-------------------------+----------+
| Q      | 无符号 long long 型整数 | 8        |
+--------+-------------------------+----------+
| f      | 单精度浮点数            | 4        |
+--------+-------------------------+----------+
| d      | 双精度浮点数            | 8        |
+--------+-------------------------+----------+
| p      | 数量和字符              | 1 + 数量 |
+--------+-------------------------+----------+
| s      | 字符                    | 数量     |
+--------+-------------------------+----------+

实例::

    import struct
    valid_png_header = b'\x89PNG\r\n\x1a\n'   #png的文件头
    data = (b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR' + 
        b'\x00\x00\x00\x9a\x00\x00\x00\x8d\x08\x02\x00\x00\x00\xc0')   #一张图文件的前段
        
    if data[:8] == valid_png_header:
        width, height = struct.unpack('>LL', data[16:24])
        print('Valid PNG, width', width, 'height', height)    # Valid PNG, width 154 height 141
    else:
        print('Not a valid PNG')
        
    #反过来转换
    print(struct.pack('>L', 154))     # b'\x00\x00\x00\x9a'
    print(struct.pack('>L', 141))     # b'\x00\x00\x00\x8d'

    print(data[16:24])    # b'\x00\x00\x00\x9a\x00\x00\x00\x8d'
    print(struct.unpack('>2L', data[16:24]))    # (154, 141)
    print(struct.unpack('>16x2L6x', data))      # (154, 141)

其他二进制工具
==============

* bitstring（ https://code.google.com/p/python-bitstring/ ）
* construct（ http://construct.readthedocs.org/en/latest/ ）
* hachoir（ https://bitbucket.org/haypo/hachoir/wiki/Home ）
* binio（ http://spika.net/py/binio/


binascii函数
============

十六进制、六十四进制、uuencoded，等等之间的转换函数::

    import binascii

    #八字节转十六bytes
    valid_png_header = b'\x89PNG\r\n\x1a\n'
    print(binascii.hexlify(valid_png_header))       # b'89504e470d0a1a0a'

    #十六bytes转八bytes
    print(binascii.unhexlify(b'89504e470d0a1a0a'))  # b'\x89PNG\r\n\x1a\n'







