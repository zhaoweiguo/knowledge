gen_udp模块
###############



.. function:: open/1/2

::

    open(Port) -> {ok, Socket} | {error, Reason}
    open(Port, Opts) -> {ok, Socket} | {error, Reason}
    类型:
    Port = inet:port_number()
    Opts = [Option]
    Option = option()
    Socket = socket()
    Reason = inet:posix()

说明::

  将udp端口和调用进程相关联

可选项option()::

    {ip, inet:socket_address()} |
        % 多网口的服务器指定ip
    {fd, integer() >= 0} |
        % 如果socket不是由gen_udp打开的,可通过此option接收
    {ifaddr, inet:socket_address()} |
        % 类似选项{ip, Ip}
    inet:address_family() |
        % inet | inet6 | local
    {port, inet:port_number()} |
    {netns, file:filename_all()} |
    {bind_to_device, binary()} |
    {active, true | false | once | -32768..32767} |
    {add_membership, {inet:ip_address(), inet:ip_address()}} |
    {broadcast, boolean()} |
    {buffer, integer() >= 0} |
    {deliver, port | term} |
    {dontroute, boolean()} |
    {drop_membership, {inet:ip_address(), inet:ip_address()}} |
    {header, integer() >= 0} |
    {high_msgq_watermark, integer() >= 1} |
    {low_msgq_watermark, integer() >= 1} |
    {mode, list | binary} |
    list |  
      % 以list的形式提供收到的包
    binary |
        % 以binary的形式提供收到的包
    {multicast_if, inet:ip_address()} |
        % 设置multicast scoket的 local device
    {multicast_loop, boolean()} |
        % true: 发送的multicast packets被looped加到local socket.
    {multicast_ttl, integer() >= 0} |
        
    {priority, integer() >= 0} |
    {raw,
     Protocol :: integer() >= 0,
     OptionNum :: integer() >= 0,
     ValueBin :: binary()} |
    {read_packets, integer() >= 0} |
    {recbuf, integer() >= 0} |
    {reuseaddr, boolean()} |
    {sndbuf, integer() >= 0} |
    {tos, integer() >= 0} |
    {tclass, integer() >= 0} |
    {ttl, integer() >= 0} |
    {recvtos, boolean()} |
    {recvtclass, boolean()} |
    {recvttl, boolean()} |
    {ipv6_v6only, boolean()}



实例
------

server::

    {ok, Socket} = gen_udp:open(Port, [binary, {active, true}]).
    receive
        {udp, Socket, Host, Port, Bin} ->
            io:format("Host=~p, Port=~p, 内容:~p~n", [Host,Port,Bin])
    end.

client::

    {ok, Socket} = gen_udp:open(0, [binary, {active, true}]).
    ok = gen_udp:send(Socket, "localhost", 8888, "aaa").







