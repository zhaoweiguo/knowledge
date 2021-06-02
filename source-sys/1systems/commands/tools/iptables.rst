.. _iptables:

iptables——防火墙命令
####################

* 名字: IPv4包过滤及NAT管理工具

* iptables官方网站：http://netfilter.org/

* 用法::

    iptables -[AD] chain rule-specification [options]
    iptables -I chain [rulenum] rule-specification [options]
    iptables -R chain rulenum rule-specification [options]
    iptables -D chain rulenum [options]
    iptables -[LS] [chain [rulenum]] [options]
    iptables -[FZ] [chain] [options]
    iptables -[NX] chain
    iptables -E old-chain-name new-chain-name
    iptables -P chain target [options]
    iptables -h (print this help information)


* 维护规则表的命令:

    * iptables -L(--list) [chain]: 列出规则表中的规则  
    * iptables -N(--new) chain: 创建一个新规则表
    * iptables -X(--delete-chain) [chain]: 删除一个空规则表
    * iptables -P(--policy) chain target: 改变内建规则表的默认策略
    * iptables -F(--flush) [chain]: 清空规则表中的规则
    * iptables -Z(--zero) [chain]: 将规则表计数器清零

* 管理规则表中规则:

    * iptables -A(--append) chain: 添加新规则到规则表
    * iptables -I(--insert) chain [rulenum]: 插入新规则到规则表的某个位置
    * iptables -R(--replace) chain rulenum: 替换规则表中的规则
    * iptables -D(--delete) chain rulenum: 删除规则表中的某条规则

* 选项

    -p(--proto) [!] proto: 协议(名字或数字)
    -s(--source) [!] address[/mask]: source specification


基本
----

查看::

    iptables -L
    iptables -L -n
    iptables -L -n --line-number

设置默认规则::

    // 默认DROP
    iptables -P INPUT DROP
    // 默认ACCEPT
    iptables -P INPUT ACCEPT




增加规则
--------

* 关闭所有的 INPUT FORWARD OUTPUT 只对某些端口开放::

    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT DROP

* 增加禁止192.168.0.2访问::

     iptables -A INPUT -p tcp -s 192.168.1.2 -j DROP

* 增加打开22端口::

    iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT


删除规则
--------

1. 按编号删除::

    //找到规则编号:
    iptables -L -n --line-number
    //删除:
    iptables -D INPUT 2

2. 按内容匹配删除::

    iptables -D INPUT -s 192.168.0.1 -j DROP


修改规则
--------

::

    iptables -R INPUT 3 -j ACCEPT #将原来3的规则改为-j ACCEPT



    
注意
-----

[重要]这样的设置好，只是临时的，重启服务器还是会恢复原来没有设置的状态还要使用::

    service iptables save

到信息 firewall rules 防火墙的规则 其实就是保存在::

    emacs  /etc/sysconfig/iptables


实战
====

使用iptables将包含某字符串的域名解析请求重定向至指定dns服务器::

    $ iptables -t nat -A PREROUTING -p udp --dport 53 -m string --hex-string "aabb|03|com" -j DNAT --to-destination 10.168.77.1
    // 把包含此字符串的发向53端口的udp的包都重定向到10.168.77.1



参考
====

* 使用iptables将包含某字符串的域名解析请求重定向至指定dns服务器: https://blog.csdn.net/Chris_Tsai/article/details/82320968




