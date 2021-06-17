md5摘要算法
###############

MD5对文件或字符串加密::

    $ cat filename.txt 
    zhaohang

    $ openssl md5 filename.txt 
    MD5(filename.txt)= c47df1e95ae452e959fcc73cda1a3e77

    $ echo "zhaohang" |openssl dgst -md5
    c47df1e95ae452e959fcc73cda1a3e77

    $ md5sum filename.txt 
    c47df1e95ae452e959fcc73cda1a3e77 filename.txt





md5不安全
=========

* 早在 2010 年，美国软件工程学会 (SEI) 就认为 MD5 算法已被破解，不再适用::
    
    "cryptographically broken and unsuitable for further use"
    MD5 函数过去通常用于数据的完整性校验和用户密码的加密保存

数据完整性校验
--------------

软件完整性::

    通常软件签名不会对整个软件签名，而是对软件的 HASH 值签名
    在网络上下载软件，为确保软件没被修改，常常使用 MD5 值做校验完整性

开放 API::

    为了防止用户修改 API 请求的参数，API 提供商常常使用ＭＤ５值校验请求的完整性

.. note:: 以上应用都是建立在 MD5 函数不碰撞的基础上，而这个基础已不可靠，因为构造一个 MD5 碰撞已不难

历史::

    2005 年山东大学的王小云教授发布算法可以轻易构造ＭＤ５碰撞实例，
    此后 2007 年，有国外学者在王小云教授算法的基础上，提出了
    更进一步的 MD5 前缀碰撞构造算法 “chosen prefix collision”
    此后还有专家提供了 MD5 碰撞构造的开源的库。
    所以 MD5 碰撞很容易构造，基于 MD5 来验证数据完整性已不可靠


以下是简单的 MD5 碰撞实例:

.. literalinclude:: /files/encrypts/example-md5.php
   :language: php
   :linenos:

用户密码加密保存
----------------

MD5 (密码 + 盐值)的问题::

    1. 对于黑客入侵或是内部员工，能拿到用户数据的人，很容易就拿到盐值
    2. 虽然黑客不能反解密码，但黑客可通过排列组合一个一个的试，暴力破解
        甚至有 md5 加密库


.. note:: MD5 不行，SHA1 也被谷歌破解了，SHA256 密码加盐值这样可靠了吧？SHA256 密码加盐值也不安全。摘要算法就不是用来保存密码用的， 是用来校验数据完整性用的。密码的正确的做法是使用 bcrypt 算法，bcrypt 算法的优点是计算速度慢，还可以通过参数调节速度，要多慢有多慢。普通的电脑每秒可运行数万次 SHA256 计算，bcypt 算法通过参数设置可以调整为计算一次耗时 1 秒。这样大幅提高了暴力破解的门槛，增强了安全性。







参考
====

* 为安全计，请不要再使用 md5: https://www.jianshu.com/p/e8411418d8cc

