.. _php_curl:

php的curl扩展库
=====================

* 安装curl::

    ./configure --prefix=/usr/local/curl
    make && make install

* 进入php的源代码目录 ``/src/php5.3.8`` 下的 ``ext/curl`` 目录下
* 执行::

   /usr/local/php/bin/phpize （假设php安装在/usr/local/php目录下）

* 执行::

   ./configure --with-curl=/usr/local/curl --with-php-config=/usr/local/php/bin/php-config

* 执行::

    make && make install

* 增加文件夹ext::

    mkdir /usr/local/php/ext

* 修改 ``php.ini`` 文件，找到 ``extension_dir`` ,取消注释并修改为::

    extension_dir = "/usr/local/php/ext"

* 之后系统会提示你 ``curl.so`` 文件所在的目录。根据 ``php.ini`` 中指示的extension_dir指向的目录中,将其复制过去::

    cp modules/curl.so /usr/local/php/ext

* 修改 ``php.ini`` 文件，找到 ``Dynamic Extensions`` 字段,添加一句::

    extension=curl.so


