.. _php_yaf:

Yaf框架
############

* 用户手册: http://yaf.laruence.com/manual/


* 安装::

    $/path/to/phpize
    $./configure --with-php-config=/path/php/bin/php-config
    $make && make instal


* nginx配置::

    server {
      listen ****;
      server_name  domain.com;
      root   document_root;
      index  index.php index.html index.htm;
 
        if (!-e $request_filename) {
            rewrite ^/(.*)  /index.php/$1 last;
        }
    }

* 实例::

        if (!-e $request_filename) {
            rewrite ^/(.*)  /index.php/$1 last;
        }
        location ~ \.php {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;

            set $path_info "";
            set $real_script_name $fastcgi_script_name;
            if ($fastcgi_script_name ~ "^(.+?\.php)(/.+)$") {
                set $real_script_name $1;
                set $path_info $2;
            }

            fastcgi_param SCRIPT_FILENAME $document_root$real_script_name;
            fastcgi_param SCRIPT_NAME $real_script_name;
            fastcgi_param PATH_INFO $path_info;

            include        fastcgi_params2;
        }


