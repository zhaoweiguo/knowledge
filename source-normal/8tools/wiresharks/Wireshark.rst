Wireshark命令
#############

技巧::

    右键Follow TCP Stream就可以看到完整的HTTP通信内容
    PS: 在filter中会有tcp.stream eq xx的字样, 说明就是过滤出了tcp.stream == xx的包而已
    以后遇到这种类型的包, 或是想查看完整的HTTP通信过程就方便多了, 不用一个个包去找了


mac使用事项::

  // wireshark在mac下打开监控不到网卡时
  // 把以下文件修改为有权限
  chgrp admin /dev/bpf*
  chmod g+rw /dev/bpf*


常用查询条件::

    ip.addr==39.107.212.12

协议::

    tcp
    http
    icmp
    TLSv1.2

ip实例::

    % 与ip:39.107.212.12的http请求
    ip.addr==39.107.212.12 and 
    % 指定目的地址ip
    ip.dst==39.107.212.12 and tcp
    % 源地址
    ip.src==39.107.212.12 and tcp

    ip段:
    ip.addr == 100.100.1.1/16

    与:
    ip.addr == 10.140.100.6) && ip.addr == 100.100.105.70
    或:
    ip.addr == 10.140.100.6) || ip.addr == 100.100.105.70
    非:
    !(ip.addr == 10.140.100.32)

    只查ip:
    ip
    只查ip6:
    ipv6


其他::

    离线流量分析
    · Wireshark/tshark
    ·dsniff
    ·ngrep


参考
====

* https://www.toutiao.com/i6831824844280037892/

