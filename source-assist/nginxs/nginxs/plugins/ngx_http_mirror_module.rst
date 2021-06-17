ngx_http_mirror_module模块 [1]_
---------------------------------

nginx1.13.4最新的ngx_http_mirror_module模块，利用mirror模块，业务可以将线上实时访问流量拷贝至其他环境，基于这些流量可以做版本发布前的预先验证，进行流量放大后的压测等等

mirror模块配置分为两部分，源地址和镜像地址配置::

    # original配置
    location / {
        mirror /mirror;
        mirror_request_body off;
        proxy_pass http://127.0.0.1:9502;
    }

    # mirror配置
    location /mirror {
        internal;
        proxy_pass http://127.0.0.1:8081$request_uri;
        proxy_set_header X-Original-URI $request_uri;

original配置::

    location /指定了源uri为/
    mirror /mirror指定镜像uri为/mirror

    mirror_request_body off | on 指定是否镜像请求body部分，此选项与proxy_request_buffering、fastcgi_request_buffering、scgi_request_buffering和 uwsgi_request_buffering冲突，一旦开启mirror_request_body为on，则请求自动缓存;

    proxy_pass 指定上游server的地址

2、mirror配置::

    internal 指定此location只能被“内部的”请求调用，外部的调用请求会返回”Not found” (404)
    proxy_pass 指定上游server的地址
    proxy_set_header 设置镜像流量的头部


.. image:: /images/nginxs/ngx_http_mirror_module1.png
   :width: 80%

original和mirror均为上游server PHP脚本，其中original返回响应response to client。 抓包结果如下图:


.. image:: /images/nginxs/ngx_http_mirror_module2.png
   :width: 150%

分析抓包结果，整个请求流程为::

    curl向nginx 80端口发起GET / HTTP请求
    nginx将请求转发至upstream 9502端口的original php脚本，nginx本地端口为51637
    nginx将请求镜像发至upstream 8081端口的mirror PHP脚本，nginx本地端口为51638
    original发送响应response to client至nginx
    nginx将响应转发至curl，curl将响应展示到终端
    mirror将响应发送至nginx，nginx丢弃。

mirror模块实现::

    static ngx_int_t
    ngx_http_mirror_handler_internal(ngx_http_request_t *r)
    {
        ngx_str_t                   *name;
        ngx_uint_t                   i;
        ngx_http_request_t          *sr;
        ngx_http_mirror_loc_conf_t  *mlcf;

        mlcf = ngx_http_get_module_loc_conf(r, ngx_http_mirror_module);

        name = mlcf->mirror->elts;

        for (i = 0; i < mlcf->mirror->nelts; i++) {
            if (ngx_http_subrequest(r, &name[i], &r->args, &sr, NULL,
                                    NGX_HTTP_SUBREQUEST_BACKGROUND)
                != NGX_OK)
            {
                return NGX_HTTP_INTERNAL_SERVER_ERROR;
            }

            sr->header_only = 1;
            sr->method = r->method;
            sr->method_name = r->method_name;
        }

        return NGX_DECLINED;
    }

nginx支持配置多个mirror uri::

    location / {
        mirror /mirror;
        mirror /mirror2;
        mirror_request_body off;
        proxy_pass http://127.0.0.1:9502;
    }

    location /mirror {
        internal;
        proxy_pass http://127.0.0.1:8081$request_uri;
    }

    location /mirror2 {
        internal;
        proxy_pass http://127.0.0.1:8081$request_uri;
    }


这儿还有个基于nginx1.4.4用lua实现的一个版本 [2]_

.. [1] https://www.centos.bz/2017/08/nginx-request-copy-ngx_http_mirror_module/
.. [2] http://www.crackedzone.com/testing-service-with-nginx-copy-request.html



