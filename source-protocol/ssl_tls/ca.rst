如何使用ca证书签名证书
#########################

私有 CA 签名 [2]_ ::

    # 1.创建 CA 私钥
    $ openssl genrsa -out ca.key 2048

    # 2.生成 CA 的自签名证书
    $ openssl req -subj \
      "/C=CN/ST=Beijing/L=Beijing/O=Wei64/OU=Wei64 Corp./CN=Server CA/emailAddress=ca@zwg.com" \
      -new -x509 -days 3650 -key ca.key -out ca.crt

    # 3.生成需要颁发证书的私钥
    $ openssl genrsa -out s.key 2048

    # 4.生成要颁发证书的证书签名请求，证书签名请求当中的 Common Name 必须区别于 CA 的证书里面的 Common Name
    $ openssl req -subj \
      "/C=CN/ST=Beijing/L=Beijing/O=Wei64/OU=Wei64 Corp./CN=www.zwg.com/emailAddress=s@zwg.com" \
      -new -key s.key -out s.csr

    # 5.用 2 创建的 CA 证书给 4 生成的 签名请求 进行签名
    $ openssl x509 -req -days 3650 -in s.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out s.crt

.. note:: 上面openssl命令上的缩写: C: Country, ST: State, O: Organization, CN: Common Name



CA认证证书 [1]_::

  //CA(谷歌)做的事
  1.用工具生成一对公钥和私钥
  2.构造证书,把公钥嵌入到证书里面(即证书里面其实有一个字段是公钥，明文的)
  3.最重要的一步,谷歌拿自己的根证书签名一个第2步构造好的证书
    //所谓签名：就是对第2步的证书做摘要，MD5或者SHA1，或者MD5+SHA1
    //得到结果，然后拿自己根证书的私钥加密这个结果，然后添加到证书最后面
  4.把证书和私钥交给你


.. [1] `TLS/SSL 协议详解(6) SSL 数字证书的一些细节1 <https://blog.csdn.net/mrpre/article/details/77867063>`_
.. [2] https://www.jianshu.com/p/e5f46dcf4664




