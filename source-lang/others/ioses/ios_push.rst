ios推送相关
########################

地址::

  // 老版本(Binary Interface)
  测试地址: gateway.sandbox.push.apple.com:2195
  发布地址: gateway.push.apple.com:2195

  // http2版本
  Development server: api.development.push.apple.com:443
  Production server: api.push.apple.com:443

老版本测试可用性::

  // 确定苹果服务器可用
  telnet gateway.sandbox.push.apple.com 2195
  // 连接苹果服务器
  openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert PushChatCert.pem -key PushChatKey.pem
  // 说明:出现下面信息是正常的
  verify error:num=20:unable to get local issuercertificate
  verify return:0

新版本测试可用性::

  // 确定苹果服务器可用
  telnet api.development.push.apple.com 443
  // 确定连接苹果服务器成功
  openssl s_client -connect api.development.push.apple.com:443 -cert PushChatCert.pem -key PushChatKey.pem
  // 说明:出现下面信息是正常的
  verify error:num=20:unable to get local issuercertificate
  verify return:0


