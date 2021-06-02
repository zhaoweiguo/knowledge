---
title: 域名过期导致的一系列问题
date: 2019-03-10 13:22:09
categories:
- question
tags:
- 域名
- question
---

### 问题描述

域名是通过代理商在阿里买的，然后域名解析用的腾讯dnspod的收费版
域名过期消息通知都是发到代理商那里，我们不知道域名过期这事
过期后，阿里把权威dns改成EXPIRENS3.HICHINA.COM/EXPIRENS4.HICHINA.COM。
于是域名解析有问题了，但这个问题因为dns缓存机制，延迟了1整天才被发现。
续费后，权威dns修改正常，同样因为dns缓存机制，有48小时的缓存时间，所以有很多地方请求还是有问题
有一部分机器请求阿里的那个权威dns，一部分请求腾讯的权威dns，而请求阿里那部分失败。


### 问题解决

中间经历了各种尝试就不细说了，最后
在阿里上也修改二级域名记录，修改后，不管是请求哪个权威dns,结果都是对的
原因可能是:

    阿里过期dns对不过期的域名也做了域名解析
    阿里云对顶级域服务器来说是有可控的写入权的销售商

问题虽然解决，但以前对dns了解很浅，得把这个问题彻底搞明白
以后再遇到dns的其他问题，就能做到心中有数了

### 相关定义

权威DNS:

    权威DNS是经过上一级授权对域名进行解析的服务器，同时它可以把解析授权转授给其他人，如:
      COM顶级服务器可以授权dns.com这个域名的的权威服务器为NS.ABC.COM
      同时NS.ABC.COM还可以把授权转授给NS.DDD.COM
      这样NS.DDD.COM就成了ABC.COM实际上的权威服务器了
    平时我们解析域名的结果都源自权威DNS。比如:
      dns.com的权威DNS服务器就是帝恩思的ns1.dns.com ns2.dns.com
      ali云的权威DNS服务器是:
          DNS9.HICHINA.COM
          DNS10.HICHINA.COM
      dnspod权威dns:
          NS3.DNSV3.COM
          NS3.DNSV3.COM

递归DNS:

    负责接受用户对任意域名查询，并返回结果给用户。递归DNS可以缓存结果以避免重复向上查询。
    平时使用最多的就是这类DNS，对公众开放服务，一般由网络运营商提供，自己可以架递归DNS提供服务
    递归DNS一定要有可靠的互联网连接方可使用。比如:
      谷歌的8.8.8.8和8.8.4.4
      114的114.114.114.114和114.114.115.115都属于这一类DNS
    你本地电脑上设置的DNS就是这类DNS

转发DNS:

    负责接受用户查询，并返回结果给用户。
    但此结果不是按标准域名解析过程得到的，而是直接把递归DNS的结果转发给用户。它也具备缓存功能。
    他主要使用在没有直接的互联网连接，但可以连接到一个递归DNS那里，这时使用转发DNS就比较合适。
    其缺陷是：
      直接受递归DNS的影响，服务品质较差。
    如路由器里面的DNS就是这一类，用路由器的朋友可以看下本地电脑的DNS一般都是192.168.1.1

### 域名解析过程

用户—本地递归服务器—根权威服务器—COM权威服务器—xxorg.com权威服务器—用户
对顶级域服务器来说销售商有可控的写入权。

递归服务器怎么知道根权威服务器的地址？

    很简单，在递归服务器上都保存有一份根服务器的地址列表。最新的根服务器地址列表在这里可以得到：
    ftp://ftp.internic.net/domain/named.root

递归服务器每次查询域名都要向根那里找权威服务器吗？

    不是的，一旦成功一次，递归服务器就会把权威服务器列表缓存下来
    如COM顶级服务器列表可以缓存48小时

操作步骤:

    1、在浏览器中输入www.qq.com 域名，操作系统会先检查自己本地的hosts文件是否有这个网址映射关系，如果有，就先调用这个IP地址映射，完成域名解析。
    2、如果hosts里没有这个域名的映射，则查找本地DNS解析器缓存，是否有这个网址映射关系，如果有，直接返回，完成域名解析。
    3、如果hosts与本地DNS解析器缓存都没有相应的网址映射关系，首先会找TCP/ip参数中设置的首选DNS服务器，在此我们叫它本地DNS服务器，此服务器收到查询时，如果要查询的域名，包含在本地配置区域资源中，则返回解析结果给客户机，完成域名解析，此解析具有权威性。
    4、如果要查询的域名，不由本地DNS服务器区域解析，但该服务器已缓存了此网址映射关系，则调用这个IP地址映射，完成域名解析，此解析不具有权威性。
    5、如果本地DNS服务器本地区域文件与缓存解析都失效，则根据本地DNS服务器的设置（是否设置转发器）进行查询，如果未用转发模式，本地DNS就把请求发至13台根DNS，根DNS服务器收到请求后会判断这个域名(.com)是谁来授权管理，并会返回一个负责该顶级域名服务器的一个IP。本地DNS服务器收到IP信息后，将会联系负责.com域的这台服务器。这台负责.com域的服务器收到请求后，如果自己无法解析，它就会找一个管理.com域的下一级DNS服务器地址(http://qq.com)给本地DNS服务器。当本地DNS服务器收到这个地址后，就会找http://qq.com域服务器，重复上面的动作，进行查询，直至找到www.qq.com主机。
    6、如果用的是转发模式，此DNS服务器就会把请求转发至上一级DNS服务器，由上一级服务器进行解析，上一级服务器如果不能解析，或找根DNS或把转请求转至上上级，以此循环。不管是本地DNS服务器用是是转发，还是根提示，最后都是把结果返回给本地DNS服务器，由此DNS服务器再返回给客户机。https://www.nslookuptool.com 可以查询在进行DNS修改后，域名被各个地区的域名服务器收录的情况，以及当前收录的域名对应的ip地址。


### 一些信息

13台根DNS服务器在全球的放置:

    美国VeriSign公司 2台
    美国PSINet公司 1台
    美国ISI(Information Sciences Institute) 1台
    美国ISC(Internet Software Consortium) 1台
    美国马里兰大学(University of Maryland) 1台
    美国太空总署(NASA) 1台
    美国国防部 1台
    美国陆军研究所 1台
    挪威NORDUnet 1台
    日本WIDE(Widely Integrated Distributed Environments)研究计划 1台
    网络管理组织IANA(Internet Assigned Number Authority) 1台
    欧洲网络管理组织RIPE-NCC(Resource IP Europeens Network Coordination Centre) 1台

CANN在中国大陆授权的10家国际域名注册商:

    ChinaSource Internet Service Co., Ltd.（中资源）
    ename Co.,Ltd.（易名中国）
    35 Technology Co., Ltd.（三五科技）
    Beijing Innovative Linkage Technology Ltd.（新网互联）
    Bizcn.com, Inc.（商务中国）
    HiChina Web Solutions (Hong Kong) Limited（万网）
    Inter China Network Software (Beijing) Co., Ltd.（3721）
    OnlineNIC, Inc.（厦门精通，即中国频道）
    Todaynic.com, Inc.（时代互联）
    Xin Net Technology Corporation（新网）



### dig命令的使用

$ dig +trace blog.zhaoweiguo.com:

    ; <<>> DiG 9.10.3-P4-Debian <<>> +trace blog.zhaoweiguo.com
    ;; global options: +cmd
    .     172206  IN  NS  m.root-servers.net.
    .     172206  IN  NS  b.root-servers.net.
    .     172206  IN  NS  c.root-servers.net.
    .     172206  IN  NS  d.root-servers.net.
    .     172206  IN  NS  e.root-servers.net.
    .     172206  IN  NS  f.root-servers.net.
    .     172206  IN  NS  g.root-servers.net.
    .     172206  IN  NS  h.root-servers.net.
    .     172206  IN  NS  i.root-servers.net.
    .     172206  IN  NS  j.root-servers.net.
    .     172206  IN  NS  a.root-servers.net.
    .     172206  IN  NS  k.root-servers.net.
    .     172206  IN  NS  l.root-servers.net.
    .     172206  IN  RRSIG NS 8 0 518400 20190323050000 20190310040000 16749 . TgmuL0MjWMidemDVGJC+v5G2BsE33xO5rayFm8qYfOLlNh8kiM9MtLsD Xicpzchrt3/OI+mOh2t/UyQJ4njI1PTP3MXwkUIgVHEx8rF5vYJKrMyP E4Mohd8XZ2nClb6qyvWk+dIYwE14aPpIonkU7L2wE4uxiGCl6lW9Q0GL j8UDyi4D7UkEHJ8qVebWzYDSeuhv+kWRHJqY7M1/MY/HezA1h6qNyw08 FmRGpf+/xT8bahzIQ1wY9yQwOmBjFhB6KZIxehsB/1HEHP44QuCQRz3R gI4IHwuDW+vw9wOvhM4lqLukONqQ7p3/xHFGlgKyYA+EboF/0QgPaXtF 7ri06w==
    ;; Received 525 bytes from 8.8.4.4#53(8.8.4.4) in 33 ms

    说明:
      从本地递归dns(8.8.4.4)取出13台全球根域名服务器的地址
      继续向这13台全球根域名服务器请求.com顶级域名服务器地址，以最先回复的为准

    com.      172800  IN  NS  a.gtld-servers.net.
    com.      172800  IN  NS  b.gtld-servers.net.
    com.      172800  IN  NS  c.gtld-servers.net.
    com.      172800  IN  NS  d.gtld-servers.net.
    com.      172800  IN  NS  e.gtld-servers.net.
    com.      172800  IN  NS  f.gtld-servers.net.
    com.      172800  IN  NS  g.gtld-servers.net.
    com.      172800  IN  NS  h.gtld-servers.net.
    com.      172800  IN  NS  i.gtld-servers.net.
    com.      172800  IN  NS  j.gtld-servers.net.
    com.      172800  IN  NS  k.gtld-servers.net.
    com.      172800  IN  NS  l.gtld-servers.net.
    com.      172800  IN  NS  m.gtld-servers.net.
    com.      86400 IN  DS  30909 8 2 E2D3C916F6DEEAC73294E8268FB5885044A833FC5459588F4A9184CF C41A5766
    com.      86400 IN  RRSIG DS 8 1 86400 20190324050000 20190311040000 16749 . qNqvX6qD9q7IJMn09ue59cubovzfECVYmWPmNUdHtDEiaBIjNFP8oaA7 pT4B/JA43tQTsPF1B9wC/zivN63n7xv4fNpdY2rXXgGsZX9ycme22kKt dZ/kV6rpiMoSCvZ8qmUlWWKkiq3aXYCYVznWoA9s3xM8oFUNG839N1ke OWiYQlGZn8LoETkUiPG4qCsARNdb/DMrj0BOywzYhO00lc/DnyHvgbT5 l7Dzi+Abxs2jZohrz270A19Sed9l2xulBq+6Y4ryxFYhr6hk6pZ0PqgJ tnMDI05n2mMls0xmpE61u/V2mJxSGAcb3s6UTAlXIPENnx23q4YeLgy/ zh058A==
    ;; Received 1179 bytes from 192.58.128.30#53(j.root-servers.net) in 308 ms

    说明:
      最先回复的根域名服务器是j.root-servers.net(192.58.128.30)
      返回13台.com顶级域名服务器的域名和地址，继续向这些.com顶级域名服务器请求
      查询zhaoweiguo.com二级域名服务器地址

    zhaoweiguo.com.   172800  IN  NS  dns9.hichina.com.
    zhaoweiguo.com.   172800  IN  NS  dns10.hichina.com.
    CK0POJMG874LJREF7EFN8430QVIT8BSM.com. 86400 IN NSEC3 1 1 0 - CK0Q1GIN43N1ARRC9OSM6QPQR81H5M9A  NS SOA RRSIG DNSKEY NSEC3PARAM
    CK0POJMG874LJREF7EFN8430QVIT8BSM.com. 86400 IN RRSIG NSEC3 8 2 86400 20190316044521 20190309043521 16883 com. DHkCBLG4YbAgDR7yj/Qu+LD/prXqR7NdPThP3mqis2aQcYw2WC6Y5Baq fCdYF1c1bgT9oBe/SusdZgqT56CzrXoF+G1MwRIrMdHCUHvR6BU28GCw 2rJJ9wcmrri2+mWHA0W1qBpt8bm0K3/V2FmLDtit0bJyUyZkfQ8BtRBB hZ8=
    KOHGII341DQ77IRB2UN8I8B4L5DQADV9.com. 86400 IN NSEC3 1 1 0 - KOHGO5POINBII7KFF2Q6VC4IKISTH7NC  NS DS RRSIG
    KOHGII341DQ77IRB2UN8I8B4L5DQADV9.com. 86400 IN RRSIG NSEC3 8 2 86400 20190318045050 20190311034050 16883 com. gHTSd9Z23gcTTVjl8dLYUBhGXZrMXITQd0q1JwJd+copTe6F+gcIG8DX LhiGiGO2XQtbovo6Lfe9QWtLj3yBa6apIQ2XSab+VpJugPASNDu/8zKX 2v4sPVqvm1kjcIMX6nPwcQVVyAFcVu5uKTH+344QWf8lbpBmCwfNk2TW /0Y=
    ;; Received 892 bytes from 192.43.172.30#53(i.gtld-servers.net) in 267 ms

    说明:
      最先回复的.com顶级域名服务器是i.gtld-servers.net(192.42.93.30)
      (gtld是global top level domain的缩写)
      返回2台zhaoweiguo.com二级域名服务器的域名和地址
      继续向这2个结果请求查询blog.zhaoweiguo.com三级域名服务器

    blog.zhaoweiguo.com.  600 IN  CNAME zhaoweiguo.github.io.
    ;; Received 82 bytes from 106.11.141.116#53(dns10.hichina.com) in 43 ms
    
    说明:
      最先回复的zhaoweiguo.com二级域名服务器是dns10.hichina.com(106.11.141.116)
      返回1个A记录，其中A记录就是最终的解析地址
    注意:
      如果阿里域名用dnspod解析,会多出2条NS记录
      blog.zhaoweiguo.com.  600 IN  A 115.29.97.185
      zhaoweiguo.com.    86400 IN  NS  f1g1ns1.dnspod.net.
      zhaoweiguo.com.    86400 IN  NS  f1g1ns2.dnspod.net.


### 小结

从整体对DNS有了大概的了解，很细节的东西还不是很清楚，需要自己手动搭建一个DNS服务实践一下
从现在的了解的情况来看，有几个时间:

1. 域名解析时的TTL:递归DNS缓存过期时间:

    大多设置为10分钟
    域名请求递归DNS时，会直接从缓存中取数据，数据过期后，可能会:
      a. 直接请求顶级DNS，取得权威DNS，再请求二级权威DNS得到ip
      b. a请求超时，请求根DNS，再依次取得顶级DNS，二级权威DNS得到ip

2. 顶级DNS更新权威DNS时间:

    这个大多是48小时内，最高可达72小时
    这也是我们遇到这个问题的根源所在

### 一些实用网站

https://www.nslookuptool.com
https://www.17ce.com

### 参考资料

https://www.dns.com/supports/681.html
https://www.jianshu.com/p/babca8224e60

