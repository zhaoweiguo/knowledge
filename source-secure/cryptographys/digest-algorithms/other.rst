其他
####


md4
===

MD4（RFC 1320）是 MIT 的 Ronald L. Rivest 在 1990 年设计的，MD 是 Message Digest 的缩写。其输出为 128 位。

.. note:: MD4 已证明不够安全。



::

    Rivest, 1990
    128bit, RFC1186, RFC1320


SHA1
====

.. note:: SHA1 已经不够安全，推荐至少使用 SHA2-256 算法。

1995 年NIST发布了 SHA-1，它的输出为长度 160 位的 hash 值，因此抗穷举性更好。


sha-1::

    160bit, FIPS, 1993
    1995年列为"谨慎运用的密码清单"
    2005年被山东大学王小云攻破「强抗碰撞性」
    输入数据长度上限2^64-1

RIPEMD
======

::

    包括 RIPEMD160, RIPEMD128, RIPEMD256, RIPEMD320
    RIPEMD在2004年被攻破「强抗碰撞性」
    RIPEMD160还未被攻破
    比特币使用RIPEMD160





