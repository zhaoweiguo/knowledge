常用
####

简介::

    非对称加密(Asymmetric cryptography)
    密钥有这么一个特性：通过公钥很难计算得到私钥
    又称：公钥基础结构，又称 PKI

    密钥配送问题
     1. 事先共享密码
     2. 密钥分配中心
     3. Diffie-Hellman 密钥交换
     4. 公钥密码

RSA::

    简介:
     1977 年
     作者:
      * 麻省理工学院三位数学家Rivest、Shamir 和 Adleman
      * 罗纳德・李维斯特（Ron Rivest）
      * 阿迪・萨莫尔（Adi Shamir）
      * 伦纳德・阿德曼（Leonard Adleman）

    算法:
     加密: 密文=明文^E mod N
     公钥: E 和 N 的组合
     解密: 明文=密文^D mod N
     私钥: D 和 N 的组合

    说明:
     对极大整数做因数分解的难度决定了RSA算法的可靠性
     第一个能同时用于加密和数字签名的算法
     速度是对应同样安全级别的对称密码算法的1/1000左右

    缺点:
     前向不安全
      * 私钥参与了密钥交换
      * 安全性取决于私钥是否安全保存

其他变种::

    1. EIGamal 方式:
        与 RSA 不同的点在使用『离散对数』
        密文长度是明文的2倍
    2. Rabin方式
     与 RSA 不同的点在使用『平方根』

    3. ECC(椭圆曲线密码, Elliptic Curve Cryptography):
    1985 年, 作者:Neal Koblitz 和 Victor Miller

DH/DHE(Diffie-Hellman key exchange)::

    简介:
      DH 是 Diffie-Hellman 的首字母缩写
      1976 年, 作者: Whitfield Diffie 与 Martin Hellman
      开创了公钥密码学的先河
    * 密钥协商协议
    * 离散对数系统

    理论:
      * 模幂运算
      * 私钥不参与密钥的协商

    效率:
      * ECC 能够比 RSA 提供更高的安全性
      * 160bit的椭圆曲线密钥和 1024bit的 RSA 密钥的安全性相当
      * 越小的密钥在速度、效率、带宽、存储上有着许多优势

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





