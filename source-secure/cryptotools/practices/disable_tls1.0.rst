.. _practice_disable_tls1.0:

网站如何禁止tls1.0漏洞
######################

确定当前网站是支持tls1.0::

    // 使用tls1.0协议验证
    $ openssl s_client -connect  www.zhaoweiguo.com.cn:443 -tls1

    CONNECTED(00000005)
    depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
    verify return:1
    depth=1 C = US, O = DigiCert Inc, CN = DigiCert SHA2 Secure Server CA
    verify return:1
    depth=0 C = CN, L = Beijing, O = Xinxi (Beijing) Limited, OU = IT, CN = *.xinxi.com.cn
    verify return:1
    ---
    Certificate chain
     0 s:/C=CN/L=Beijing/O=Xinxi (Beijing) Limited/OU=IT/CN=*.xinxi.com.cn
       i:/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA
     1 s:/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA
       i:/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert Global Root CA
    ---
    Server certificate
    -----BEGIN CERTIFICATE-----
    MIIGmDCCBYCgAwIBAgIQAt... ... ...
    -----END CERTIFICATE-----
    subject=/C=CN/L=Beijing/O=Xinxi (Beijing) Limited/OU=IT/CN=*.xinxi.com.cn
    issuer=/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA
    ---
    No client certificate CA names sent
    Server Temp Key: ECDH, X25519, 253 bits
    ---
    SSL handshake has read 3514 bytes and written 219 bytes
    ---
    New, TLSv1/SSLv3, Cipher is ECDHE-RSA-AES128-SHA
    Server public key is 2048 bit
    Secure Renegotiation IS supported
    Compression: NONE
    Expansion: NONE
    No ALPN negotiated
    SSL-Session:
        Protocol  : TLSv1
        Cipher    : ECDHE-RSA-AES128-SHA
        Session-ID: E09589BBA910C56FB562AB37A043221DB34712CA52105D03645474558C4BAADF
        Session-ID-ctx:
        Master-Key: 4D10630D9BB98F1718092AD6994DDD4C9E37BC3D77EFE5DAD36B62F2B005962701BA369CCB8607E3A478B0B5BA7585ED
        TLS session ticket lifetime hint: 300 (seconds)
        TLS session ticket:
        0000 - 70 65 51 50 53 63 37 4f-46 55 49 5a 6e 42 38 4a   peQPSc7OFUIZnB8J
        Start Time: 1572851892
        Timeout   : 7200 (sec)
        Verify return code: 0 (ok)
    ---

解决::

    解决还是简单的:
    1. 使用阿里slb:
    slb -> 指定实例 -> 监听 -> 管理证书 -> 高级 -> TLS安全策略
    2. 使用nginx:
    修改
    ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
    为
    ssl_protocols TLSv1.2 TLSv1.1;

.. image:: /images/alis/slbs/slb_cert_tls1.0.png
   :width: 70%




验证解决后网站是不支持tls1.0的::

    openssl s_client -connect  www.xinxi.com.cn:443 -tls1
    CONNECTED(00000005)
    4631825900:error:1400442E:SSL routines:CONNECT_CR_SRVR_HELLO:tlsv1 alert protocol version:/BuildRoot/Library/Caches/com.apple.xbs/Sources/libressl/libressl-47.11.1/libressl-2.8/ssl/ssl_pkt.c:1200:SSL alert number 70
    4631825900:error:140040E5:SSL routines:CONNECT_CR_SRVR_HELLO:ssl handshake failure:/BuildRoot/Library/Caches/com.apple.xbs/Sources/libressl/libressl-47.11.1/libressl-2.8/ssl/ssl_pkt.c:585:
    ---
    no peer certificate available
    ---
    No client certificate CA names sent
    ---
    SSL handshake has read 7 bytes and written 0 bytes
    ---
    New, (NONE), Cipher is (NONE)
    Secure Renegotiation IS NOT supported
    Compression: NONE
    Expansion: NONE
    No ALPN negotiated
    SSL-Session:
        Protocol  : TLSv1
        Cipher    : 0000
        Session-ID:
        Session-ID-ctx:
        Master-Key:
        Start Time: 1572851931
        Timeout   : 7200 (sec)
        Verify return code: 0 (ok)
    ---






