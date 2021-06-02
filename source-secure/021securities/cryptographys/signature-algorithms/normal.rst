常用
####


简介::

     由单向散列函数和公钥密码组成
     把公钥密码反过来用实现
    * 私钥加密生成签名
    * 公钥解密验证签名

应用实例::

     安全信息公告
        * 明文签名(clearsign)
     软件下载
     公钥证书
     SSL/TLS

签名算法::

    公钥算法:
       RSA
       EIGamal
       Rabin 方式
    DSA(Digital Signature Algorithm)
      Schnorr算法和 EIGamal方式的变体
      只能用于数字签名
    ECDSA(Elliptic Curve Digital Signature Algorithm)
      1999 年成为 ANSI 标准
      2000 年成为 IEEE 和 NIST 标准
      DSA 算法的一个变体
      ECC 与 DSA 的结合
      ECDSA 签名算法的输入 是 数据的哈希值，而不是数据的本身

攻击::

    中间人攻击(man-in-the-middle attack)
    对单向散列函数攻击
    利用数字签名攻击公钥密码
    潜在伪造
     定义: 没有私钥的前提下，可对无意义的消息生成合法签名，这是对签名算法的潜在威胁
     RSA-PSS(Probabilistic Signature Scheme)
     原理: 对消息的散列值签名
    其他攻击
     暴力破解

无法解决的问题::

    前提: 验证签名的公钥必须是属于真正的发送者
    方法: 让公钥和签名技术成为一种社会性基础设施
    即: 公钥基础设施(Public Key Infrastructure, PKI)




.. image:: /images/encrypts/digital_signature1.png







