生成ca证书并签名子证书
#########################

方法一
---------

::

  mkdir gordonca; cd gordonca
  mkdir certs private
  chmod 700 private

  touch index.txt
  echo 01 > serial
  touch openssl.conf

打开并修改openssl.conf文件:

.. literalinclude:: /files/encrypts/ca/openssl.conf


生成根证书::

  // 生成私钥: ./private/cakey.pem
  // 生成pem格式证书: ./cacert.pem
  openssl req -x509 -config openssl.conf -newkey rsa:2048 -days 365 -out cacert.pem -outform PEM -subj /CN=GORDONCA/ -nodes

  // 导出cer格式证书: ./cacert.cer
  openssl x509 -in cacert.pem -out cacert.cer -outform DER

生成服务器端证书::

  cd ..
  mkdir server; cd server
  // 生成私钥
  openssl genrsa -out key.pem 2048
  // 生成证书
  openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/O=server/ -nodes

  cd ../gordonca/
  openssl ca -config openssl.conf -in ../server/req.pem -out ../server/cert.pem -notext -batch -extensions server_ca_extensions

生成客户器端证书::

  cd ..
  mkdir client; cd client
  // 生成私钥
  openssl genrsa -out key.pem 2048
  // 生成证书
  openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/O=client/ -nodes

  cd ../gordonca/
  openssl ca -config openssl.conf -in ../client/req.pem -out ../client/cert.pem -notext -batch -extensions client_ca_extensions


另一种方法
---------------


.. literalinclude:: ./gen_cert_key.sh

.. literalinclude:: ./Readme.txt







