inet模块
#################

参数::

  inet_default_connect_options
    做connect时socket的返回时默认参数
  inet_default_listen_options
    listen调用时默认参数

修改默认参数::

  $ erl -sname test -kernel \
    inet_default_connect_options '[{delay_send,true}]' \
    inet_default_listen_options '[{delay_send,true}]'

IPv6实例::

  Address                  ip_address()
  -------                  ------------
  ::1                  {0,0,0,0,0,0,0,1}
  ::192.168.42.2       {0,0,0,0,0,0,(192 bsl 8) bor 168,(42 bsl 8) bor 2}
  ::FFFF:192.168.42.2
                       {0,0,0,0,0,16#FFFF,(192 bsl 8) bor 168,(42 bsl 8) bor 2}
  3ffe:b80:1f8d:2:204:acff:fe17:bf38
                       {16#3ffe,16#b80,16#1f8d,16#2,16#204,16#acff,16#fe17,16#bf38}
  fe80::204:acff:fe17:bf38
                       {16#fe80,0,0,0,0,16#204,16#acff,16#fe17,16#bf38}


  1> inet:parse_address("192.168.42.2").
  {ok,{192,168,42,2}}
  2> inet:parse_address("::FFFF:192.168.42.2").
  {ok,{0,0,0,0,0,65535,49320,10754}}


.. function:: inet:getaddr/2

结构::

  getaddr(Host, Family) -> {ok, Address} | {error, posix()}
  类型:
  Host = ip_address() | hostname()
  Family = inet | inet6 | local
  Address = ip_address()

说明::

  Returns the IP address for Host as a tuple of integers. Host can be an IP address, a single hostname, or a fully qualified hostname.

实例::

  erl> inet:getaddr("www.baidu.com", inet).
  {ok,{61,135,169,125}}
  
















