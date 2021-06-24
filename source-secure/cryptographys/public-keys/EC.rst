EC
###


ECDH/ECDHE::

    简介:
      点乘运算, 密钥协商协议
      椭圆曲线 Diffie-Hellman密钥交换
      DH 是 Diffie-Hellman
    
    说明:
      ECDH: 前向不安全(已经被 OpenSSL 废弃)
      ECDHE: 前向安全（forward secrity）
      E 代表着「短暂的」，是指交换的密钥是暂时的动态的
      使用离散对数问题来解决秘钥协商的难题
      基于椭圆曲线的离散对数问题（ECDLP）

ECDSA::

    椭圆曲线 DSA



椭圆曲线密码算法::

    Elliptic Curve Cryptography椭圆曲线密码
    优点:
        1.短的密钥长度
        2.所有用户可以选择同一基域上不同的椭圆曲线，

Secp256k1椭圆曲线::

    比特币使用此曲线
    注：@todo 这块比较难，很暂空着



