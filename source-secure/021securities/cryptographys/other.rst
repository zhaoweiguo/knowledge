其他
####


PGP::

    信任网(web of trust)
     要点: 不依赖认证机构，而是建立每个人间的信任关系
     场景:
    * 1. 通过自己的数字签名确认
    * 2. 通过自己完全信任的人的数字签名确认
    * 3. 通过自己有限信任的多个人的数字签名确认

SSL/TLS::

    通信协议
       层次化的协议
       TLS 记录协议(TLS record protocol)
       TLS 握手协议(TLS handshake protocol)
      * 握手协议
      * 密码规格变更协议
      * 警告协议
      * 应用数据协议
    对 SSL/TLS 攻击
       对各密码技术攻击
       OpenSSL 心脏出血漏洞
       SSL3.0漏洞与 POODLE攻击
       PREAK攻击
      * 美国密码管制
       对伪随机数生成器的攻击
       利用证书的时间差进行攻击

其他
====

历史::

    密码
     恺撒密码(Caesar cipher)
     简单替换密码
     Enigma
    * 二战、德国
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


Cipher Suites
=============

默认项::

    秘钥交换算法：RSA
    签名算法：RSA
    模式：CBC

authentication (认证) 算法::

    RSA/DSA/ECDSA 3 种

encryption加密算法::

    主流趋势是使用 aes
    RC4（不建议使用）
    3DES（不建议使用）
    DES(已经被淘汰)

message authentication code 算法::

    消息认证码 简称 MAC
    主流有 sha256,sha384,sha1, 等
    tls 中使用了 HMAC 模式，而不是原始的 sha256,sha1 等

key exchange (密钥交换) 算法::

    主流有两种：DH 和 ECDH
    现在普遍流行 PFS，把 DH, ECDH 变成 DHE，ECDHE




SSL/TLS
=======

3 种功能::

    数据保密性
    数据完整性
    身份认证

核心::

    在不安全信道上构建安全信道
    所谓安全包括身份认证、数据完整性、数据加密性

说明::

    非对称算法在 SSL 中的运用就是为了协商一个密钥
    密钥的目的就是为了后续数据能够被加密
    加密密钥有且只有通信双方知道

历史::

    1995: SSL 2.0, 由 Netscape 提出，这个版本由于设计缺陷，并不安全，很快被发现有严重漏洞，已经废弃
    1996: SSL 3.0. 写成 RFC，开始流行。已经不安全，必须禁用
    1999: TLS 1.0. 互联网标准化组织 ISOC 接替 NetScape 公司，发布了 SSL 的升级版 TLS 1.0 版
    2006: TLS 1.1. 作为 RFC 4346 发布。主要 fix 了 CBC 模式相关的如 BEAST 攻击等漏洞
    2008: TLS 1.2. 作为 RFC 5246 发布 。增进安全性。
    2015 之后: TLS 1.3，支持 0-rtt，大幅增进安全性，砍掉了 aead 之外的加密方式

安全通信的几个核心::

    数据保密性(message privacy)message privacy)
    数据完整性(message integrity)
    身份认证(mutual authentication)
    Data origin authentication
    抗抵赖性

密码学
======


* 块加密算法 block cipher: AES, Serpent, 
* 流加密算法 stream cipher: RC4，ChaCha20 
* Hash 函数 hash funtion:MD5，sha1，sha256，sha512 , ripemd 160，poly1305 
* 消息验证码函数 message authentication code: HMAC-sha256，AEAD 
* 密钥交换 key exchange: DH，ECDH，RSA，PFS 方式的（DHE，ECDHE）
* 公钥加密 public-key encryption: RSA，rabin-williams 
* 数字签名算法 signature algorithm:RSA，DSA，ECDSA (secp256r1 , ed25519) 
* 密码衍生函数 key derivation function: TLS-12-PRF (SHA-256) , bcrypto，scrypto，pbkdf2 
* 随机数生成器 random number generators: /dev/urandom 





