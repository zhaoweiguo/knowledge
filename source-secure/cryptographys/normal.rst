其他
####

密码学::

    * 块加密算法 block cipher: AES, Serpent, 
    * 流加密算法 stream cipher: RC4，ChaCha20 
    * Hash 函数 hash funtion:MD5，sha1，sha256，sha512 , ripemd 160，poly1305 
    * 消息验证码函数 message authentication code: HMAC-sha256，AEAD 
    * 密钥交换 key exchange: DH，ECDH，RSA，PFS 方式的（DHE，ECDHE）
    * 公钥加密 public-key encryption: RSA，rabin-williams 
    * 数字签名算法 signature algorithm:RSA，DSA，ECDSA (secp256r1 , ed25519) 
    * 密码衍生函数 key derivation function: TLS-12-PRF (SHA-256) , bcrypto，scrypto，pbkdf2 
    * 随机数生成器 random number generators: /dev/urandom 

历史::

    密码
     恺撒密码(Caesar cipher)
     简单替换密码
     Enigma: 二战、德国
    破译密码
     暴力攻击
     频率分析

一次性密码本::

    无法破译
     即便能解密出有意义的句子也无法判断是否是正确明文
     1917年维纳(G.S. Vernam)
     香农(C.E. Shannon)1949年用数学方法证明无法破译
     无条件安全(unconditionally secure)
     理论无法破译(theoretically unbreakable)
    发展
     只有超机密的场合才用(成本太高)
     思路孕育出流密码(stream cipher)

攻击手段::

    中间人攻击(man-in-the-middle attack)
    选择密文攻击(Chosen Ciphertext Attack)
     RSA-OAEP(Optimal Asymmetric Encryption Padding)
     最优非对称加密填充

密码强度::

    256bit 的 AES 与15360bit的 RSA 具有均衡的强度
    NIST 密码强度比较表
    密码劣化
     技术进步导致之前安全的密码被破译

其他密码组::

    电子投票
    盲签名(blind signature)
     在不知道内容的情况下签名
    零知识证明(zero-knowledge proof)
     不将信息发送给对方的前提下证明自己拥有该信息

前/后向安全::

    前向安全(Forward Secrecy, FS)
     强前向安全 (Strong Backward Secrecy): 后面进来的人即时知道之前的信息，但是无法解密。
     弱前向安全 (Weak Backward Secrecy): 后面进来的人完全不知道之前有过什么信息。
     完美前向保密(perfect forward secrecy)
    后向安全(Backward Secrecy, BS)
     强后向安全 (Strong Forward Secrecy): 前面进来的人，虽然能获取信息，但是无法解密。
     弱后向安全 (Weak Forward Secrecy): 前面进来的人，无法获知后面发出的信息。
    TLS实现前向安全的密钥交换
     理论: 一组密钥对长期保留，仅用于签名与校验；生成临时密钥对用于密钥交换，临时密钥对用后销毁

总结::

    密钥是机密性的精华
    散列值是完整性的精华
    认证符号(MAC 值和签名)是认证的精华
    种子是不可预测的精华


安全通信的几个核心::

    数据保密性(message privacy)message privacy)
    数据完整性(message integrity)
    身份认证(mutual authentication)
    Data origin authentication
    抗抵赖性




参考
====

https://blog.csdn.net/mrpre/category_9270159.html


