..  _php_plugin:

php插件安装
====================

.. toctree::
   :maxdepth: 2

   plugins/php_mbstring
   plugins/php_curl



* ``phpize`` 命令的作用可以这样理解:

    * 侦测环境，建立一个configure文件
    * 必须在一个目录下去运行phpize
    * 那么phpize就知道你的的环境是哪个目录
    * 并且configure文件建立在该目录下。

* 假如你的服务器上安装了多个版本php，那么需要告诉phpize要建立基于哪个版本的扩展
* 通过使用 ``--with-php-config=`` 指定你使用哪个php版本
* 比如::

    --with-php-config=/usr/local/php524/bin/php-config  

* php-config文件在是在php编译生成后(安装好)，安装目录下的一个文件

* 检测插件是否安装成功的命令::

    /usr/local/php/bin/php -m

* PHP information and configuration::

    php -i
    php --info


