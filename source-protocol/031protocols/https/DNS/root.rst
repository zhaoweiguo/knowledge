根 DNS 服务器
#############

全球 DNS 总共有 13 个根::

    编号  IPv4 地址      IPv6 地址             运营组织
    A   198.41.0.4     2001:503:ba3e::2:30   Verisign(美国 VeriSign 公司)
    B   192.228.79.201 2001:478:65::53       USC-ISI(美国ISI: Information Sciences Institute)
    C   192.33.4.12    2001:500:2::c         Cogent Communications
    D   199.7.91.13    2001:500:2d::d        University of Maryland(美国马里兰大学)
    E   192.203.230.10 --                    NASA(美国太空总署)
    F   192.5.5.241    2001:500:2f::f        Internet Systems Consortium(美国 ISC)
    G   192.112.36.4   --                    Defense Information Systems Agency(美国国防部)
    H   128.63.2.53    2001:500:1::803f:235  U.S. Army Research Lab(美国陆军研究所)
    I   192.36.148.17  2001:7fe::53          Netnod
    J   192.58.128.30  2001:503:c27::2:30    Verisign(美国 VeriSign 公司)
    K   193.0.14.129   2001:7fd::1           RIPE NCC(欧洲网络管理组织)
    L   199.7.83.42    2001:500:3::42        ICANN
    M   202.12.27.33   2001:dc3::35          WIDE Project(日本Widely Integrated Distributed Environments)


说明::

    总长度最多为 576 字节的 IP 数据报
    576 字节允许传输 512 字节的数据块加上 64 字节的头部在一个数据报中

    最多可以添加 15 台根域名服务器
    现在只有13台是为了保留一定的空间方便未来进行扩展


扩展
====

任播::

    DNS 是任播最成功的应用，早在 2002 年 F 根域名服务器就开始实行任播
    在 RFC 3258 中也记录了权威名称服务器部署在任播上的内容

    在 RFC 4786 与 RFC 7094 中记录了更多关于任播工作的内容。

    不再有 512 字节限制后的 DNS

CANN在中国大陆授权的10家国际域名注册商::

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





参考
====

* 【知乎】根域名服务器只有 13 台: https://zhuanlan.zhihu.com/p/107492241
* 【官网】13个根DNS: https://root-servers.org/



