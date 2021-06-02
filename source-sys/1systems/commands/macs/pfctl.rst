pfctl命令
#########

iptables是Linux下的防火墙，可以进行数据包的过滤，在网络层进行数据的转发、拦截或丢弃等，使用非常普遍，功能也非常强大。但是Mac下没有iptables，为了实现流量转发和过滤，要使用到Mac自带的PFctl。PFctl即control the packet filter，是Unix LIKE系统上进行TCP/IP流量过滤和网络地址转换的系统，也能提供流量整形和控制等，详情可以见PF防火墙。

使用::

    pfctl -e 开始pfctl
    pfctl -d 结束pfctl
    pfctl -f 载入pf.conf
    pfctl -nf /etc/pf.conf 解析文件，但不载入
    pfctl -Rf /etc/pf.conf 只载入文件中的过滤规则
    pfctl -sn 显示当前的NAT规则
    pfctl -sr 显示当前的过滤规则
    pfctl -ss 显示当前的状态表
    pfctl -si 显示过滤状态和计数
    pfctl -sa 显示任何可显示的







