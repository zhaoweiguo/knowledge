.. _centos_necessary:

centos常见的信赖包
=====================

从源文件安装时的信赖::

  安装ncurses:
  yum install ncurses-devel

  安装pcre-devel:
  yum -y install pcre-devel

  //安装openssl:
  yum -y install openssl-devel

  // c, c++
  yum -y install gcc gcc-c++



automake安装::

  yum install automake
  //依赖:autoconf/imake

常见文件::

    版本号相关:
    $ cat /etc/redhat-release
    Linux 版本:
    $ cat /proc/version

    $ uname -a
    $ uname -r

查看系统是 32 位或者 64 位的方法::

    $ getconf LONG_BIT or getconf WORD_BIT
    $ file /bin/ls



::

  /etc/sysconfig/network
  //设置主机名和网络配置
  //HOSTNAME=<hostname> #这儿设置主机名,需要重启生效

  //针对特定的网卡进行设置::
  /etc/sysconfig/network-scripts/ifcfg-eth0


  //安全日志文件:
  /var/log/secure

  //yum源目录:
  /etc/yum.repos.d




  