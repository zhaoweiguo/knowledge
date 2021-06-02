mac的p12导出私钥
########################

p12文件::

  /files/encrypts/apns-dev-key.p12

导出无私钥的证书文件::

  openssl pkcs12 -clcerts -nokeys -out apns-dev-cert.pem -in apns-dev-cert.p12

.. literalinclude:: /files/encrypts/apns-dev-cert.pem

导出私钥::

  openssl pkcs12 -nocerts -nodes -out apns-dev-key.pem -in apns-dev-key.p12

.. literalinclude:: /files/encrypts/apns-dev-key.pem

去掉私钥中的密码::

  openssl rsa -in apns-dev-key.pem -out apns-dev-key-noenc.pem

.. literalinclude:: /files/encrypts/apns-dev-key-noenc.pem

合并私钥和证书::

  cat apns-dev-cert.pem apns-dev-key-noenc.pem > apns-dev.pem

.. literalinclude:: /files/encrypts/apns-dev.pem





