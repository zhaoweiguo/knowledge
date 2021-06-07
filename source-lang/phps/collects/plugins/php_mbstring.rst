.. _php_mbstring:

php的mbstring扩展库
=====================

* 进入php的源代码目录 ``/src/php5.3.8`` 下的 ``ext/mbstring`` 目录下
* 执行::

   /usr/local/php/bin/phpize （假设php安装在/usr/local/php目录下）

* 执行::

   ./configure --with-php-config=/usr/local/php/bin/php-config

* 执行::

    make && make install

* 增加文件夹ext::

    mkdir /usr/local/php/ext

* 修改 ``php.ini`` 文件，找到 ``extension_dir`` ,取消注释并修改为::

    extension_dir = "/usr/local/php/ext"

* 之后系统会提示你 ``mbstring.so`` 文件所在的目录.根据前面 ``php.ini`` 中指示的 ``extension_dir`` 指向的目录中,将其复制过去::

    cp modules/mbstring.so /usr/local/php/ext

* 修改 ``php.ini`` 文件，找到 ``Dynamic Extensions`` 字段,添加一句::

    extension=mbstring.so
