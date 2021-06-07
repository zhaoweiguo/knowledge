证书验证
###########


判断是否改动过

.. figure:: /images/protocols/protocol_ssl_tls_digest2.png
   :width: 80%


证书验证(如何保证你是证书的拥有者)::

  //客户端信任了许多根证书，比如客户端信任一个叫做“Google”的证书
  //浏览器收到我们的证书之后，查看它的颁发者，哦，是“Google”
  //于是到信任的根证书里面找一个名字叫做“Google”的证书
  1. 对我们的证书（除了“签名值”）全部内容进行MD5/SHA1, 得到一个「结果1」
  2. 用“Google”证书中的公钥，对我们证书中的“签名值”进行解密, 得到「结果2」
  3. 比较「结果1」和「结果2」, 发现一样, 那么认证通过

证书链::

  “Google”签名了一个“Android”，然后“Android”签名了一个“CyanogenMod”
  我们浏览器只信任“Google”
  如果服务器只发送一个叫做“CyanogenMod”，那么我们无法查找到叫做“Android”的根证书，无法验证服务器的身份
  作为服务器，我们可发送“Android”+“CyanogenMod”





