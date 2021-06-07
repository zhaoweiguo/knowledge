.. _http_temp:

临时
####

**关键词**

    HTTP协议的头信息详解


在TCP的头部中, 有8比特(bit)用作控制位区域, 其取值为::

  CWR | ECE | URG | ACK | PSH | RST | SYN | FIN



实例::

  // 普通html
  GET / HTTP/1.1
  Host: www.zhaoweiguo.com
  Connection: keep-alive
  Cache-Control: max-age=0 
  Upgrade-Insecure-Requests: 1
  User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99
  Safari/537.36   
  Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
  Accept-Encoding: gzip, deflate
  Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7
  Cookie: Hm_lvt_3735c33915718b8a09c27bed6968779f=1530163340,1530249790,1530510224,1530793155; Hm_lpvt_3735c33915718b8a09
  c27bed6968779f=1530880847

  // 普通图片
  GET /favicon.ico HTTP/1.1
  Host: www.zhaoweiguo.com
  Connection: keep-alive
  Pragma: no-cache
  Cache-Control: no-cache
  User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99
  Safari/537.36
  Accept: image/webp,image/apng,image/*,*/*;q=0.8
  Referer: http://www.zhaoweiguo.com/
  Accept-Encoding: gzip, deflate
  Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7
  Cookie: Hm_lvt_3735c33915718b8a09c27bed6968779f=1530163340,1530249790,1530510224,1530793155; Hm_lpvt_3735c33915718b8a09
  c27bed6968779f=1530880900


说明
====

注：IE6 并不是不支持 HTTPS，而是不支持 SNI，不支持意味着只能一个 IP 对应一个域名一个证书，很明显在现代网站构建中这是一个不合理的设计，详情可以阅读: [https和SNI https://zzyongx.github.io/blogs/https-SNI.html]_










