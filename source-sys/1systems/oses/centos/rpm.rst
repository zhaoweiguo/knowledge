.. _rpm:

rpm命令
#######

QUERYING AND VERIFYING PACKAGES::

    rpm {-q|--query} [select-options] [query-options]
    rpm {-V|--verify} [select-options] [verify-options]

INSTALLING, UPGRADING, AND REMOVING PACKAGES::

   rpm {-i|--install} [install-options] PACKAGE_FILE ...
   rpm {-U|--upgrade} [install-options] PACKAGE_FILE ...
   rpm {-F|--freshen} [install-options] PACKAGE_FILE ...
   rpm {-e|--erase} [--allmatches] [--justdb] [--nodeps] [--noscripts]
       [--notriggers] [--test] PACKAGE_NAME ...

query-options::

    -s, --state
    显示包中文件的状态（隐含-l）.每个文件的状态是正常，未安装或替换的状态
    -l,--list
    List files in package

实例
========

$> rpm -qs docker-ce::

    normal        /usr/bin/docker-init
    normal        /usr/bin/docker-proxy
    normal        /usr/bin/dockerd
    normal        /usr/lib/systemd/system/docker.service
    normal        /usr/lib/systemd/system/docker.socket
    normal        /var/lib/docker-engine/distribution_based_engine-ce.json

$> rpm -ql docker-ce::

    /usr/bin/docker-init
    /usr/bin/docker-proxy
    /usr/bin/dockerd
    /usr/lib/systemd/system/docker.service
    /usr/lib/systemd/system/docker.socket
    /var/lib/docker-engine/distribution_based_engine-ce.json


其他
=======

* 使用rpm安装.rpm文件::

    // 等同于yum localinstall *（不同的是yum localinstall会自动安装依赖）
    rpm -i *.rpm

* 查看是否安装包::

    rpm -qa | grep xxx

查看在安装vftpd软件包时，所产生的配置文件::

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

看一下docker-ce这个rpm包带来了哪些文件






