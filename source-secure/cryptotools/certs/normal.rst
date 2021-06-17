基本
####

一. 证书和编码
--------------

  X.509证书,其核心是根据RFC 5280编码或数字签名的数字文档
  实际上，术语X.509证书通常指的是IETF的PKIX证书和X.509 v3证书标准的CRL 文件
  即如RFC 5280（通常称为PKIX for Public Key Infrastructure（X.509））中规定的

二. X509文件扩展
----------------

  我们首先要了解的是每种类型的文件扩展名。 很多人不清楚DER，PEM，CRT和CER结尾的文件是什么，更有甚者错误地说是可以互换的
  在某些情况下,某些可以互换,最佳做法是识别证书的编码方式,然后正确标记
  正确标签的证书将更容易操纵

三. 编码: 决定扩展名方式
------------------------

1）.DER 扩展名::

  .DER = DER扩展用于二进制DER编码证书。
  这些文件也可能承载CER或CRT扩展。
  正确的说法是“我有一个DER编码的证书”不是“我有一个DER证书”

2）.PEM 扩展名::

  .PEM = PEM扩展用于不同类型的X.509v3文件，是以“ - BEGIN ...”前缀的ASCII（Base64）数据。

3）常见的扩展::

  3.1）.CRT 扩展名
  .CRT = CRT扩展用于证书。 证书可以被编码为二进制DER或ASCII PEM。 CER和CRT扩展几乎是同义词。 最常见的于Unix 或类Unix系统。

  3.2）.CER扩展名
   CER = .crt的替代形式（Microsoft Convention）您可以在微软系统环境下将.crt转换为.cer（.both DER编码的.cer，或base64 [PEM]编码的.cer）

  3.3）.KEY 扩展名
     .KEY = KEY扩展名用于公钥和私钥PKCS＃8. 键可以被编码为二进制DER或ASCII PEM

PKCS#7/P7B 格式::

  //@added
  PKCS#7 或 P7B格式通常以Base64的格式存储，扩展名为.p7b 或 .p7c
  有类似BEGIN PKCS7-----" 和 "-----END PKCS7-----"的头尾标记
  PKCS#7 或 P7B只能存储认证证书或证书路径中的证书（就是存储认证证书链，本级，上级，到根级都存到一个文件中）
  不能存储私钥，Windows和Tomcat都支持这种格式
  他是多个证书组织成的格式（一般是证书链）

PKCS#12/PFX 格式::

  //@added
  PKCS#12 或 PFX格式是以加密的二进制形式存储服务器认证证书，中级认证证书和私钥
  扩展名为.pfx 和 .p12，PXF通常用于Windows中导入导出认证证书和私钥
  其说是证书，不如叫它证书+私钥的package比较合适，一个文件即包含证书（证书链），也包含私钥


四. 常见的OpenSSL证书操作(重要)
-------------------------------

证书操作有四种基本类型。查看，转换，组合和提取。
1）查看证书::

  PEM编码的证书是ASCII，它们是不可读的。这里有一些命令可以让你以可读的形式输出证书的内容;
  1.1）查看PEM编码证书
  openssl x509 -in cert.pem -text
  openssl x509 -in cert.cer -text
  openssl x509 -in cert.crt -text
   如果您遇到这个错误，这意味着您正在尝试查看DER编码的证书，并需要使用“查看DER编码证书”中的命令
  unable to load certificate
  12626:error:0906D06C:PEMroutines:PEM_read_bio:no start line:pem_lib.c:647:Expecting: TRUSTEDCERTIFICATE

  1.2）查看DER编码证书
  openssl x509 -in certificate.der -inform der -text -noout
  如果您遇到以下错误，则表示您尝试使用DER编码证书的命令查看PEM编码证书。在“查看PEM编码的证书”中使用命令
  unable to load certificate
  13978:error:0D0680A8:asn1 encodingroutines:ASN1_CHECK_TLEN:wrong tag:tasn_dec.c:1306:
  13978:error:0D07803A:asn1 encodingroutines:ASN1_ITEM_EX_D2I:nested asn1 error:tasn_dec.c:380:Type=X509

2）转换证书格式::

  转换可以将一种类型的编码证书存入另一种（即PEM与DER间互转）
  PEM到DER
  openssl x509 -in cert.crt -outform der -out cert.der
  DER到PEM
  openssl x509 -in cert.crt -inform der -outform pem -out cert.pem

  //@added
  PEM to P7B
  openssl crl2pkcs7 -nocrl -certfile certificate.cer -out certificate.p7b -certfile CACert.cer
  P7B to PEM
  openssl pkcs7 -print_certs -in certificate.p7b -out certificate.cer

  PEM to PFX
  openssl pkcs12 -export -out certificate.pfx -inkey privateKey.key -in certificate.crt -certfile CACert.crt
  PFX to PEM
  openssl pkcs12 -in certificate.pfx -out certificate.cer -nodes

3）组合证书::

  在某些情况下，将多个X.509基础设施组合到单个文件中是有利的
  一个常见的例子是将私钥和公钥两者结合到相同的证书中
  组合密钥和链的最简单的方法是将每个文件转换为PEM编码的证书
  然后将每个文件的内容简单地复制到一个新文件中
  这适用于组合文件以在Apache中使用的应用程序

4)证书提取::

  一些证书将以组合形式出现,一个文件可以包含以下任何一个:
  证书,私钥,公钥,签名证书,证书颁发机构（CA）和/或权限链




五. 原文链接
------------

* `DER.VS.CRT.VS.CER.VS.PEM-CERTIFICATES <http://www.gtopia.org/blog/2010/02/der-vs-crt-vs-cer-vs-pem-certificates/>`_