.. _php_install:

php安装
========

* 安装命令::

    ./configure --prefix=/usr/local/php --enable-fpm --with-mysql=/usr/local/mysql \
                --with-mysqli=/usr/local/mysql/bin/mysql_config --with-mysql-sock=/tmp/mysql.sock
    make all
    make install

* 配置php-fpm:

    * 增加日志使用目录::

        cd /var
        mkdir php; cd php
        mkdir log; mkdir run

    * 增加php-fpm.conf配置文件::

        cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf

    * 修改前面的php-fpm.conf文件::

        pid=/var/php/run/php-fpm.pid
        error_log=/var/php/log/php-fpm.log
        pm.start_servers=20
        pm.min_spare_servers=5
        pm.max_spare_servers=35
        pm.max_requests=500

    * 增加一个php-fpm执行脚本::

        cp <php-version-source-dir>/sapi/fpm/init.d/php-fpm.in /etc/init.d/php-fpm
        chmod 755 /etc/init.d/php-fpm

文档地址见: `这儿 <http://www.php.net/manual/en/install.fpm.configuration.php>`_

    * 修改前面的可执行脚本php-fpm::

        prefix = /usr/local/php
        exec_prefix = /usr/local/php/bin

        php_fpm_BIN = /usr/local/php/sbin/php-fpm
        php_fpm_CONF = /usr/local/php/etc/php-fpm.conf
        php_fpm_PID = /var/php/run/php-fpm.pid

* 脚本使用::

    /etc/init.d/php-fpm start
    /etc/init.d/php-fpm stop
    /etc/init.d/php-fpm reload

摘自: `FastCGI Process Manager(FPM) <http://www.php.net/manual/en/install.fpm.php>`_



* 安装之后生成目录结构::

    /usr/local/php/
    |-- bin:      php应用可执行文件
    |-- etc:      php配置
    |-- include: 
    |-- lib:
    |-- man:      帮助文件
    |-- php:      
    |-- sbin:     php-fpm可执行文件 
    `-- var
