zabbix
===================

介绍::

    zabbix（[`zæbiks]）是一个基于WEB界面的提供分布式系统监视以及网络监视功能的企业级的开源解决方案

安装::

    // Zabbix 3.0 for Debian 7:
    $ wget http://repo.zabbix.com/zabbix/3.0/debian/pool/main/z/zabbix-release/zabbix-release_3.0-1+wheezy_all.deb
    $ dpkg -i zabbix-release_3.0-1+wheezy_all.deb
    $ apt-get update

    // Zabbix 3.0 for Debian 8:
    $ wget http://repo.zabbix.com/zabbix/3.0/debian/pool/main/z/zabbix-release/zabbix-release_3.0-1+jessie_all.deb
    $ dpkg -i zabbix-release_3.0-1+jessie_all.deb
    $ apt-get update


    $ apt-get install zabbix-agent     # client
    $ apt-get install zabbix-server zabbix-frontend-php    # server


配置zabbix_server::

    vim /etc/zabbix/zabbix_server.conf
    DBName = zabbix
    DBUser = root
    DBPassword = sa
    DBPort = 3306


启动zabbix_server::

    ./zabbix_server
    // 默认端口10051


配置zabbix_agentd::

    # vim /etc/zabbix/zabbix_agentd.conf
    Server = xx.xxx.x.xx        // 被动
    ServerActive = xx.x.x.xx    // 主动

启动zabbix_agentd::

    ./zabbix_agentd
    // 默认端口10050







