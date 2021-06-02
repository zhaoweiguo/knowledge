.. _command_sshuttle:

sshuttle工具
############

* github [1]_

::

    开源协议: GNU LIBRARY GENERAL PUBLIC LICENSE
    语言: Python

安装::

    $ sudo apt-get install sshuttle
    $ brew install sshuttle

sshuttle 语法::

    sshuttle [options...][-r [username@]sshserver[:port]][subnets]

options::

    --dns,
    --auto-hosts, 
    --auto-nets


所有的网络通讯，包括DNS请求都会发送到你的SSH服务器::

    $ sshuttle –r <server> --dns 0/0

别名形式来简单快速的启动和停止安全隧道::

    alias tunnel=’sshuttle –D –pidfile=/tmp/sshuttle.pid –r <server> --dns 0/0’
    alias stoptunnel=’[[ -f /tmp/sshuttle.pid ]] && kill `cat /tmp/sshuttle.pid`’
    
不幸的是sshuttle只接受IP地址作为参数，不支持主机名，所以我们还得先用dig来解析出主机名::

    $ sshuttle –r <server> `dig +short <hostname>`


.. note:: 本质上这个工具是利用了端口转发的原理，并不是真正的VPN，所以对于ICMP这类的协议是没用的，也就是说，对于ping命令是无效的

.. warning:: 使用此功能,还是访问不了google等网站的原因是dns混淆,这个问题最简单的解决方法是手工配置hosts



实例
====

将10.0.0.0/8这个网段的请求走SSH代理::

    $ sshuttle -r user@remote_ip 10.0.0.0/8

增加debug日志::

    $ sshuttle -r username@sshserver 0.0.0.0/0 -vv


工具说明
========


* Sshuttle允许你通过任意一台可SSH访问的服务器来为你的流量建立安全的隧道。搭建和使用都非常简单，不需要你在服务器上安装任何软件或者修改任何本地代理设定。当你在非安全的公共WiFi或其他不受信任的网络中时，通过SSH让流量走安全隧道，这样就可避免类似Firesheep或dsniff这样的工具的侵扰
* 这个工具非常巧妙，利用iptables的端口转发功能，直接把指定目标网络的请求通过ssh代理到远程，实现了非常类似于VPN的功能，但是几乎零配置，开箱即用，非常方便。不过只支持*nix环境的系统(如Linux, FreeBSD, MacOS等等)
* 被其作者称为 “穷人的 VPN”（A poor man’s instant VPN），甚至不需要远端服务器的 root 权限就可以用（只需要一个普通 SSH 帐号），和在 Mac/Linux 客户端直接用 ssh -D 的方式有点类似
* 按照作者的说法 sshuttle 比 sshd -D 的方式快一点，因为 It’s just data-over-TCP，而不是 TCP-over-TCP，TCP-over-TCP 的方式会带来不必要的性能问题，因为 TCP 本身就是可靠传输协议，保证了包的有序性和无差错，并确保包被接受，如果有包丢失的话 TCP 协议可以自己立即重传弥补，所以没必要两层都 TCP，一层 TCP 就比较安全了。






.. [1] https://github.com/apenwarr/sshuttle