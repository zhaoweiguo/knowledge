.. _freeswitch_install:

FreeSWITCH安装
================


.. _install_necessary:

安装前必备软件
----------------

* 必备软件

    * GIT or WGET
    * AUTOCONF
    * AUTOMAKE
    * GCC-C++
    * LIBJPEG-DEVEL
    * LIBTOOL
    * MAKE
    * NCURSES-DEVEL

* 使用Debian/Ubuntu::

    sudo apt-get install git-core build-essential autoconf automake libtool libncurses5 
        libncurses5-dev make libjpeg-dev pkg-config unixodbc unixodbc-dev

* 使用CentOS/Fedora(更多需要检查)::

    sudo yum install git autoconf automake libtool ncurses-devel libjpeg-devel

.. _install_optional:

安装前可选软件
---------------

* 可选软件

    * curl-devel for mod_xml_curl
    * expat-devel
    * GnuTLS for Dingaling
    * libtiff for fax support
    * libx11-devel for mod_skypopen
    * ODBC or UNIX-ODBC and ODBC-devel
    * OpenSSL form SIP SSL & TLS
    * python-devel for the python interface
    * ZLIB and ZLIB-devel
    * libzrtp ——ZRTP encryption support

* 使用Debian/Ubuntu::

    sudo apt-get install libcurl4-openssl-dev libexpat1-dev libgnutls-dev libtiff4-dev
         libx11-dev unixodbc-dev libssl-dev python2.6-dev zlib1g-dev libzrtpcpp-dev
         libasound2-dev libogg-dev libvorbis-dev libperl-dev libgdbm-dev
         libdb-dev python-dev uuid-dev bison

* 使用CentOS/Fedora(needs more thorough checking)::

    sudo yum install expat-devel gnutls-devel libtiff-devel libX11-devel unixODBC-devel
         libssl-devel python-devel zlib-devel libzrtpcpp-devel alsa-lib-devel libogg-devel 
         libvorbis-devel perl-libs gdbm-devel libdb-devel uuid-devel @development-tools


.. _install_download:

下载
-----

git地址::

    git clone git://git.freeswitch.org/freeswitch.git
    cd freeswitch
    ./bootstrap.sh

