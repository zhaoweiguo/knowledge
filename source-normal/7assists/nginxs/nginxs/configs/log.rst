日志相关
########



在nginx日志中显示post的请求参数::

    log_format access '$remote_addr - $remote_user [$time_local] \
        "$request" $status $body_bytes_sent $request_body \
        "$http_referer" "$http_user_agent" $http_x_forwarded_for';
    access_log logs/test.access.log access;



