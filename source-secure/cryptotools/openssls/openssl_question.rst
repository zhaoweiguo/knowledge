加密常见问题
===============

苹果p12文件导出私钥只有150B
'''''''''''''''''''''''''''''''
::

  // 执行这条命令得到的apns-dev-key.pem只有150B
  openssl pkcs12 -nocerts -out apns-dev-key.pem -in apns-dev-key.p12
  // 内容为:
  Bag Attributes
    friendlyName: octopus
    localKeyID: 7F 0E 83 38 DF C0 1A 04 75 E1 95 21 A0 83 61 C0 8A E5 05 0B 
  Key Attributes: <No Attributes>

  // 但增加-nodes选项后就正常了
  openssl pkcs12 -nocerts -nodes -out apns-dev-key.pem -in apns-dev-key.p12

原因::

  当不指定-node参数时,必须要输入足够复杂的密码,不然就会生成150B大小的文件
  即:
  openssl pkcs12 -nocerts -nodes -out apns-dev-key.pem -in apns-dev-key.p12
  等同于下面2个命令:
  openssl pkcs12 -nocerts -out apns-dev-key-passwd.pem -in apns-dev-key.p12
  openssl rsa -in apns-dev-key-passwd.pem -out apns-dev-key-noenc.pem





.. _unable_to_load_key_file:

unable to load key file
'''''''''''''''''''''''''''''''''
执行::

  $> openssl dgst -verify cert.pem -signature file.sha1 file.data

报错::

  unable to load key file

发现问题::

  $> openssl x509 -in cert.pem -noout -text 
  Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
             (Negative)11:1b:51:87:3d:b4:0b:5a:b7:74:94:88:39:ee:12:22
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=Trust - Lenovo Certificate
        Validity
            Not Before: Jun 20 03:38:11 2012 GMT
            Not After : Dec 31 23:59:59 2039 GMT
        Subject: CN=Mocca
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:b5:fd:31:3f:91:24:96:7d:c3:9e:7c:6f:5a:41:
                    b2:5d:7b:15:87:ec:a4:a7:25:00:7d:ae:2c:8a:b9:
                    ... ...
                    5f:c4:87:30:5c:7a:4b:90:46:21:73:2b:6b:cd:58:
                    49:39
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            2.5.29.1: 
                0M..b.`~.....0...-.".'0%1#0!..U....Trust - Lenovo Certificate..^...k...@.`F
   ...
    Signature Algorithm: sha256WithRSAEncryption
         64:be:96:2c:64:02:f4:78:26:66:83:60:67:8f:e8:ca:05:64:
         c1:f4:5a:cf:a1:4e:e1:13:bb:56:f1:b4:0f:1f:03:e4:8e:ad:
         ... ...

解决方案::

  原因:openssl dgst -verify cert.pem命令期望文件cert.pem contains the "raw" public key in PEM format. 
    The raw format is an encoding of a SubjectPublicKeyInfo structure, which can be found within a certificate; 
    but openssl dgst cannot process a complete certificate in one go.

  // 你要先从证书中提取出public key
  $> openssl x509 -pubkey -noout -in cert.pem > pubkey.pem
  // 然后再验证
  $> openssl dgst -verify pubkey.pem -signature sigfile dat
















