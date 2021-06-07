http2协议 [1]_
##################

HTTP/2 （原名HTTP/2.0）即超文本传输协议 2.0，是下一代HTTP协议
在开放互联网上HTTP 2.0将只用于https://网址，而 http://网址将继续使用HTTP/1，目的是在开放互联网上增加使用加密技术，以提供强有力的保护去遏制主动攻击
HTTP2.0可以说是SPDY的升级版（其实原本也是基于SPDY设计的）
HTTP2.0 跟 SPDY 仍有不同的地方::

  HTTP2.0 支持明文 HTTP 传输，而 SPDY 强制使用 HTTPS
  HTTP2.0 消息头的压缩算法采用 HPACK，而非 SPDY 采用的 DEFLATE

新特性
'''''''''''''
1.新的二进制格式（Binary Format），HTTP1.x的解析是基于文本::

  基于文本协议的格式解析存在天然缺陷，文本的表现形式有多样性
  要做到健壮性考虑的场景必然很多，二进制则不同，只认0和1的组合
  基于这种考虑HTTP2.0的协议解析决定采用二进制格式，实现方便且健壮

2.多路复用(MultiPlexing),即连接共享,即每一个request都是是用作连接共享机制的::

  一个request对应一个id, 这样一个连接上可以有多个request
  每个连接的request可以随机的混杂在一起
  接收方可以根据request的 id将request再归属到各自不同的服务端请求里面

多路复用原理图：

.. figure:: /images/protocols/protocol_http_http2.0_multiplex.png
   :width: 70%

header压缩::

  如上文中所言，对前面提到过HTTP1.x的header带有大量信息，而且每次都要重复发送
  HTTP2.0使用encoder来减少需要传输的header大小
  通讯双方各自cache一份header fields表
  既避免了重复header的传输，又减小了需要传输的大小

服务端推送(server push)::

  同SPDY一样，HTTP2.0也具有server push功能
  目前，有大多数网站已经启用HTTP2.0，例如
  YouTuBe，淘宝网等网站，利用chrome控制台可以查看是否启用H2

Http1.0与Http1.1区别图:

.. figure:: /images/protocols/protocol_http_diff_1.0_1.1.png
   :width: 70%

Http1.1与Http2.0区别图:

.. figure:: /images/protocols/protocol_http_diff_1.1_2.0.png
   :width: 70%



http2工具
=========

* https://tools.keycdn.com/http2-test


.. [1] https://www.cnblogs.com/wujiaolong/p/5172e1f7e9924644172b64cb2c41fc58.html












