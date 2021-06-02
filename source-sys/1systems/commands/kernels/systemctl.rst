systemctl命令
==================
说明::

  centos7以上才有的命令
  cetnos6用的是service

使用::

  systemctl [command] [–type=TYPE] [–all]


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







