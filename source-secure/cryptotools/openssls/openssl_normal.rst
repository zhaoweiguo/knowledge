openssl基本
=============================

命令::

  1.Standard commands
  asn1parse         ca                certhash          ciphers           
  crl               crl2pkcs7         dgst              dh                
  dhparam           dsa               dsaparam          ec                
  ecparam           enc               engine            errstr            
  gendh             gendsa            genpkey           genrsa            
  nseq              ocsp              passwd            pkcs12            
  pkcs7             pkcs8             pkey              pkeyparam         
  pkeyutl           prime             rand              req               
  rsa               rsautl            s_client          s_server          
  s_time            sess_id           smime             speed             
  spkac             ts                verify            version           
  x509

  // 非对称：
  2.Message Digest commands (see the `dgst' command for more details)
  gost-mac          md4               md5               md_gost94         
  ripemd160         sha               sha1              sha224            
  sha256            sha384            sha512            streebog256       
  streebog512       whirlpool

  // 对 称：
  3.Cipher commands (see the `enc' command for more details)
  aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb       
  aes-256-cbc       aes-256-ecb       base64            bf                
  bf-cbc            bf-cfb            bf-ecb            bf-ofb            
  camellia-128-cbc  camellia-128-ecb  camellia-192-cbc  camellia-192-ecb  
  camellia-256-cbc  camellia-256-ecb  cast              cast-cbc          
  cast5-cbc         cast5-cfb         cast5-ecb         cast5-ofb         
  chacha            des               des-cbc           des-cfb           
  des-ecb           des-ede           des-ede-cbc       des-ede-cfb       
  des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb      
  des-ede3-ofb      des-ofb           des3              desx              
  rc2               rc2-40-cbc        rc2-64-cbc        rc2-cbc           
  rc2-cfb           rc2-ecb           rc2-ofb           rc4               
  rc4-40

简单使用::

  // 生成服务器端的私钥(运行时会提示输入密码,此密码用于加密key文件)
  openssl genrsa -des3 -out zhaoweiguo.com.key 1024
  // 生成Certificate Signing Request（CSR）
  // 生成的csr文件交给CA签名后形成服务端自己的证书
  //屏幕上将有提示,依照其指示一步一步输入要求的个人信息即可
  openssl req -new -key zhaoweiguo.com.key -out zhaoweiguo.com.csr


1.使用OpenSSL工具生成CSR文件::

  //1.1生成csr文件和私钥key文件
  openssl req -new -nodes -sha256 -newkey rsa:2048 -keyout myprivate.key -out mydomain.csr
  //参数
  -new 指定生成一个新的CSR
  -nodes指定私钥文件不被加密
  -sha256指定摘要算法
  -keyout生成私钥
  -newkey rsa:2048 指定私钥类型和长度,最终生成CSR文件mydomain.csr
  //生成文件
  mydomain.csr  myprivate.key

  //1.2生成证书文件crt
  openssl x509 -req -days 365 -in <csr>.csr -signkey <key>.key -out <newcrt>.crt

  
2.使用keytool工具生成CSR文件::

  //2.1先生成证书文件keystore, 证书文件中包含密钥
  keytool -genkey -alias mycert -keyalg RSA -keysize 2048 -keystore ./mydomain.jks
  keyalg是密钥类型,必须是RSA
  keysize是密钥长度为2048
  alias 是证书别名可自定义
  keystore是证书文件保存路径

  //2.2通过证书文件生成证书请求
  keytool -certreq -sigalg SHA256withRSA -alias mycert -keystore ./mydomain.jks -file ./mydomain.csr
  sigalg是摘要算法,使用SHA256withRSA
  alias是别名,必须与2.1步中的别名一致
  keystore是证书文件
  file是证书请求文件(CSR)
  而后提示输入证书密码即可以生成mydomain.csr

  


去除key文件口令的命令::

    openssl rsa -in <encryedprivate>.key -out <unencryed>.key
    //扩展名为key或者pem均可
    //如果一个私钥文件是如下样式(用文本编辑器打开后) ,则说明是带有密码的:
    1.PKCS#8 私钥加密格式
    -----BEGIN ENCRYPTED PRIVATE KEY-----
    BASE64私钥内容......
    -----END ENCRYPTED PRIVATE KEY-----
    2.Openssl ASN格式
    -----BEGIN RSA PRIVATE KEY-----
    Proc-Type: 4,ENCRYPTED
    DEK-Info:DES-EDE3-CBC,4D5D1AF13367D726
    BASE64私钥内容......
    -----END RSA PRIVATE KEY-----

私钥转非加密::

  openssl rsa -in rsa_aes_private.key -passin pass:111111 -out rsa_private.key

私钥转加密::

  openssl rsa -in rsa_private.key -aes256 -passout pass:111111 -out rsa_aes_private.key



数字证书
------------

主流数字证书::

    一般来说,主流的Web服务软件,通常都基于两种基础密码库:OpenSSL和Java
    Tomcat、Weblogic、JBoss等,使用Java提供的密码库;通过Java的Keytool工具,生成Java Keystore(JKS)格式的证书文件
    Apache、Nginx等,使用OpenSSL提供的密码库,生成PEM、KEY、CRT等格式的证书文件


如果您在工作中遇到带有后缀扩展名的证书文件，可以简单用如下方法区分::

    *.DER *.CER:这样的证书文件是二进制格式,只含有证书信息,不包含私钥
    *.CRT:这样的文件可以是二进制格式,也可以是文本格式,一般均为文本格式,功能与*.DER/*.CER相同
    *.PEM:一般是文本格式,可以放证书或私钥,或者两者都包含; 
    *.KEY:「*.PEM」如果只包含私钥,那一般用*.KEY代替
    *.PFX *.P12:是二进制格式,同时含证书和私钥,一般有密码保护

证书之间的转换方法::


    JKS:用于Weblogic,Tomcat,Jboss等
    PFX:用于IIS
    KEY&CRT:用于Apache、Nginx
    KDB:用于IHS、Websphere等

    1. 将JKS转换成PFX
    keytool -importkeystore -srckeystore <path1>.jks -destkeystore <path2>.pfx -srcstoretype JKS -deststoretype PKCS12
    2. 将PFX转换为JKS
    keytool -importkeystore -srckeystore <path1>.pfx -destkeystore <path2>.jks -srcstoretype PKCS12 -deststoretype JKS
    3. 将PEM/KEY/CRT转换为PFX
    将密钥文件KEY和公钥文件CRT放到OpenSSL目录下，打开OpenSSL执行以下命令：
    openssl pkcs12 -export -out server.pfx -inkey server.key -in server.crt
    4. 将PFX转换为PEM/KEY/CRT
    将PFX文件放到OpenSSL目录下，打开OpenSSL执行以下命令：
    openssl pkcs12 -in server.pfx -nodes -out server.pem
    openssl rsa -in server.pem -out server.key
    ** 请注意 ** 此步骤是专用于使用keytool生成私钥和CSR申请证书，
      并且获取到pem格式证书公钥的情况下做分离私钥使用的,
      所以在实际部署证书时请使用此步骤分离出来的私钥和申请下来的公钥证书做匹配使用




实战::

  // 创建私钥
  openssl genrsa -out server.key 4096
  // 创建私钥和证书
  openssl req -out server.csr -new -newkey rsa:4096 -nodes -keyout server.key
  // 创建自签名证书
  openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 -keyout server.key -out server.crt
  // 基于已存在的私钥创建csr(certificate signing request)
  openssl req -out server.csr -key server.key -new
  // 基于已存在的证书创建csr(certificate signing request)
  openssl x509 -x509toreq -in server.crt -out server.csr -signkey server.key
  // 去除私钥的密码
  openssl rsa -in server.pem -out newserver.pem
  // (todo)Parse a list of revoked serial numbers
  openssl crl -inform DER -text -noout -in list.crl

  // 检查certificate signing request (CSR)
  openssl req -text -noout -verify -in server.csr
  // 检查私钥
  openssl rsa -in server.key -check
  // 检查公钥
  openssl rsa -inform PEM -pubin -in pub.key -text -noout
  openssl pkey -inform PEM -pubin -in pub.key -text -noout
  // 检查证书
  openssl x509 -in server.crt -text -noout
  openssl x509 -in server.cer -text -noout
  // 检查PKCS#12 file (.pfx or .p12)
  openssl pkcs12 -info -in server.p12

  // 验证私钥和证书匹配
  openssl x509 -noout -modulus -in server.crt | openssl md5
  openssl rsa -noout -modulus -in server.key | openssl md5
  openssl req -noout -modulus -in server.csr | openssl md5

  // 显示所有的证书和中间媒体
  openssl s_client -connect www.paypal.com:443

  // 把DER文件 (.crt .cer .der) 转化为PEM
  openssl x509 -inform der -in server.cer -out server.pem
  // 把PEM文件转化为DER
  openssl x509 -outform der -in server.pem -out server.der
  // 把包含私钥和证书的PKCS#12文件(.pfx .p12) 转化为PEM文件
  openssl pkcs12 -in server.pfx -out server.pem -nodes
  // 把一个PEM证书文件和私钥转化为PKCS#12文件(.pfx .p12)
  openssl pkcs12 -export -out server.pfx -inkey server.key -in server.crt -certfile CACert.crt

















