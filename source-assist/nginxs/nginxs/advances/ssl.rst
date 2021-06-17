nginx ssl相关
==================

命令::

  $> openssl req -new -nodes -sha256 -newkey rsa:2048 -keyout myprivate.key -out mydomain.csr
  $> openssl x509 -req -days 365 -in mydomain.csr -signkey myprivate.key -out mydomain.crt

老nginx配置::

    server
    {
    server_name <host>;
    listen  443;
    index index.html index.htm index.php;

    root  /data0/htdocs/api.bz;

    ssl on;
    ssl_certificate mydomain.crt;
    ssl_certificate_key myprivate.key;
    ......
    }

ECC证书说明
---------------

并不是所有浏览器都支持 ECDHE 密钥交换，也就是说 ECC 证书的兼容性要差一些。例如在 Windows XP 中，使用 ECC 证书的网站时需要浏览器自行 TLS（例如 Firefox 的 TLS 自己实现，不依赖操作系统）；Android 平台中，也需要 Android 4+ 才支持 ECC 证书。

.. figure:: /images/encrypts/ecc.png
   :width: 80%


ECC RSA 双证书
-----------------
先决条件::

    Nginx 1.11.0 以上
    OpenSSL 1.0.2 以上

生成证书 [1]_ [2]_ ::

    openssl ecparam -genkey -name prime256v1 -out 证书名.key
    openssl req -new -key 证书名.key -nodes -out 证书名.csr
    =>
    openssl ecparam -genkey -name prime256v1 -out www.zhaoweiguo.com.key
    openssl req -new -sha256 -key www.zhaoweiguo.com.key -nodes -out www.zhaoweiguo.com.csr

双证书rsa+ecc [3]_ ::

    # 它的实现原理是:
    # 分析在 TLS 握手中双方协商得到的 Cipher Suite
    # 若支持 ECDSA 就返回 ECC 证书，反之返回 RSA 证书
    server{
        listen 443 ssl;
        server_name www.zhaoweiguo.com;
        root /var/www/zhaoweiguo.com/www.zhaoweiguo.com;
        index index.php index.html;


        #       ssl_certificate /home/wei64/nginx/ca/www.zhaoweiguo.com.crt;
        ssl_certificate  /home/wei64/www.zhaoweiguo.com.crt;
        ssl_certificate_key  /home/wei64/nginx/ca/www.zhaoweiguo.com.key;

        ssl_certificate  /home/wei64/nginx/ca/www.zhaoweiguo.com.ecc.crt;
        ssl_certificate_key  /home/wei64/nginx/ca/www.zhaoweiguo.com.ecc.key;

        ssl_prefer_server_ciphers on;
        ## Cipher Suites 一定要配置好，不然双证书并不会生效
        ssl_ciphers "EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES";
    }


.. [1] https://www.morong.me/?p=99
.. [2] https://maoxian.de/2016/08/1436.html
.. [3] https://blog.sometimesnaive.org/article/18




