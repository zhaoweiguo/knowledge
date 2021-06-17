微软makecert导出私钥
####################

微软生成需要的文件
''''''''''''''''''''
使用makecert生成证书 [1]_::

  // 1.生成一个自签名的根证书（issuer,签发者）
  $> makecert -n "CN=Root" -r -sv makecert.pvk makecert.cer
  // 2.使用这个证书签发一个子证书（使用者，subject）
  // 注: 这儿未使用子证书
  $> makecert -n "CN=Child" -iv makecert.pvk -ic makecert.cer -sv ChildSubject.pvk ChildSubject.cer

  // 3.公钥证书格式转换成SPC。 cert2spc.exe
  $> cert2spc makecert.cer makecert.spc

  // 4.将公钥证书和私钥合并成一个PFX格式的证书文件。pvk2pfx.exe
  $> pvk2pfx -pvk makecert.pvk -spc makecert.spc -pfx makecert.pfx

  最后得到文件:
  makecert.pfx    // 证书文件,内含私钥
  makecert.cer    // 证书文件,内含公钥

导出公私钥具体步骤
''''''''''''''''''''''''''

1.提取私钥::

  $> openssl pkcs12 -nodes -nocerts -in makecert.pfx -out makecert_private.pem -passin pass:""

.. literalinclude:: /files/encrypts/makecert_private.pem

2.把der格式的证书转化为pem格式::

  $> openssl x509 -in makecert.cer -inform der -outform pem -out makecert_sign.pem

.. literalinclude:: /files/encrypts/makecert_sign.pem

3.提取公钥::

  $> openssl x509 -pubkey -noout -in makecert_sign.pem > makecert.pem

.. literalinclude:: /files/encrypts/makecert.pem


通过公私钥具体操作
''''''''''''''''''''''''

执行命令加解密::

  // 公钥签名
  openssl dgst -sha256 -sign makecert_private.pem -out signature.bin testfile
  // 私钥验证
  openssl dgst -sha256 -verify makecert.pem -signature signature.bin testfile
  


.. [1] https://www.cnblogs.com/aiqingqing/p/4503051.html









