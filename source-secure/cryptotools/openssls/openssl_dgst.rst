openssl dgst命令
================

openssl dgst <option>::

  gost-mac          md4               md5               md_gost94         
  ripemd160         sha               sha1              sha224            
  sha256            sha384            sha512            streebog256       
  streebog512       whirlpool

其他option::

  -sign file        sign digest using private key in file
  -verify file      verify a signature using public key in file
  -signature file   signature to verify
  -out filename     output to filename rather than stdout

实例::


    // 签名
    openssl dgst -sha256 -sign private.pem -out out.bin testfile
    // 验证
    openssl dgst -sha256 -verify public.pem -signature out.bin testfile

    // 从p12文件中取出私钥
    openssl pkcs12 -nodes -nocerts -in Mocca.pfx -out private.pem -passin pass:""


    $ echo "zhaohang" |openssl dgst -md5
    c47df1e95ae452e959fcc73cda1a3e77




