.. _nginx_install:

安装
=======

apt-get安装
--------------

如果嫌太老了可以修改安装源的方式来获得更新的版本 [1]_ ::

    Debian9的apt-get默认安装的nginx为1.10
    1.添加Nginx源
    deb http://nginx.org/packages/mainline/debian/ [codename] nginx
    deb-src http://nginx.org/packages/mainline/debian/ [codename] nginx
    其他[codename]参数根据os来选择 [1]_
    如:
    Debian平台:
    Version     Codename    Supported Platforms
    8.x         jessie      x86_64, i386
    9.x         stretch     x86_64, i386
    $> cat vi /etc/apt/sources.list.d/nginx.list
    deb http://nginx.org/packages/mainline/debian/ stretch nginx
    deb-src http://nginx.org/packages/mainline/debian/ stretch nginx

    2.安装nginx PGP签名文件
    wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -
    or
    wget http://nginx.org/keys/nginx_signing.key
    apt-key add nginx_signing.key

    3.更新源
    apt update

    4.删除老版本
    apt remove nginx-common

    5.安装
    apt install nginx






源码安装
-------------

安装前准备::

    1. GCC编译器-程序代码编译工具！
    Redhat系安装方法：yum install gcc
    Debian系（包括ubuntu）安装方法：#apt-get install gcc
    2.PCRE(Perl Compatible Regular Expressions) 
    包括 perl 兼容的正规表达式库.
    编译Nginx时需要用到PCRE，同时Nginx的Rewrite和http模块也要用到PCRE的语法
    需要安装pcre包pcre-devel包.
        pcre包负责提供库的编译版本
        pcre-devel包提供编译项目时用到的开发头文件和代码
    Redhat系安装方法：
    # yum install pcre pcre-devel
    Debian系（包括ubuntu）安装方法：
    #apt-get install libpcre3 libpcre3-dev
    3.zlib库
    Redhat系安装方法：
    # yum install zlib zlib-devel
    Debian系（包括ubuntu）安装方法：
    # apt-get install zlib1g zlib1g-dev
    4.OpenSSL
    Redhat系安装方法：
    # yum install zlib zlib-devel
    Debian系（包括ubuntu）安装方法：
    # apt-get install openssl openssl-dev

安装::

    源码下载后，解压，执行标准安装过程:
        ./configure --prefix=/usr/local/nginx
        make
        make install
    调试安装:
        ../configure --prefix=/usr/local/debug-nginx --with-debug
    为http服务开通https服务，并包含最重要的功能和模块，而与邮件相关的选项都被禁用:
        ./configure --prefix=/usr/local/nginx --with-http_ssl_module --with_http_module
    开启所有模块，由自己决定是否在运行时使用他们:
        ../configure --user=www-data --group=www-data /
                     --with-http_ssl_module --with-http_realip_module /
                     --with-http_addition_module --with-http_xslt_module /
                     --with-http_image_filter_module --with-http_geoip_module /
                     --with-http_sub_module --with-http_dav_module /
                     --with-http_flv_module --with-http_gzip_static_module /
                     --with-http_random_index_module --with-http_secure_link_module /
                     --with-http_stub_status_module
    邮件服务器代理:
        ./configure --user=www-data --group=www-data --with-mail --with-mail_ssl_module
        // 如果愿意彻底禁用http服务功能，而只用Nginx用于邮件代理，可以添加 --without-http 选项


nginx使用::

    启动:
        /etc/init.d/nginx -c /etc/nginx/nginx.conf

    平滑重启:
        kill -HUP `/var/nginx/run/nginx.pid`




.. [1] https://nginx.org/en/linux_packages.html#distributions


