.. _openssl_rsa:

openssl rsa命令
---------------

openssl rsa 命令::


  usage: rsa [-ciphername] [-check] [-engine id] [-in file] [-inform fmt]
    [-modulus] [-noout] [-out file] [-outform fmt] [-passin src]
    [-passout src] [-pubin] [-pubout] [-sgckey] [-text]

   -check             Check consistency of RSA private key
   -engine id         Use the engine specified by the given identifier
   -in file           输入文件 (default stdin)
   -inform format     Input format (DER, NET or PEM (default))
   -modulus           Print the RSA key modulus
   -noout             Do not print encoded version of the key
   -out file          输出文件 (default stdout)
   -outform format    输出文件格式 (DER, NET or PEM (default PEM))
   -passin src        Input file passphrase source
   -passout src       Output file passphrase source
   -pubin             Expect a public key (default private key)
   -pubout            Output a public key (default private key)
   -sgckey            Use modified NET algorithm for IIS and SGC keys
   -text              Print in plain text in addition to encoded
   -ciphername      密码类型名


  //转换为DER（Distinguished Encoding Rules，可辨别编码规则）编码:
  openssl rsa -in key.pem -outform der -out key.der
  // 转换回pem,并设为密码保护:
  openssl rsa -inform der -in key.der -des3 -out enckey.pem

openssl rsautl命令::

  Usage: rsautl [options]
  -in file        input file
  -out file       output file
  -inkey file     input key
  -keyform arg    private key format - default PEM
  -pubin          input is an RSA public
  -certin         input is a certificate carrying an RSA public key
  -ssl            use SSL v2 padding
  -raw            use no padding
  -pkcs           use PKCS#1 v1.5 padding (default)
  -oaep           use PKCS#1 OAEP
  -sign           sign with private key
  -verify         verify with public key
  -encrypt        encrypt with public key
  -decrypt        decrypt with private key
  -hexdump        hex dump output
  -engine e       use engine e, possibly a hardware device.
  -passin arg    pass phrase source

  //1.实例一:签名验证
  // 私钥签名
  openssl rsautl -sign -in test -out test.sig -inkey asn1enc.pem
  // 公钥验证
  openssl rsautl -verify -in test.sig -out test.vfy -inkey asn1pub.pem -pubin



RSA类加密使用::

  // 生成密钥（RSA密钥至少为500位长，一般推荐使用1024位）
  openssl genrsa -out test.key 1024
  // 生成对应公钥
  openssl rsa -in test.key -pubout -out test_pub.key
  // 操作:加密文件
  openssl rsautl -encrypt -in <file.pub> -inkey test_pub.key -pubin -out <file> 
  // 操作:解密文件
  openssl rsautl -decrypt -in <file> -inkey test.key -out <newfile.pub>









