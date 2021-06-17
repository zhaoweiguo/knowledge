.. _nginx_question:

NginX问题汇总
==================
安装问题
----------
问题一::

    ./configure: error: the HTTP rewrite module requires the PCRE library.
    
    解决:安装pcre-devel:
      yum -y install pcre-devel

问题二::

    ./configure: error: the HTTP cache module requires md5 functionsfrom OpenSSL library. 
      You can either disable the module by using --without-http-cache option, 
      or install the OpenSSL library into the system, 
      or build the OpenSSL library statically from the source with nginx 
      by using --with-http_ssl_module --with-openssl=<path> options.

    解决:
      yum -y install openssl openssl-devel

问题三, SSL_R_NO_CIPHERS_PASSED [1]_ ::

  问题说明:
    $> make
    src/event/ngx_event_openssl.c: In function ‘ngx_ssl_connection_error’:
    src/event/ngx_event_openssl.c:2026:21: error: ‘SSL_R_NO_CIPHERS_PASSED’ undeclared (first use in this function)
                 || n == SSL_R_NO_CIPHERS_PASSED                          /*  182 */
                         ^~~~~~~~~~~~~~~~~~~~~~~
    src/event/ngx_event_openssl.c:2026:21: note: each undeclared identifier is reported only once for each function it appears in

  解决:
    Yes. I had similar issue with latest openssl being pushed to official repositories.
    Usually installing this package will resolve the problem:
    apt-get install libssl1.0-dev

    This should install OpenSSL version 1.0.2 and the compilation will succeed. Don't forget to do make clean before you compile with new libssl.

问题四 [2]_ ::

    libpcre3-dev : Depends: libpcre3 (= 2:8.39-3) but 2:8.41-1+0~20170825202309.5+jessie~1.gbp97d153 is to be installed
    解决方法:
    sudo apt-get install libpcre3=2:8.38-3.1 libpcre3-dev=2:8.38-3.1



nginx 502 bad gateway
------------------------------
查看错误日志(``cat log/nginx/error.log``)::

    upstream sent too big header while reading response header from upstream

php-cgi进程数不够用、php执行时间长、或者是php-cgi进程死掉，都会出现502错误


查看当前的php-fpm进程数是否够用(如果实际使用的“FastCGI进程数”接近预设的“FastCGI进程数”，那么，说明“FastCGI进程数”不够用，需要增大)::

    netstat -anpo | grep "php-fpm" | wc -l

部分PHP程序的执行时间超过了Nginx的等待时间，可以适当增加nginx.conf配置文件中FastCGI的timeout时间，例如::

    ......
    http 
    {
        ......
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
        ......
        fastcgi_buffer_size 128k;
        fastcgi_buffers 8 128k;

    }
    ....

头部太大::

    proxy_buffer_size 128k;
    proxy_buffers   32 32k;
    proxy_busy_buffers_size 128k;

https转发配置错误::

    server_name www.mydomain.com;
    location /myproj/repos {
      set $fixed_destination $http_destination;
      if ( $http_destination ~* ^https(.*)$ )
      {
        set $fixed_destination http$1;
      }
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header Destination $fixed_destination;
      proxy_pass http://subversion_hosts;
    }

PS:
如果报的是400错误，就增大header_buffers值为32k（默认为4k）
large_client_header_buffers 4 32k;



upstream sent too big header while reading response header from upstream
-----------------------------------------------------------------------------

* 如果是代理的话在http段增加::

    proxy_buffers 8 16k;
    proxy_buffer_size 32k;

* 如果是fastcgi的话::

    fastcgi_buffers 8 16k;
    fastcgi_buffer_size 32k;






client intended to send too large body: 12750515 bytes
----------------------------------------------------------
需要在http段增加此说明::

    client_max_body_size 2M;     # 限制http请求的body大小在2M以内, 一般用于限制附件的大小

如果是php还要修改php.ini::

    upload_max_filesize = 10M   // 否则上传附件有问题





.. [1] https://github.com/kgretzky/evilginx/issues/2
.. [2] https://askubuntu.com/questions/813788/cant-install-libpcre3-dev





