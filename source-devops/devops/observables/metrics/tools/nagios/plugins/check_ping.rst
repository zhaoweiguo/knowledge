.. _check_ping:

check_ping使用
##################


* 用法::

    check_ping check_ping -H <host_address> 
     -w <wrta>,<wpl>% -c <crta>,<cpl>%
     [-p packets] [-t timeout] [-4|-6]

* 选项::

    -h: 主机ip
    -w: warning状态(响应时间(毫秒),丢包率[%])
    -c: critical状态(响应时间(毫秒),丢包率[%])
    -p:发送的包数(默认5个包)
    -t:超时时间(默认10秒)
    [-4/-6]:使用ipv4|ipv6 地址

* 举例::

    check_ping -H 58.56.108.130 -w 100.0,20% -c 500.0,60% -p 5
    //正常結果(echo $?为0)
    PING OK - Packet loss = 0%, RTA = 1.49 ms
    //WARNING結果(echo $?为1)
    PING WARNING - Packet loss = 0%, RTA = 1.71 ms
    //CRITICAL結果(echo $?为2)
    PING CRITICAL - Packet loss = 0%, RTA = 1.60 ms
