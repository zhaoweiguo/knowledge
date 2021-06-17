.. _ufw:

ufw——ubuntu防火墙命令
==========================

* ufw 使用范例::

    //允许 53 端口
    ufw allow 53
    //禁用 53 端口
    ufw delete allow 53
    //允许 80 端口
    ufw allow 80/tcp
    //允许 smtp 端口
    ufw allow smtp


    //允许某特定 IP
    ufw allow from 192.168.254.254
    //删除上面的规则
    ufw delete allow from 192.168.254.254
    // 允许指定ip段访问 
    ufw allow from 10.0.0.0/8

    开启/禁用
    ufw allow|deny [service]


* ufw ubuntu防火墙简单设置::

    sudo apt-get install ufw

    //启用
    sudo ufw enable
    sudo ufw default deny
    运行以上两条命令后，开启了防火墙，并在系统启动时自动开启。 
    关闭所有外部对本机的访问，但本机访问外部正常。

      打开或关闭某个端口，例如::

        sudo ufw allow smtp　允许所有的外部IP访问本机的25/tcp (smtp)端口 
        sudo ufw allow 22/tcp 允许所有的外部IP访问本机的22/tcp (ssh)端口 
        sudo ufw allow 53 允许外部访问53端口(tcp/udp) 
        sudo ufw allow from 192.168.1.100 允许此IP访问所有的本机端口 
        sudo ufw allow proto udp 192.168.0.1 port 53 to 192.168.0.2 port 53 
        sudo ufw deny smtp 禁止外部访问smtp服务 
        sudo ufw delete allow smtp 删除上面建立的某条规则

    * 查看防火墙状态::

        sudo ufw status

    * 开启/关闭防火墙 (默认设置是’disable’)::

        # ufw enable|disable

    * 转换日志状态::

        # ufw logging on|off

    * 设置默认策略 (比如 “mostly open” vs “mostly closed”)::

        # ufw default allow|deny

    * 许 可或者屏蔽某些入埠的包 (可以在“status” 中查看到服务列表［见后文］)。可以用“协议：端口”的方式指定一个存在于/etc/services中的服务名称，也可以通过包的meta-data。 ‘allow’ 参数将把条目加入 /etc/ufw/maps ，而 ‘deny’ 则相反。基本语法如下::

        # ufw allow|deny [service]


其他防火墙::

    lokkit
