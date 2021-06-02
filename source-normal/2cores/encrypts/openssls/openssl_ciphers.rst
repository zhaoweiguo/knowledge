openssl ciphers命令
###################

支持的 CipherSuite 列表::

    $ openssl ciphers -V | column -t



看一下 EECDH+AES128 具体包含哪些 Cipher Suites::

    $ openssl ciphers -V 'EECDH+AES128' | column -t
    0xC0,0x2B  -  ECDHE-ECDSA-AES128-GCM-SHA256  TLSv1.2  Kx=ECDH  Au=ECDSA  Enc=AESGCM(128)   Mac=AEAD
    0xC0,0x2F  -  ECDHE-RSA-AES128-GCM-SHA256    TLSv1.2  Kx=ECDH  Au=RSA    Enc=AESGCM(128)   Mac=AEAD
    0xC0,0xAE  -  ECDHE-ECDSA-AES128-CCM8        TLSv1.2  Kx=ECDH  Au=ECDSA  Enc=AESCCM8(128)  Mac=AEAD
    0xC0,0xAC  -  ECDHE-ECDSA-AES128-CCM         TLSv1.2  Kx=ECDH  Au=ECDSA  Enc=AESCCM(128)   Mac=AEAD
    0xC0,0x23  -  ECDHE-ECDSA-AES128-SHA256      TLSv1.2  Kx=ECDH  Au=ECDSA  Enc=AES(128)      Mac=SHA256
    0xC0,0x27  -  ECDHE-RSA-AES128-SHA256        TLSv1.2  Kx=ECDH  Au=RSA    Enc=AES(128)      Mac=SHA256
    0xC0,0x09  -  ECDHE-ECDSA-AES128-SHA         TLSv1    Kx=ECDH  Au=ECDSA  Enc=AES(128)      Mac=SHA1
    0xC0,0x13  -  ECDHE-RSA-AES128-SHA           TLSv1    Kx=ECDH  Au=RSA    Enc=AES(128)      Mac=SHA1

说明::

    第 1 个字段是 这个 CipherSuite 的 value，
    第 2 个字段是 CipherSuite 的名字 ，
    第 3 个字段是本 Cipher Suite 是用于哪个 SSL/TLS 版本的协议，
    第 4 个字段 Kx 是 key exchange 算法
    第 5 个字段 Au 是 authentication 算法
    第 6 个字段 Enc 是 encryptation 算法
    第 7 个字段 Mac 是 MAC 算法，用于创建消息摘要


看一下 EECDH+CHACHA20 具体包含哪些 Cipher Suites::

    $ openssl ciphers -V 'EECDH+CHACHA20' | column -t
    0xCC,0xA9  -  ECDHE-ECDSA-CHACHA20-POLY1305  TLSv1.2  Kx=ECDH  Au=ECDSA  Enc=CHACHA20/POLY1305(256)  Mac=AEAD
    0xCC,0xA8  -  ECDHE-RSA-CHACHA20-POLY1305    TLSv1.2  Kx=ECDH  Au=RSA    Enc=CHACHA20/POLY1305(256)  Mac=AEAD



Cipher Suites::

    ECDHE+CHACHA20:ECDHE+CHACHA20-draft:ECDSA+AES128:ECDHE+AES128:RSA+AES128:RSA+3DES


    ssl_protocols TLSv1 TLSv1.1 TLSv1.2; 
    ssl_ciphers ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS; 
    ssl_prefer_server_ciphers on;


    加密套件解读： 
    ECDHE-RSA-AES128-GCM-SHA256 为例

    ECDHE：秘钥交换算法
    RSA：签名算法
    AES128：对称加密算法
    GCM-SHA256：签名算法

    默认项： 
    秘钥交换算法：RSA 
    签名算法：RSA 
    模式：CBC 
    AES256-SHA256 也就是 RSA-RSA-AES256-CBC-SHA256


.. note:: 这 5 类算法组合在一起，称为一个 CipherSuite： 
    1. authentication (认证算法) 
    2. encryption (加密算法 ) 
    3. message authentication code (消息认证码算法 简称 MAC) 
    4. key exchange (密钥交换算法) 
    5. key derivation function （密钥衍生算法)


要禁用
======


EXP , EXPORT::

    一定要禁用。
    EXPORT 表示上世纪美国出口限制弱化过的算法，早已经被攻破，TLS 的 FREAK 攻击就是利用了这类坑爹的算法。

eNULL, NULL::

    一定要禁用。
    NULL 表示不加密！默认是禁用的。 

aNULL::

    一定要禁用。
    表示不做认证 (authentication) ，也就是说可以随意做中间人攻击。

ADH::

    一定要禁用。
    表示不做认证的 DH 密钥协商。





参考
====

* Linux man page: https://linux.die.net/man/1/ciphers
* SSL/TLS CipherSuite 介绍: https://blog.helong.info/blog/2015/01/23/ssl_tls_ciphersuite_intro/
* https://blog.helong.info/blog/2015/09/06/tls-protocol-analysis-and-crypto-protocol-design/
* https://wiki.mozilla.org/Security/Server_Side_TLS

