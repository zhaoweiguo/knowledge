.. _modprobe:

modprobe命令
#####################
载入、移除linux kernel


载入 ``ip_conntrack`` 模块::

    /sbin/modprobe ip_conntrack

br_netfilter
----------------
简介::

    透明防火墙(Transparent Firewall)又称桥接模式防火墙(Bridge Firewall)
    简单来说:就是在网桥设备上加入防火墙功能
    透明防火墙具有部署能力强、隐蔽性好、安全性高的优点。

在/etc/sysctl.conf中添加::

    net.bridge.bridge-nf-call-ip6tables = 1
    net.bridge.bridge-nf-call-iptables = 1 

执行sysctl -p 时出现::

    $> sysctl -p
    sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-ip6tables: No such file or directory
    sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-iptables: No such file or directory

解决方法::

    $> modprobe br_netfilter
    $> sysctl -p
    net.bridge.bridge-nf-call-ip6tables = 1
    net.bridge.bridge-nf-call-iptables = 1

查看内核模块::

    $> lsmod | grep br_netfilter
    br_netfilter           22209  0
    bridge                136173  1 br_netfilter

重启后模块失效,开机自动加载模块的脚本::

    $> 新增rc.sysinit 文件
    $> cat << EOF > /etc/rc.sysinit
    #!/bin/bash
    for file in /etc/sysconfig/modules/*.modules ; do
    [ -x $file ] && $file
    done
    EOF

    // 新增文件
    $> cat << EOF > /etc/sysconfig/modules/br_netfilter.modules
    modprobe br_netfilter
    EOF

    增加权限
    $> chmod 755 br_netfilter.modules









