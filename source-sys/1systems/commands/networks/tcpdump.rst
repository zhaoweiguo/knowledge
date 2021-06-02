.. _tcpdump:

tcpdump命令
######################

.. highlight:: console

::

    tcpdump [ -adeflnNOpqStvx ] [ -c 数量 ] [ -F 文件名 ]
    [ -i 网络接口 ] [ -r 文件名] [ -s snaplen ][ -T 类型 ] [ -w 文件名 ] [表达式 ]

tcpdump的选项介绍::

    -a       将网络地址和广播地址转变成名字；
    -d       将匹配信息包的代码以人们能够理解的汇编格式给出；
    -dd      将匹配信息包的代码以c语言程序段的格式给出；
    -ddd     将匹配信息包的代码以十进制的形式给出；
    -e       在输出行打印出数据链路层的头部信息；
    -f       将外部的Internet地址以数字的形式打印出来；
    -l       使标准输出变为缓冲行形式；
    -n       不把网络地址转换成名字；
    -t 　　　 在输出的每一行不打印时间戳；
    -v 　　　 输出一个稍微详细的信息，例如在ip包中可以包括ttl和服务类型的信息；
    -vv 　　　输出详细的报文信息；
    -c 　　　 在收到指定的包的数目后，tcpdump就会停止；
    -F 　　　 从指定的文件中读取表达式,忽略其它的表达式；
    -i 　　　 指定监听的网络接口；
    -r 　　　 从指定的文件中读取包(这些包一般通过-w选项产生)；
    -w 　　　 直接将包写入文件中，并不分析和打印出来；
    -T 　　　 将监听到的包直接解释为指定的类型的报文，常见的类型有rpc(远程过程调用)和snmp(简单网络管理协议；)

    #tcpdump －A  把每一个packet都用以ASCII的形式打印出来
    #tcpdump -X    以十六进制以及ASCII的形式打印数据内容
    #tcpdump -x     除了打印出header外，还打印packet里面的数据(十六进制的形式)
    #tcpdump -Xx  以十六进制的形式打印header, data内容


<表达式>说明::

    表达式是一个正则表达式，tcpdump利用它作为过滤报文的条件

    在表达式中一般如下几种类型的关键字:
    一、关于类型的关键字，主要包括host, net, port, 例如:

    host 210.27.48.2，指明210.27.48.2是一台主机
    net 202.0.0.0指明202.0.0.0是一个网络地址
    port 23指明端口号是23
    // 如果没有指定类型，缺省的类型是host.

    二、确定传输方向的关键字，主要包括
    1.src
    2.dst
    3.dst or src
    4.dst and src
    这些关键字指明了传输的方向，如:
    1.src 210.27.48.2,指明ip包中源地址是210.27.48.2
    2.dst net 202.0.0.0指明目的网络地址是202.0.0.0
    // 如果没有指明方向关键字，则缺省是src or dst关键字

    三、协议的关键字，主要包括fddi, ip ,arp, rarp, tcp, udp等类型
    1.fddi指明是在FDDI(分布式光纤数据接口网络)上的特定的网络协议，实际上它是"ether"的别名，fddi和ether具有类似的源地址和目的地址，所以可以将fddi协议包当作ether的包进行处理和分析
    // 如果没有指定任何协议，则tcpdump将会监听所有协议的信息包。
    
    四、除了这三种类型的关键字之外，其他重要的关键字如下:
    gateway, broadcast, less, greater
    还有三种逻辑运算:
    1.取非运算是 'not', '!'
    2.与运算是'and', '&&'
    3.或运算是'or', '||

主要参考命令::

    // -n: 不把ip转换为机器名字
    // -i: 指定监听的网络接口
    tcpdump tcp -n -i eth0 port 25 and host 211.147.1.11

    // portrange: 端口范围
    tcpdump portrange 10-20 host 210.27.48.1 and \(210.27.48.2 or 210.27.48.3 \)

    // 快速查看:
    // -i any:表示监听所有网络接口
    // -w -: -w为把内容write到某个地方， -表示标准输出  也就是输出到标准输出中
    // -w - |strings:   这是一个超级有用的命令,把包的数据，用字符展示出来
    #tcpdump -i any -w - dst port 3306 |strings  

    // 读写相关
    // 如果a.cap 超过1M大小, 则新开一个文件
    // －C fileSize: 单位是MB 
    #tcpdump  -C 1  -w a.cap
    // -r: 读文件
    #tcpdump -n -r a.cap  




其他命令::

    // 主机210.27.48.1除了和主机210.27.48.2之外所有主机通信的ip包::
    tcpdump ip host 210.27.48.1 and !210.27.48.2

    // 主机210.27.48.1接收或发出的smtp包::
    tcpdump tcp port 25 and host 210.27.48.1

    // 如果怀疑系统正受到拒绝服务(Dos)攻击,网络管理员可以通过截获发往本机的所有ICMP包,来确实目前是否有大量的ping指令流向服务器,此时可用如下指令:
    tcpmdump icmp -n -i eth0

    // 只抓 SYN 包
    # tcpdump -i eth1 'tcp[tcpflags] = tcp-syn'
    // 抓 SYN, ACK
    # tcpdump -i eth1 'tcp[tcpflags] & tcp-syn != 0 and tcp[tcpflags] & tcp-ack != 0'


    // 主机210.27.48.1和主机210.27.48.2或210.27.48.3间10-20端口的通信:
    // portrange: 商品范围
    tcpdump portrange 10-20 host 210.27.48.1 and \(210.27.48.2 or 210.27.48.3 \)



实践（用tcpdump抓包，然后用wireShark分析）::

    // 实例1:
    -t: 在输出的每一行不打印时间戳
    -tt 在每一行中输出非格式化的时间戳。 
    -ttt 输出本行和前面一行之间的时间差。 
    -tttt 在每一行中输出由date处理的默认格式的时间戳。 
    -s: -s <snaplen>
    -c: 在收到指定的包的数目后，tcpdump就会停止
    -w: 直接将包写入文件中，并不分析和打印出来
    tcpdump tcp -i eth1 -t -s 0 -c 100 and dst port ! 22 and src net 192.168.1.0/24 -w ./target.cap


    // 实例2: 抓 SMTP 数据
    // 抓取数据区开始为"MAIL"的包，"MAIL"的十六进制为 0x4d41494c。
    # tcpdump -i eth1 '((port 25) and (tcp[(tcp[12]>>2):4] = 0x4d41494c))'

    // 实例3: 抓 HTTP GET 数据
    // "GET "的十六进制是 47455420
    # tcpdump -i eth1 'tcp[(tcp[12]>>2):4] = 0x47455420'

    // 实例4: 抓 SSH 返回
    // "SSH-"的十六进制是 0x5353482D
    # tcpdump -i eth1 'tcp[(tcp[12]>>2):4] = 0x5353482D'
    // '抓老版本的 SSH 返回信息，如"SSH-1.99.."
    # tcpdump -i eth1 '(tcp[(tcp[12]>>2):4] = 0x5353482D) and (tcp[((tcp[12]>>2)+4):2]= 0x312E)'

    // 实例5: 抓 DNS 请求数据
    // -nnAl: @todo ?
    # tcpdump -i eth1 udp dst port 53

    // 实例6:其他
    // 计算抓 10000 个 SYN 包花费多少时间，可以判断访问量大概是多少
    # time tcpdump -nn -i eth0 'tcp[tcpflags] = tcp-syn' -c 10000 > /dev/null




参考文档:

http://www.itshouce.com.cn/linux/linux-tcpdump.html










