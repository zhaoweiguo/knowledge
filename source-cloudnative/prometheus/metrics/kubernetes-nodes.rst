kubernetes-nodes
################

::

    storage_operation_duration_seconds_bucket
    kubelet_runtime_operations_latency_microseconds  #summary类型，（不建议使用）运行时操作的延迟（以微秒为单位）。 按操作类型细分
    rest_client_request_latency_seconds_bucket
    kubelet_docker_operations_latency_microseconds  #summary类型，（不建议使用）Docker操作的延迟（以微秒为单位）。 按操作类型细分。
    kubelet_runtime_operations  #counter类型，（不建议使用）按操作类型划分的运行时操作累计数。
    kubelet_runtime_operations_latency_microseconds_count
    apiserver_storage_data_key_generation_latencies_microseconds_bucket
    kubelet_runtime_operations_latency_microseconds_sum
    apiserver_client_certificate_expiration_seconds_bucket
    kubelet_docker_operations_latency_microseconds_sum
    kubelet_docker_operations  #counter类型，（已弃用）按操作类型分类的Docker操作的累计数量。
    kubelet_docker_operations_latency_microseconds_count
    rest_client_requests_total  #counter类型，HTTP请求数，按状态码，方法和主机划分。
    kubelet_cgroup_manager_latency_microseconds  #summary类型，（不建议使用）cgroup Manager操作的延迟（以微秒为单位）。 按方法细分。
    storage_operation_duration_seconds_sum
    storage_operation_duration_seconds_count
    kubelet_network_plugin_operations_latency_microseconds  #summary类型，(不建议使用）网络插件操作的延迟（以微秒为单位）。 按操作类型细分。
    volume_manager_total_volumes  #gauge类型，Volume Manager中的卷数
    kubelet_pod_worker_latency_microseconds  #summary类型，（不建议使用）延迟（以微秒为单位）以同步单个Pod。 按操作类型细分：创建，更新或同步
    kubelet_docker_operations_errors  #counter类型，（已弃用）按操作类型分类的Docker操作错误累计数。
    kubelet_runtime_operations_errors  #counter类型，（不建议使用）按操作类型累计的运行时操作错误数。
    rest_client_request_latency_seconds_count
    rest_client_request_latency_seconds_sum
    http_request_size_bytes  #summary类型，HTTP请求大小（以字节为单位）。
    kubelet_pleg_relist_latency_microseconds  #summary类型，（已弃用）重新列出PLEG中的Pod的延迟（以微秒为单位）。
    kubelet_pod_worker_start_latency_microseconds  #summary类型，（已弃用）从看到容器到开始工作的等待时间（以微秒为单位）。
    kubelet_cgroup_manager_latency_microseconds_sum
    kubelet_network_plugin_operations_latency_microseconds_sum
    http_request_duration_microseconds  #summary类型，HTTP请求延迟（以微秒为单位）。
    kubelet_cgroup_manager_latency_microseconds_count
    http_response_size_bytes  #summary类型，HTTP响应大小（以字节为单位）。
    kubelet_pod_start_latency_microseconds  #summary类型，（已弃用）单个Pod从挂起到运行的延迟（以微秒为单位）。
    kubelet_containers_per_pod_count  #histogram类型，每个pod的容器数。
    kubelet_network_plugin_operations_latency_microseconds_count
    kubelet_pleg_relist_interval_microseconds  #summary类型，（已弃用）在PLEG中重新上市之间的间隔（以微秒为单位）。
    kubelet_pod_worker_latency_microseconds_sum
    kubelet_pod_worker_latency_microseconds_count
    storage_operation_errors_total  #counter类型，存储操作错误总数。
    process_resident_memory_bytes  #gauge类型，驻留内存大小（以字节为单位）。
    kubelet_certificate_manager_client_expiration_seconds  #gauge类型，证书生命周期的量度。 该值是证书自UTC 1970年1月1日起过期的秒数。
    kubelet_running_container_count  #gauge类型，当前正在运行的容器数
    http_request_size_bytes_sum
    kubelet_pleg_relist_latency_microseconds_count
    http_request_duration_microseconds_count
    kubelet_pod_worker_start_latency_microseconds_count
    kubelet_pleg_relist_interval_microseconds_sum
    scrape_samples_scraped
    process_open_fds
    kubelet_pod_worker_start_latency_microseconds_sum
    apiserver_storage_data_key_generation_failures_total  #counter类型，失败的数据加密密钥（DEK）生成操作的总数。
    http_request_size_bytes_count
    kubelet_running_pod_count  #gauge类型，当前运行的pod数
    kubelet_node_config_error  #gauge类型，如果节点遇到与配置相关的错误，则此指标为true（1），否则为false（0）。
    kubelet_pod_start_latency_microseconds_count
    apiserver_storage_data_key_generation_latencies_microseconds_count
    kubelet_pleg_relist_latency_microseconds_sum
    process_virtual_memory_bytes
    scrape_samples_post_metric_relabeling
    process_start_time_seconds
    kubelet_pod_start_latency_microseconds_sum
    apiserver_client_certificate_expiration_seconds_sum
    kubelet_containers_per_pod_count_count
    http_response_size_bytes_count
    kubernetes_build_info
    http_response_size_bytes_sum
    apiserver_audit_event_total  #counter类型，生成审计事件的计数器，并将其发送到审计后端。
    kubelet_containers_per_pod_count_sum
    kubelet_pleg_relist_interval_microseconds_count
    apiserver_storage_envelope_transformation_cache_misses_total  #counter类型，访问密钥解密密钥（KEK）时缓存未命中总数。
    scrape_duration_seconds
    apiserver_storage_data_key_generation_latencies_microseconds_sum
    http_request_duration_microseconds_sum
    apiserver_client_certificate_expiration_seconds_count



