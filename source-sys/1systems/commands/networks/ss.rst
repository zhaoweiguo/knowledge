ss命令
#########

ss 是 socket statistics 的缩写。顾名思义，ss 命令可以用来获取tcp socket 统计信息
ss 的优势在于它能够显示更多更详细的有关TCP和连接状态的信息，而且比netstat更快速更高效
当服务器的socket连接数量变得非常大时，无论是使用netstat命令还是 cat  /proc/net/tcp，执行速度都会很慢
当服务器维持的连接达到上万个的时候，使用 netstat 等于浪费生命，而用 ss才是 节省时间

利用了TCP协议栈中 tcp_diag.   tcp_diag 是一个用于分析统计的模块，可以获得Linux 内核中第一手的信息，这就确保了ss的快捷高效。当然，如果你的系统中没有 tcp_diag,ss也可以正常运行，只是效率会变得稍慢


实例::

    1. 显示TCP连接:
    　　    ss -t -a
    2. 显示 sockets  摘要
    　　    ss -s
    3. 列出当前的established、 closed、 orphaned  and  waiting  TCP sockets
        ss -l
    4. 查看进程使用的socket
        ss -pl
    5. 找出打开套接字/端口应用程序
        ss -lp | grep 3306
    6. 显示所有UDP  sockets
        ss   -u  -a
    7. 显示所有状态为 established  的 SMTP 连接
        ss -o state established `(  dport  =: smtp  or  sport  = : smtp )`
    8. 显示所有状态为 Established 的 HTTP 连接
        ss -o state established `(dport = :http or sport = :http)`
    9. 列举出处于 FIN-WAIT-1状态的源端口为80或者443,目标网络为192.168.1/24的所有tcp套接字
        ss -o state fin-wait-1 `(sport= :http or sport = :https)` dst 192.168.1/24
    10. 用TCP 状态过滤 sockets
        ss  -4 state <FILTER-NAME-HERE>
    　　　ss  -6 state <FILTER-NAME-HERE>
        其中<FILTER-NAME-HERE>:
          established
          syn-sent
          syn-recv
          fin-wait-1
          fin-wait-2
          time-wait
          closed
          close-wait
          last-ack
          listen
          closing
          all 
          connected       除了listen and closed 的所有状态
          synchronized 　　所有已连接的状态除了syn-sent
          bucket　　      显示状态为 maintained as minisockets,如time-wait和syn-recv.
          big　　         和bucket 相反
    11. 匹配远程地址和端口号
        ss  dst  ADDERSS_PATTERN
        ss  dst  192.168.1.1
        ss　dst　192.168.1.1:8080
    12. 匹配本地地址和端口号
        ss　　src  ADDRESS_PATTERN
        ss　　src　192.168.1.1
        ss　　src   192.168.1.1:80
    13. 将本地或者远程端口和一个数比较
        ss dport <OP> PORT    // 远程端口和一个数比较: destination port
        ss sport <OP> PORT    // 本地端口和一个数比较: source port
        <OP>:
          <=  or  le
          >=  or  ge
          ==  or  eq
          !=  or  ne
          <   or  gt
          >   or  lt
    14. ss  和  netstat 效率对比:
    　　　　　time  netstat  -at
    　　　　　time  ss






