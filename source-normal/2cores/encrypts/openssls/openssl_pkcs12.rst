openssl pkcs12命令
==================

用途::

  pkcs12文件工具,能生成和分析pkcs12文件.PKCS#12文件可以被用于多个项目,例如:
  包含Netscape, MSIE 和 MS Outlook



openssl pkcs12命令::

  Usage: pkcs12 [options]
  where options are
  -export       指定输出的pkcs12文件
  -chain        add certificate chain
  -inkey file   指定私钥文件的位置。如果没有被指定，私钥必须在-in filename中指定
  -certfile f   添加filename中所有的证书信息值
  -CApath arg   - PEM format directory of CA's
  -CAfile arg   - PEM format file of CA's
  -name "name"  指定证书以及私钥的友好名字。当用软件导入这个文件时，这个名字将被显示出来
  -caname "nm"  指定其它证书的友好名字。这个选项可以被用于多次
  -in  infile   指定私钥和证书读取的文件,必须为PEM格式
  -out outfile  output filename
  -noout        只verify不输出任何东西
  -nomacver     don't verify MAC.
  -nocerts      不输出任何证书.
  -clcerts      仅仅输出客户端证书，不输出CA证书.
  -cacerts      仅仅输出CA证书，不输出客户端证书.
  -nokeys       不输出任何private keys.
  -info         输出PKCS#12文件结构的附加信息值, 如用的算法信息以及迭代次数.
  -des          在输出之前用DES算法加密私钥值
  -des3         在输出之前用DES3算法加密私钥值 (default)
  -aes128, -aes192, -aes256
                在输出之前用cbc aes算法加密私钥值
  -camellia128, -camellia192, -camellia256
                在输出之前用cbc camellia算法加密私钥值
  -nodes        一直对私钥不加密
  -noiter       don't use encryption iteration
  -nomaciter    读取文件时不验证MAC值的完整性(don't use MAC iteration)
  -maciter      use MAC iteration
  -nomac        don't generate MAC
  -twopass      需要用户分别指定MAC口令和加密口令(separate MAC, encryption passwords)
  -descert      encrypt PKCS#12 certificates with triple DES (default RC2-40)
  -certpbe alg  specify certificate PBE algorithm (default RC2-40)
  -keypbe alg   specify private key PBE algorithm (default 3DES)
  -macalg alg   digest algorithm used in MAC (default SHA1)
  -keyex        set MS key exchange type
  -keysig       set MS key signature type
  -password p   指定导入导出口令来源
  -passin p     输入文件保护口令来源(input file pass phrase source)
  -passout p    指定所有输出私钥保护口令来源(output file pass phrase source)
  -engine e     use engine e, possibly a hardware device.
  -CSP name     Microsoft CSP name
  -LMK          Add local machine keyset attribute to private key

实例::

  // 分析一个PKCS#12文件,并输出到文件中：
  openssl pkcs12 -in file.p12 -out file.pem
  // 仅仅输出客户端证书到文件中：
  openssl pkcs12 -in file.p12 -clcerts -out file.pem
  // 不加密私钥文件：
  openssl pkcs12 -in file.p12 -out file.pem -nodes
  // 打印PKCS#12格式的信息值：
  openssl pkcs12 -in file.p12 -info -noout
  // 生成pkcs12文件，但不包含CA证书：
  openssl pkcs12 -export -inkey ocspserverkey.pem -in ocspservercert.pem  -out ocspserverpkcs12.pfx
  // 生成pcs12文件，包含CA证书：
  openssl pkcs12 -export -inkey ocspserverkey.pem -in ocspservercert.pem -CAfile demoCA/cacert.pem -chain -out ocsp1.pfx

  // 将pcks12中的信息分离出来，写入文件：
  openssl pkcs12 –in ocsp1.pfx -out certandkey.pem
  // 显示pkcs12信息：
  openssl pkcs12 –in ocsp1.pfx -info















