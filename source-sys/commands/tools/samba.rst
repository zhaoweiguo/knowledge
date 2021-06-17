.. _samba:

samba——文件共享服务命令
==========================


* 安装samba::

    apt-get install samba;      //ubuntu下安装
    yum -y install samba        //centos下安装

* 配置文件地址::

    /etc/samba/smb.conf

* samba的使用::

    chkconfig smb on;   //设计samba自启动
    chkconfig --list smb;       //确认samba启动标签，确认2－5的on状态
    /etc/rc.d/init.d/smb start; //centos下的启动
    /etc/init.d/smbd start;      //ubuntu下的启动
    or
    service smbd start;


* 配置文件重要参数的配置(centos下的配置)::

    [global]
    workgroup=WORKGROUP  #WINDOWS下网络所定义的工作组
    hosts allow = 192.168.1 127.  # 指定内网ip及本地可访问

    [public] #定义公众共享目录
    path = /home/samba    #指定共享目录
    public = yes
    writable = yes      #赋予共享目录


* 使用samba标准用户数据库管理工具 ``smbpasswd`` 创建用于登录samba的用户数据，用 ``smbpasswd`` 创建用户的前提是: 系统中存在该用户::

    smbpasswd -a gordon           #将系统用户gordon加入到samba用户数据库中



