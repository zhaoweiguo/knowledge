.. _nagios_quickstart:

快速开始(以ubuntu为例)
=======================

    本简介是提供一个快速从源码安装Nagios的简单手册，20分钟就可以弄好一个用于监控本地机器。这儿不会討論高级选项。

信赖包
---------

* 安装所需包:

    * appache 2
    * PHP
    * GCC 编译器和开发包
    * GD开发库

* 安装所需命令::

    sudo apt-get install apache2
    sudo apt-get install libapache2-mod-php5
    sudo apt-get install build-essential
    sudo apt-get install libgd2-xpm-dev  #这儿GD包些许不同

安装步骤
----------

* 创建帐号信息::

    sudo -s
    /usr/sbin/useradd -m -s /bin/bash nagios
    passwd nagios
    /usr/sbin/groupadd nagcmd
    /usr/sbin/usermod -a -G nagcmd nagios
    /usr/sbin/usermod -a -G nagcmd www-data

* 下载Nagios和它的插件::

    wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-3.2.3.tar.gz
    wget http://prdownloads.sourceforge.net/sourceforge/nagiosplug/nagios-plugins-1.4.11.tar.gz

* 编译和安装Nagios::

    ./configure --with-command-group=nagcmd #运行配置文件,把上面你创建的群组传入
    make all #编译Nagios源码
    make install #安装
    make install-init #初使化脚本
    make install-config #初使化配置文件
    make install-commandmode #設定额外的命令目录

* 个性化配置:

    修改配置文件 `/usr/local/nagios/etc/objects/contacts.cfg` ,修改为你的E-mail.

* 配置Web接口:

    * 在Apache conf.d目录安装Nagios web配置文件::

        make install-webconf

    * 创建进入Nagios web接口的nagiosadmin帐号，記住它的密码，之后你会用到::

        htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

    * 重启Apache使新设置生效::

        /etc/init.d/apache2 reload

* 编译和安装Nagios插件::

    ./configure --with-nagios-user=nagios --with-nagios-group=nagios
    make
    make install

* 启动Nagios::

    # 配置Nagios，使其在系统启动时，自动启动
    ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios
    # 修改Nagios实例配置文件
    /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
    # 若没有错误，启动Nagios
    /etc/init.d/nagios start

* 登录web接口:

    * 登录网址: http://localhost/nagios/
    * 用户名和密码前面有設定

* 其他修改:

    * 如果你想用邮件来对Nagios提醒::

        sudo apt-get install mailx
        sudo apt-get install postfix

    * 修改完之后，需要重启Nagios::

        sudo /etc/init.d/nagios restart


安装汉代插件
---------------

* 下载地址: `Nagios汉化插件 <http://sourceforge.net/projects/nagios-cn/files>`_

* 安装步骤::

    tar jxvf nagios-cn-3.2.0.tar.bz2
    cd nagios-cn-3.2.0
    ./configure
    make all
    make install


