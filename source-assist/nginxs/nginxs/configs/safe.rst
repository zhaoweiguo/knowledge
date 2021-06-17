安全相关
########


Nginx加密
---------

生成密码文件::

    /usr/bin/htpasswd –c /path/pwdfile <username>


说明::

  auth_basic "Authorized users only";
  auth_basic_user_file /usr/local/nginx/conf/auth.conf
  //auth_basic_user_file 为htpasswd文件的路径

实例::

  注: 如果你使用了集群环境, 那么还需要加Proxy_Pass:
  location /admin/ {
        proxy_pass http://cluster/mgmt/;
        auth_basic "QuanLei Auth.";
        auth_basic_user_file /usr/local/ngnix/conf/authdb;
  }


避免直接ip访问web
-----------------

::

    server {
           listen 80 default_server;
           server_name _;
           return 444;
    }


拒绝某些文件被访问
------------------

文件夹拒绝::

    location ~* /(\.svn|CVS|Entries){
        deny all;
    }

文件拒绝::

    location ~* /\.(sql|bak|inc|old)$ {
        deny all;
    }



