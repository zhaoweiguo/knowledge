跳转与代理的区别
-----------------------

代理::

    location / {
        proxy_pass http://<proxy url>;
    }

    浏览器地址不变
    每次請求原网址都会被代理到<proxy url>


跳转::

    if ($host = 'huoban.eqitong.com' ) {
       set $host_eqitong $1;
       rewrite ^(.*)$ http://<direct url>$1 permanent;
    }

    最后一项参数flag标记有:
    last,       相当于apache的[L]标记
    break,      本条规则后匹配完成后，终止匹配
    redirect,   302临时重定向, 浏览器地址会显示跳转后的
    permanent   301永久重定向, 浏览器地址会显示跳转后的


try_files的使用::

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    当用户请求 http://localhost/example 时，这里的 $uri 就是 /example。 
    try_files 会到硬盘里尝试找这个文件
      1. 如果存在名为 /$root/example（其中 $root 是项目代码安装目录）的文件，就直接把这个文件的内容发送给用户。 
      2. 如果没有就再看 $uri/，增加了一个 /，也就是看有没有名为 /$root/example/ 的目录 
      3. 如还找不到，就会 fall back 到 try_files 的最后一个选项 /index.php，发起一个内部 “子请求”
        也就是相当于 nginx 发起一个 HTTP 请求到 http://localhost/index.php。 


* 重定向::

    server {
        listen       80;
        server_name  game.programfan.info;

        location / {
            proxy_pass http://199.83.92.190:9001;
        }
        # redirect server error pages to the static page /50x.html                                                                  
        #                                                                                                                           
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        log_format game '$remote_addr - $remote_user [$time_local]"$request" '
              '$status $body_bytes_sent "$http_refer" '
              '"$http_user_agent" $http_x_forwarded_for'
        access_log /etc/nginx/log/game.log game;

    }


* 所有 ``*.zhaoweiguo.com`` 转向到 ``*.programfan.info``::

    server {
        listen          80;
        server_name     *.zhaoweiguo.com;

        location / {
            resolver 8.8.8.8;  #注意这儿
            client_max_body_size 5m;
            if ( $host ~ (.*).zhaoweiguo.com ) {
                set $secondhost $1;
                proxy_pass http://$secondhost.programfan.info;
            }
        }
    }




