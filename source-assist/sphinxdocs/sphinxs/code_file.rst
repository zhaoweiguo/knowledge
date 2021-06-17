[主]文件使用实例 [1]_
######################

nginx实例::

    Short names:  nginx
    Filenames:  nginx.conf
    MIME types: text/x-nginx-conf

.. literalinclude:: ./files/languages/nginx.conf
   :language: nginx
   :linenos:



squid配置文件(redis)::

    Short names:  squidconf, squid.conf, squid
    Filenames:  squid.conf
    MIME types: text/x-squidconf

.. literalinclude:: ./files/languages/redis.conf
   :language: squidconf
   :linenos:



various domain-specific languages
-------------------------------------
thrift::

    Short names:  thrift
    Filenames:  *.thrift
    MIME types: application/x-thrift

protobuf::

    Short names:  protobuf, proto
    Filenames:  *.proto
    MIME types: None

简单的
======


语言
--------

Erlang实例::

    Short names:  erlang
    Filenames:  *.erl, *.hrl, *.es, *.escript
    MIME types: text/x-erlang

    Short names:  erl
    Filenames:  *.erl-sh
    MIME types: text/x-erl-shellsession


.. literalinclude:: ./files/languages/erlang.erl
   :language: erlang
   :linenos:


php实例::

     Short names: php, php3, php4, php5
    Filenames:  *.php, *.php[345], *.inc
    MIME types: text/x-php

.. literalinclude:: ./files/languages/php.php
   :language: php
   :linenos:



mysql实例::

    Short names:  mysql
    Filenames:  None
    MIME types: text/x-mysql

.. literalinclude:: ./files/languages/mysql.cnf
   :linenos:


其他
====


配置文件configuration file formats
------------------------------------


docker::

    Short names:  docker, dockerfile
    Filenames:  Dockerfile, *.docker
    MIME types: text/x-dockerfile-config

.. literalinclude:: ./files/languages/docker.conf
   :language: docker
   :linenos:


ini::

    Short names:  ini, cfg, dosini
    Filenames:  *.ini, *.cfg, *.inf
    MIME types: text/x-ini, text/inf



properties(java)::

    Short names:  properties, jproperties
    Filenames:  *.properties
    MIME types: text/x-java-properties


.. literalinclude:: ./files/languages/kafka.properties
   :language: jproperties
   :linenos:



apache配置文件::

    Short names:  apacheconf, aconf, apache
    Filenames:  .htaccess, apache.conf, apache2.conf
    MIME types: text/x-apacheconf


.. code-block:: apacheconf

    <VirtualHost *:80>
            ServerName a.com
            ServerAdmin webmaster@localhost
            DocumentRoot /home/data/www/a
            ErrorLog /home/data/log/a_error.log
            CustomLog /home/data/log/a_access.log combined
    </Virtualhost>
    <VirtualHost *:80>
            ServerName b.com
        ServerAdmin webmaster@localhost
            DocumentRoot /home/data/www/b
            ErrorLog /home/data/log/b_error.log
            CustomLog /home/data/log/b_access.log combined
    </Virtualhost>



CSS相关
------------

css::

    Short names:  css
    Filenames:  *.css
    MIME types: text/css

less::

    Short names:  less
    Filenames:  *.less
    MIME types: text/x-less-css

数据文件格式::

    Short names:  json
    Filenames:  *.json
    MIME types: application/json










   


.. [1] http://pygments.org/docs/lexers/#lexers-for-php-and-related-languages