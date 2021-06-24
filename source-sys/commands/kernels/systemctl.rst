systemctl命令
==================

.. note:: 摘要: systemctl 是系统服务管理器命令，它实际上将 service 和 chkconfig 这两个命令组合到一起。centos7以上才有的命令，cetnos6用的是service和 chkconfig两个命令



使用::

  systemctl [command] [–type=TYPE] [–all]

相关目录::

    /usr/lib/systemd/system (Centos) 
    或 /etc/systemd/system (Ubuntu)

    主要有四种类型文件.mount,.service,.target,.wants
    现在主要了解「service」相关


实例::

  #启动网络服务
  systemctl start network.service
  #停止网络服务
  systemctl stop network.service
  #重启网络服务
  systemctl restart network.service
  #查看网络服务状态
  systemctl status network.serivce


查看系统上上所有的服务::

  systemctl 列出所有的系统服务
  systemctl list-units  列出所有启动unit
  systemctl list-unit-files 列出所有启动文件
  systemctl list-units –type=service –all 列出所有service类型的unit
  systemctl list-units –type=service –all grep cpu  列出 cpu电源管理机制的服务
  systemctl list-units –type=target –all  列出所有target

systemctl特殊的用法::

  #查看网络服务是否启动
  systemctl is-active network.service
  #检查网络服务是否设置为开机启动
  systemctl is-enable network.service
  #注销cups服务
  systemctl mask cups.service
  #查看cups服务状态
  systemctl status cups.service
  #取消注销cups服务
  systemctl unmask cups.service


systemctl与之前命令对比::

    1. 使某服务自动启动:
        chkconfig --level 3 httpd on
        =>
        systemctl enable httpd.service
    2. 使某服务不自动启动
        chkconfig --level 3 httpd off
        =>
        systemctl disable httpd.service
    3. 检查服务状态
        service httpd status  
        =>
        systemctl status httpd.service （服务详细信息） 
        systemctl is-active httpd.service （仅显示是否 Active)
    4. 显示所有已启动的服务
        chkconfig --list  
        =>
        systemctl list-units --type=service
    5. 启动某服务
        service httpd start
        =>
        systemctl start httpd.service
    6. 停止某服务
        service httpd stop 
        =>
        systemctl stop httpd.service
    7. 重启某服务
        service httpd restart
        =>
        systemctl restart httpd.service










