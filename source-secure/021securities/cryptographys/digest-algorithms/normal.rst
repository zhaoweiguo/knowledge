常用
####


简介::

    别名:
     单向散列函数(one-way hash function)
     消息摘要函数(message digest function)
     哈希函数
     杂凑函数

    散列值:
     哈希值
     密码校验(cryptographic checksum)
     指纹(fingerprint)
     消息摘要(message digest)

    原消息: 原像(pre-image)
    完整性
     等同一致性

特性::

    1. 抗碰撞性(collision resistance)
     鸽巢原理(pigeon-hole principle)
     1.1 强抗碰撞性
        找出相同散列值但互不相同的消息是困难的
     1.2 弱抗碰撞性
        找出和某条消息具备相同散列值的另一消息是困难的

    2. 单向性
     指无法从散列值反算出消息

实际应用::

    PBE(Password Based Encryption)基于口令的加密
    消息认证码
    数字签名
    伪随机数生成器
    一次性口令(one-time password)

常用函数::

    md4:
      Rivest, 1990
      128bit, RFC1186, RFC1320
    md5
      Rivest, 1991
      128bit, RFC1321
    sha-1
      160bit, FIPS, 1993
      1995年列为"谨慎运用的密码清单"
      2005年被山东大学王小云攻破「强抗碰撞性」
      输入数据长度上限2^64-1
    sha-2
      包括 sha256, sha384, sha512
      输入数据长度上限2^128-1
    RIPEMD
      包括 RIPEMD160, RIPEMD128, RIPEMD256, RIPEMD320
      RIPEMD在2004年被攻破「强抗碰撞性」
      RIPEMD160还未被攻破
      比特币使用RIPEMD160
    SHA-3(Secure Hash Algorithm-3)
      公开竞争, NIST, 2012
      胜出者, Keccak
      输入数据长度无上限
      包括 sha3-224, sha3-256, sha3-384, sha3-512

攻击/破解::

    暴力破解:
     从「冗余性」入手
     破解「弱抗碰撞性」
     原像攻击(pre-image Attach)
     第二原像攻击(Second pre-image Attach)

    生日攻击(Birthday Attach):
     冲突攻击(Collision Attach)
     破解「强抗碰撞性」
     23个人就有一半以上的可能有2人生日相同

无法解决的问题::

    能辨别「篡改」不能辨别「伪装」



