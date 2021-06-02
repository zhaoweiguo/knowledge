Auth1.0协议
###############

rfc规范 [1]_


.. figure:: /images/protocols/auth1_1.png
   :width: 80%

oauth认证分服务器端和客户端

 

客户端的步骤是::

  1 获取未授权的Request Token
  2 请求用户授权Request Token
  3 使用授权后的Request Token换取Access Token

 

服务器端的步骤是::

  1 发放未授权request_token
  2 将用户转到本网站的用户登录页
  3 用户登录成功后，返回授权后的request_token和凭证
  4 发放最终可以使用的凭证access_token




.. [1] http://www.ietf.org/rfc/rfc5849.txt

