Shadowsock
###############

PAC自定义规则
===================

* 参考 [1]_

规则描述::

    1. 通配符支持，如 *.example.com/* 实际书写时可省略,如:
       .example.com/ 意即 `.example.com/*`
    2. 正则表达式支持，以\开始和结束， 如:
       \[\w]+:\/\/example.com\
    3. 例外规则 @@，如:
       @@*.example.com/* 满足@@后规则的地址不使用代理
    4. 匹配地址开始和结尾 |，如:
       |http://example.com、example.com| 
       分别表示以 http://example.com 开始和以 example.com 结束的地址
    5. || 标记，如: ||example.com 则:
       http://example.com 、https://example.com 、ftp://example.com 
       等地址均满足条件，只用于匹配地址开头
    6. 注释 ! 如 ! Comment
    7. 分隔符^，表示除了字母、数字或者 _ - . % 之外的任何字符。如:
       http://example.com^ ，表示:
       http://example.com/ 和http://example.com:8000/ 均满足条件
       而 http://example.com.ar/ 不满足条件

实例::

    \[\w]+:\/\/en.wikipedia.org\
    \[\w]+:\/\/blog.kubernetes.io\
    \[\w]+:\/\/c.disquscdn.com\
    \[\w]+:\/\/cdnjs.cloudflare.com\
    \[\w]+:\/\/d3js.org\
    \[\w]+:\/\/[\w]+.neo4jsandbox.com\
    \[\w]+:\/\/raw.githubusercontent.com\
    \[\w]+:\/\/image.slidesharecdn.com\
    \[\w]+:\/\/maps.googleapis.com\
    \[\w]+:\/\/blog.golang.org\
    \[\w]+:\/\/[\w]+.youtube.com\
    \[\w]+:\/\/research.google\

实例2(实测有效)::

  ||en.wikipedia.org
  ||blog.kubernetes.io
  ||c.disquscdn.com
  ||cdnjs.cloudflare.com
  ||d3js.org
  ||neo4jsandbox.com
  ||raw.githubusercontent.com
  ||image.slidesharecdn.com
  ||maps.googleapis.com
  ||storage.googleapis.com
  ||blog.golang.org
  ||youtube.com
  ||research.google

相关知识
========

* ss: Shadowsocks
* ssr: SSR全称shadowsocks-R。SSR作者声称SS不够隐匿，容易被防火墙检测到，SSR在改进了混淆和协议，更难被防火墙检测到。简单地说，SSR是SS的改进版。

相关网站
========

* 支持ssr: https://github.com/shadowsocksrr
* ssr版(mac专用): https://github.com/qinyuhang/ShadowsocksX-NG-R/releases
* 其他: https://tlanyan.me/shadowsockr-shadowsocksr-shadowsocksrr-clients/
* https://github.com/shadowsocks/shadowsocks-iOS/wiki/Shadowsocks-for-OSX-%E5%B8%AE%E5%8A%A9


.. [1] https://adblockplus.org/en/filter-cheatsheet