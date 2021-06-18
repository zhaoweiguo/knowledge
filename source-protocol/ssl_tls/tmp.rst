临时
#######


密钥交换算法有 RSA 和 ECDHE：RSA 历史悠久，支持度好，但不支持 PFS（Perfect Forward Secrecy）；而 ECDHE 是使用了 ECC（椭圆曲线）的 DH（Diffie-Hellman）算法，计算速度快，支持 PFS



::

    ALPN, server did not agree to a protocol
    ALPN, server agreed to some http protocol; TLS informed
    ALPN, server agreed to some http protocol; TLS ok.
    
    $> curl -v https://http2.golang.org
    ALPN, server accepted to use h2


tls 协议的实现有多种，如::

    openssl, gnutls, nss, libressl, cyassl, polarssl, botan

    openssl 的代码算是其中最混乱的，但是也是最久经考验的。 
    请参见此打脸文： http://blog.csdn.net/dog250/article/details/24552307
    
    个人觉得 polarssl 和 botan 的架构最清晰，代码风格清新可爱，便于学习理解协议
    但是不建议在生产环境下用，例如 polarssl 功能尚有欠缺


SSL/TLS 握手协议:

.. uml:: ./encrypts-handshake.puml


国密
====

国密证书::

    这里的国密证书指的是使用国密算法（SM2-with-SM3）的标准 X509 格式证书，
    证书使用 SM3 作为哈希算法，使用 SM2 作为数字签名算法

国密 SSL::
    
    采用国密算法，符合国密标准的安全传输协议，也就是 SSL/TLS 协议的国密版本



参考
====

* https://blog.helong.info/blog/2015/01/23/ssl_tls_ciphersuite_intro/



