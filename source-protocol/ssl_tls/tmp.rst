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

CA 证书颁发机构::

    1. DigiCert（原Symantec）
        . DigiCert是业界更受信任且广受尊重的高保障度证书提供商;
        . 为89%的财富500强企业、全球前100大银行中的97家银行以及全球87％的加密电子商务交易提供保护。
    2. GeoTrust
        . GeoTrust是DigiCert旗下子品牌;
        . 服务150多个国家和地区的10万多名客户，受世界各地、各类规模企业及组织信赖；
        . GeoTrust 品牌证书覆盖各类加密等级，性价比高，满足企业任何预算需求。
    3. GlobalSign
        . GlobalSign是全球权威的数字证书颁发机构（CA）之一；
        . 淘宝/天猫正在使用的同款品牌证书，全线产品支持RSA/ECC加密算法；
        . 专业版OV单域名证书支持公网IP申请；
        . 尤其适用于电子商务、直播、在线教育类企业网站，及对网站有双算法部署需求的企业用户。
    4. CFCA（国产）
        . 中国金融认证中心（China Financial Certification Authority，简称CFCA）
            是经中国人民银行和国家信息安全管理机构批准成立的国家级权威安全机构；
        . 纯国产数字证书品牌，满足政府/金融等组织、机构国家监管需求；
        . OCSP服务器本地化部署，有效提升HTTPS网站访问速度；
        . 支持安卓6.0和IOS10.1及以上版本，含小程序。




参考
====

* https://blog.helong.info/blog/2015/01/23/ssl_tls_ciphersuite_intro/



