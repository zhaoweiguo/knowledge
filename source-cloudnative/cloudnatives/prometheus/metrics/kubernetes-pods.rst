kubernetes-pods
###############

* #这里部署的是nginx_ingress_controller  下面是查询这些metric类型和意思的网址：
* https://github.com/kubernetes/ingress-nginx/blob/master/internal/ingress/metric/collectors/nginx_status_test.go
* https://www.gitmemory.com/issue/kubernetes/ingress-nginx/2924/483591581


🈯️标::

    nginx_ingress_controller_nginx_process_connections  #gauge类型，状态为{active, reading, writing, waiting}的当前客户端连接数
    nginx_ingress_controller_nginx_process_connections_total  #counter类型，状态为{accepted, handled（已接受，已处理）}的连接总数
    nginx_ingress_controller_config_last_reload_successful  #gauge类型，nginx_ingress_controller_config最后一次加载成功的时间
    nginx_ingress_controller_nginx_process_write_bytes_total #counter类型，nginx_ingress_controller nginx进程写入字节总数
    nginx_ingress_controller_config_hash  #gauge类型，实际正在运行配置散列
    nginx_ingress_controller_config_last_reload_successful_timestamp_seconds   #gauge类型，上一次成功重新配置的时间戳。
    nginx_ingress_controller_nginx_process_num_procs  #gauge类型，进程数
    nginx_ingress_controller_nginx_process_oldest_start_time_seconds  #gauge类型，从1970/01/01开始的秒数
    nginx_ingress_controller_nginx_process_virtual_memory_bytes  #guage类型，正在使用的内存字节数
    nginx_ingress_controller_success  #counter类型，Ingress控制器重新加载操作的累积数量
    nginx_ingress_controller_nginx_process_read_bytes_total  #counter类型，读取的字节数
    nginx_ingress_controller_nginx_process_cpu_seconds_total  #counter类似，CPU使用时间（以秒为单位）
    nginx_ingress_controller_nginx_process_requests_total  #counter类型，客户请求总数
    nginx_ingress_controller_nginx_process_resident_memory_bytes  #gauge类型，正在使用的内存字节数








