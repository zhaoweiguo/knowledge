基本
####


静态文件处理
---------------------

    *  images 路径下的所有请求可以写为::

        location ~ ^/images/ {
            root /opt/webapp/images;
        }

    * 几种文件类型的请求处理方式::

        location ~ \.(htm|html|gif|jpg|jpeg|png|bmp|ico|css|js|txt)$ {
            root /opt/webapp;
            expires 24h;
        }

    * expires 指令可以控制 HTTP 应答中的“ Expires ”和“ Cache-Control ”的头标（起到控制页面缓存的作用）。您可以使用例如以下的格式来书写 Expires::

        expires 1 January, 1970, 00:00:01 GMT;
        expires 60s;
        expires 30m;
        expires 24h;
        expires 1d;
        expires max;
        expires off;

动态页面请求处理
----------------------

* 反向代理将请求发送到后端的服务器::

      location / {
         proxy_pass        http://localhost:8080;
         proxy_set_header  X-Real-IP  $remote_addr;
      }

* Nginx 通过 upstream 指令来定义一个服务器的集群，最前面那个完整的例子中我们定义了一个名为 tomcats 的集群，这个集群中包括了三台服务器共 6 个 Tomcat 服务。而 proxy_pass 指令的写法变成了::

       location / {
           proxy_pass        http://tomcats;
           proxy_set_header  X-Real-IP  $remote_addr;
       }



* php-fpm实例::

    server {
        listen      80;
        server_name bbs.programfan.info;
        index index.html index.htm index.php;
        root /var/www/bbs.programfan.info;

        location ~ .*\.(php|php5)?$ {
            fastcgi_pass 127.0.0.1:9000;
            fastcgi_index index.php;
            include fcgi.conf;
        }

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$ {
            expires 30d;
        }

        location ~ .*\.(js|css)?$ {
            expires 1h;
        }

        log_format bbs '$remote_addr - $remote_user [$time_local]"$request" '
                  '$status $body_bytes_sent "$http_refer" '
                  '"$http_user_agent" $http_x_forwarded_for'
        access_log /etc/nginx/log/bbs.log bbs;
    }

* fcgi.conf::

        fastcgi_param   GATEWAY_INTERFACE   CGI/1.1;
        fastcgi_param   SERVER_SOFTWARE     nginx;

        fastcgi_param   QUERY_STRING        $query_string;
        fastcgi_param   REQUEST_METHOD      $request_method;
        fastcgi_param   CONTENT_TYPE        $content_type;
        fastcgi_param   CONTENT_LENGTH      $content_length;

        fastcgi_param   SCRIPT_FILENAME     $document_root$fastcgi_script_name;
        fastcgi_param   SCRIPT_NAME     $fastcgi_script_name;

        fastcgi_param   REQUEST_URI     $request_uri;
        fastcgi_param   DOCUMENT_URI        $document_uri;
        fastcgi_param   DOCUMENT_ROOT       $document_root;
        fastcgi_param   SERVER_PROTOCOL     $server_protocol;

        fastcgi_param   REMOTE_ADDR     $remote_addr;
        fastcgi_param   REMOTE_PORT     $remote_port;
        fastcgi_param   SERVER_ADDR     $server_addr;
        fastcgi_param   SERVER_PORT     $server_port;
        fastcgi_param   SERVER_NAME     $server_name;

        fastcgi_param   REDIRECT_STATUS     200;








