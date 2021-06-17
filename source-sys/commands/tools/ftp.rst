.. _ftp:

ftp命令使用
#####################

.. index:: db_load, pam

启动FTP服务器::

    service vsftpd start

::

   默认的ftp服务器目录: /var/ftp/pub
   匿名身份用户: anonymous
   ftp配置文件: /etc/vsftpd/vsftpd.conf

基本命令::

    ftp <ip> <port>
    mget <fileName>
    put <fileName>



vsftpd使用简介 [1]_
======================

Vsftpd服务器的文件结构如下::

    # rpm -ql vsftpd   ##查看在安装vftpd软件包时，所产生的配置文件。(这里只做常用的文件)  
    /usr/sbin/vsftpd    ##Vsftpd主程序  
    /etc/rc.d/init.d/vsftpd    ##用于启动终止脚本  
    /etc/vsftpd/vsftpd.conf     ##Vsftpd主配置文件  
    /etc/pam.d/vsftpd           ##PAM认证文件  
    /etc/vsftpd.ftpusers        ##禁止使用Vsftpd的用户列表  
    /etc/vsftpd.user_list       ##禁止或允许使用Vsftpd的用户列表  
    /var/ftp        ##匿名用户的下载目录  
    /var/ftp/pub    ##匿名用户默认访问目录  
    /etc/logrotate.d/vsftpd.log     ##vsftpd的日志文件


# vim /etc/vsftpd/vsftpd.conf::

    #anonymous_enable=YES           ##允许匿名访问，即anonymous账号访问FTP服务  
    #local_enable=YES               ##允许本地用户登录FTP服务器  
    #write_enable=YES               ##本地用户可以读写  
    #local_umask=022                ##默认掩码为022,默认创建的文件权限为755  
    #anon_upload_enable=YES         ##允许匿名用户上传文件，基于安全因素考虑，默认vsftpd是注释此项  
    #anon_mkdir_write_enable=YES    ##是否允许匿名用户创建目录，基于安全因素考虑，默认vsftpd是注释此项  
    dirmessage_enable=YES           ##如果目录存在.message隐藏文件时，当进入此目录时，会显示.message里面的内容  
    xferlog_enable=YES              ##默认记录上传、下载的日志文件，是否开启此功能  
    #xferlog_file=/var/log/xferlog  ##Vsftpd的日志存放位置  
    connect_from_port_20=YES        ##从端口20连接，默认状态下，20端口为数据传输端口  
    #chown_uploads=YES  
    #chown_username=whoever         ##此两选项必须同时出现，含义为,允许新上传文件的拥有者为whoever，默认这两行被注释到得。  
    xferlog_std_format=YES          ##使用标准格式上传/下载  
    #data_connection_timeout=120    ##传输延时时间，当时间超过120秒后，会自动断开，默认是注释掉的。  
    #nopriv_user=ftpsecure          ##使用特殊用户ftpsecure，这里可以把ftpsecure账户作为一般访问用户，所有连接FTP服务器的用户都具有ftpsecure用户名。  
    基于安全因素考虑，可以在/etc/passwd中将ftpsecure的用户shell设置为/sbin/nologin(禁止登陆操作系统）  
    #async_abor_enable=YES          ##取消下载后客户端不挂起，一般不需要设置。  
    #ascii_upload_enable=YES  
    #ascii_download_enable=YES      ##是否启用ASCII方式传送文件，一般我们不需要这个格式。  
    #ftpd_banner=Welcome to blah FTP service.       ##登陆FTP服务器，所提示的信息，默认注释掉的。  
    #deny_email_enable=YES  
    #banned_email_file=/etc/vsftpd/banned_emails    ##若是启用以上两个选项，则可以在/etc/vsftpd/banned_emails中建立黑名单啦。  
    #chroot_list_enable=YES  
    #chroot_list_file=/etc/vsftpd/chroot_list       ##当登陆FTP服务器时，被列在chroot_list文件中的用户，不可以访问FTP根目录以外的目录。  
    #ls_recurse_enable=YES          ##是否可以使用ls -R 命令，默认是注释掉的。  
    listen=YES      ##当此项为YES时，vsftpd运行于stand-alone模式下，默认是开启的。  
    #listen_ipv6=YES            ##是用IPv6，默认是注释掉的。  
    pam_service_name=vsftpd     ##列出与vsftpd相关的pam文件。  
    userlist_enable=YES         ##当此项设置为YES时，启用配置文件/etc/vsftpd/user_list.此时有两种情况：
    ①若没有userlist_deny=NO,则/etc/vsftpd/user_list中的用户不可以访问FTP服务器  
    ②若有userlist_deny=NO,则仅接受/etc/vsftpd/user_list中的用户登陆请求，同时此用户也不可以存在/etc/vsftpd/ftpusers文件中。  
    tcp_wrappers=YES        ##支持TCP Wrappers 
    chroot_local_user=YES   ##本地用户可以登录FTP服务器，并且登录后的默认目录为用户的家目录，而且还可以更改其默认目录
        ## ftp是明文传输的，中间人攻击将对于我们的服务器造成很大威胁，所以我们要禁止本地用户更改其默认目录
        ## 如果禁锢所有本地用户，只需要在主配置文件中添加一行即可


 补充：(未出现在vsftpd.conf配置文件中的常用参数)::

    guest_enable=YES  
    guest_username=ftp  
        guest用户名，即登陆不是匿名用户的用户，具有guest用户身份  
    local_root=/var/ftp  
    anon_root=/var/ftp  
        以上两个选项为本地用户和匿名用户默认访问的目录  
    #pasv_enable=YES  
    #port_enable=YES  
        以上两个选项是FTP服务器的工作模式，两者只能出现一个，而且另一个必须注释掉
           　（1）PORT其实是Standard模式的另一个名字，又称为Active模式。中文意思是“主动模式。
                  当客户端C向服务端S连接后，使用的是Port模式,那么客户端C会发送一条命令告诉服务端S
                  (客户端C在本地打开了一个端口N在等着你进行数据连接),当服务端S收到这个Port命令后,
                  就会向客户端打开的那个端口N进行连接，这种数据连接就生成了
    　　     （2）PASV也就是Passive的简写。中文就是“被动模式
                  当客户端C向服务端S连接后，服务端S会发信息给客户端C,这个信息是
                  (服务端S在本地打开了一个端口M,你现在去连接我吧),当客户端C收到这个信息后,
                  就可以向服务端S的M端口进行连接,连接成功后，数据连接也建立了

    use_localtime=YES  
        是否使用本机时间，若设置NO时，仅使用格林尼治时间。由于北京时间和格林尼治时间有8小时时差，所以建议设置为YES  
    Idle_session_timeout=300  
        客户端若在300秒之内没有任何操作，则服务器自动断开。  
    max_clinet=0  
        最大连接数量（stand-alone模式下）  
    max_per_ip=0  
        每个客户端最大连接ftp服务器的连接数  
    local_max_rate=0  
        本地用户登陆FTP服务器最大传输速率，单位为字节/秒  
    anon_max_rate=0  
        匿名用户登陆FTP服务器最大传输速率，单位为字节/秒

新增::

    user_config_dir=/etc/vsftpd/user_conf   // ftp用户列表,為每個用戶設置不同的home
    virtual_use_local_privs=YES
        ##当virtual_use_local_privs=YES时，虚拟用户和本地用户有相同的权限；
        ##当virtual_use_local_privs=NO时，虚拟用户和匿名用户有相同的权限，默认是NO。

    pasv_enable=yes
    pasv_min_port=22030
    pasv_max_port=22210
    pasv_address=10.128.128.47
    pasv_addr_resolve=yes

db_load命令 [1]_
=====================

安装::

    db_load 这个命令是由db4-utils软件包提供的
    # yum -y install db4-utils

创建虚拟用户账号和密码(奇数行为用户名，偶数行为用户密码）::

    # touch /etc/vsftpd/virtual.users  
    # vim /etc/vsftpd/virtual.users  
    user1        ##奇数为用户名  
    redhat       ##偶数为用户的密码  
    user2  
    123456


使用db_load命令生成用户账户的数据库文件并设置相应的数据库文件权限::

    # db_load -T -t hash -f /etc/vsftpd/virtual.users /etc/vsftpd/vsftpd.login.db  
    # chmod 600 /etc/vsftpd/vsftpd.login.db

    virtual.users 文件是刚刚新建的用户名和密码文件
    vsftpd_login.db文件是db_load命令生成的虚拟用户认证文件

配置PAM信息，在/etc/pam.d/创建一个文件，命名为vsftpd.pam(可自定义）::

    # vim /etc/pam.d/vsftpd.pam  
    auth    required        pam_userdb.so   db=/etc/vsftpd/vsftpd.login  
    account required        pam_userdb.so   db=/etc/vsftpd/vsftpd.login





真实实例
==========
::

    anonymous_enable=NO
    local_enable=YES
    write_enable=NO
    local_umask=022
    dirmessage_enable=YES
    xferlog_enable=YES
    #connect_from_port_20=YES
    connect_from_port_20=NO
    xferlog_std_format=YES
    xferlog_file=/var/log/vsftpd.log
    listen=YES
    listen_port=22021
    userlist_enable=YES
    tcp_wrappers=YES
    chroot_local_user=YES
    chroot_list_enable=NO
    guest_enable=YES
    guest_username=vsftpd
    pam_service_name=vsftpd.user
    user_config_dir=/etc/vsftpd/user_conf
    virtual_use_local_privs=YES
    ascii_upload_enable=YES
    ascii_download_enable=YES
    ftpd_banner="Smart home ftp"

    pasv_enable=yes
    pasv_min_port=22030
    pasv_max_port=22210
    pasv_address=10.128.128.47
    #pasv_address=172.31.24.82
    #pasv_address=54.222.179.232,172.31.24.82
    pasv_addr_resolve=yes

    allow_writeable_chroot=YES



/etc/vsftpd/user_conf目录::

    # cat /etc/vsftpd/user_conf/user1_ftp
    local_root=/data/apps/vsftpd/user1   // 指定user1用户的home目录
    write_enable=YES                     // 此用户在此目录下可写

    # cat /etc/vsftpd/user_conf/user2_ftp
    local_root=/data/apps/vsftpd/user2   // 指定user2用户的home目录
    write_enable=YES                     // 此用户在此目录下可写









.. [1] https://www.jianshu.com/p/81f982b06a78



