.. _nginx_apache:

apache的简单使用方法
========================


* 启动命令::

    apachectl start

* 停止命令::

    apachectl stop

* 重启命令::

    apachectl restart

* 重启apache而不中断连接::

    apachectl graceful

* 如果apache是linux的服务，可用如下命令::

    service httpd start
    service httpd stop
    service httpd restart


文件大小写不敏感
---------------------

* 确认 ``mod_speling.so`` 模块存在
* 编写配置文件, 加载mod_speling.so::

    #vi /etc/http/conf/httpd.conf

在其中加入::

    LoadModule speling_module modules/mod_speling.so   #若这个无效，可写成如下：
    LoadModule speling_module /usr/lib/httpd/modules/mod_speling.so   #设置详细路径

再加一句以开启speling::

    CheckSpelling On

配置文件写好了, 保存退出
* 重新启动apache，就可以了
* 据说speling模块会降低apche的执行效率



配置
----------

::

    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www
        <Directory />
            Options FollowSymLinks
            AllowOverride None
        </Directory>
        <Directory /var/www/>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride None
            Order allow,deny
            allow from all
        </Directory>
            ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
        <Directory "/usr/lib/cgi-bin">
            AllowOverride None
            Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
            Order allow,deny
            Allow from all
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn
        CustomLog ${APACHE_LOG_DIR}/access.log combined


        Alias /doc/ "/usr/share/doc/"
        <Directory "/usr/share/doc/">
            Options Indexes MultiViews FollowSymLinks
            AllowOverride None
            Order deny,allow
            Deny from all
            Allow from 127.0.0.0/255.0.0.0 ::1/128
        </Directory>

        Alias /pics "/exports/flv12"
        <Directory "/exports/flv12">
            Options  Indexes
            AllowOverride AuthConfig FileInfo
            Order allow,deny
            Allow from all
        </Directory>

        Alias /videos "/exports/flv14"
        <Directory "/exports/flv14">
            Options  Indexes
            AllowOverride AuthConfig FileInfo
            Order allow,deny
            Allow from all
        </Directory>
   </VirtualHost>




请求文件找不到转移到index.php::

   // 指定目录增加文件.htaccess
   <IfModule mod_rewrite.c>
       Options -MultiViews
       RewriteEngine On

   RewriteCond %{REQUEST_FILENAME} !-d
       RewriteCond %{REQUEST_FILENAME} !-f
       RewriteRule ^ index.php [L]
   </IfModule>

   // 对应nginx
   if (!-e $request_filename) {
      rewrite ^/(.*) /index.php/$1 last;
   }



   
   
