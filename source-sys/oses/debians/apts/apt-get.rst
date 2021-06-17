debian服务器安装依赖
=========================

安装::

    apt-get install emacs tmux vim git-core

    // 压缩相关
    apt-get install unace unrar zip unzip p7zip-full p7zip-rar
    sharutils rar uudeview mpack lha arj cabextract file-roller

    // web服务器
    apt-get install php5-fpm mysql-server mysql-common mysql-client nginx

卸载::

    apt-get remove sphinx-doc


从源文件安装时的信赖::

    //pcre-devel:
    apt-get install libpcre3-dev

    //安装c或者c++编译及配置库
    sudo apt-get install g++ libboost-dev libevent-dev python-dev 
    automake autoconf pkg-config libtool flex bison

DEBIAN_FRONTEND 环境变量::

    RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install nginx
    如果设置为 "noninteractive"，你就可以直接运行命令，而无需向用户请求输入



