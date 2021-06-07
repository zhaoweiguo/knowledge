kubernetes-apiservers
#####################

# kubectl get --raw /metrics  #从kube-apiserver拿到metrics信息::

    apiserver_admission_controller_admission_latencies_seconds_bucket   #apiserver准入控制器准入等待时间单位秒bucket,里面还有不同标签有2000多项
    apiserver_request_latencies_bucket  #apiserver请求等待时间bucket，里面还有不同的label有2000多项
    apiserver_response_sizes_bucket  #apiserver响应大小bucket，里面还有不同的label有800多项
    apiserver_request_latencies_summary  #apiserver请求延迟summary，里面有不同的label有400多项
    apiserver_admission_step_admission_latencies_seconds_bucket  #apiserver允许step允许等待时间单位为秒bucket，有400多不同label的项。 
    apiserver_admission_controller_admission_latencies_seconds_count  #apiserver接纳控制器接纳等待时间秒数，有400多不同label的项。
    apiserver_admission_controller_admission_latencies_seconds_sum  #apiserver准入控制器准入等待时间秒数总和,有400多不同label项。
    apiserver_request_count  #apiserver请求计数，有不到400个不同label项。
    reflector_list_duration_seconds  #reflector list持续时间单位为秒，有不到300个不同的label项。
    reflector_items_per_list  #reflector items每个清单，有不到300个不同的label项。
    reflector_watch_duration_seconds  #reflector watch持续时间单位为秒，有不到300个不同的label项。
    reflector_items_per_watch  #有不到300个不同的label项。
    apiserver_admission_step_admission_latencies_seconds_summary  #apiserver允许step允许等待时间秒摘要，有200多个不同的label项。
    apiserver_request_latencies_summary_sum  #apiserver请求延迟汇总，有不到200个不同的label项。
    apiserver_request_latencies_summary_count  #apiserver请求延迟次数汇总，有不到200个不同的label项。
    apiserver_request_latencies_sum  #apiserver请求延迟总和，有不到200个不同的label项。
    apiserver_request_latencies_count  #apiserver请求延迟次数总和，有不到200个不同的label项。
    apiserver_response_sizes_count  #apiserver响应大小计数，有不到200个不同的label项。
    apiserver_response_sizes_sum  #apiserver响应大小总和，有100多个不同的label项。
    reflector_items_per_list_count   #有不到100个不同的label项。
    reflector_last_resource_version  #有不到100个不同的label项。
    reflector_lists_total  #有不到100个不同的label项。
    reflector_items_per_watch_count  #有不到100个不同的label项。
    reflector_watch_duration_seconds_count  #有不到100个不同的label项。
    reflector_list_duration_seconds_sum  #有不到100个不同的label项。
    reflector_items_per_watch_sum  #有不到100个不同的label项。
    reflector_watch_duration_seconds_sum  #有不到100个不同的label项。
    reflector_watches_total  #有不到100个不同的label项。
    reflector_short_watches_total  #有不到100个不同的label项。
    reflector_items_per_list_sum  #有不到100个不同的label项。
    reflector_list_duration_seconds_count  #有不到100个不同的label项。
    apiserver_admission_step_admission_latencies_seconds_sum  #有不到100个不同的label项。
    apiserver_admission_step_admission_latencies_seconds_summary_count  #有不到100个不同的label项。
    apiserver_admission_step_admission_latencies_seconds_count  #有不到100个不同的label项。
    apiserver_admission_step_admission_latencies_seconds_summary_sum  #有不到100个不同的label项。
    rest_client_request_latency_seconds_bucket  #有不到100个不同的label项。
    apiserver_longrunning_gauge  #有50个不同的label项。
    etcd_object_counts  #etcd对象计数，有50个不同的label项。
    apiserver_registered_watchers  #apiserver注册watchers，有不到50个不同的label项。
    apiserver_storage_data_key_generation_latencies_microseconds_bucket  #apiserver存储数据密钥生成延迟微秒级bucket，有不到20个不同的label项。
    apiserver_client_certificate_expiration_seconds_bucket #apiserver客户端证书到期秒数bucket，有不到20个不同的label项。
    rest_client_requests_total  #其余客户端请求总数，有8个不同的label项。
    grpc_client_started_total  #grpc客户端启动总数，有6个不同的label项。
    grpc_client_msg_sent_total  #grpc客户端msg发送总计,有6个不同的label项。
    rest_client_request_latency_seconds_sum  #其余客户端请求延迟秒数总和,有6个不同的label项。
    rest_client_request_latency_seconds_count  #其余客户端请求延迟秒数,有6个不同的label项。
    grpc_client_handled_total  #grpc客户端处理的总计，有5个不同的label项。
    apiserver_audit_level_total  #apiserver审核级别总计，有4个不同的label项。
    admission_quota_controller_queue_latency  #准入配额控制器队列延迟，有3个不同的label项。
    autoregister_queue_latency  #自动注册队列延迟，有3个不同的label项。
    crdEstablishing_queue_latency  #crd建立队列延迟，有3个不同的label项。
    autoregister_work_duration  #自动注册工作时间，有3个不同的label项。
    http_response_size_bytes  #http响应大小字节，有3个不同的label项。
    etcd_request_cache_get_latencies_summary  #etcd请求缓存获取延迟summary，有3个不同的label项。
    APIServiceRegistrationController_work_duration  #APIServiceRegistrationController工作持续时间，有3个不同的label项
    APIServiceOpenAPIAggregationControllerQueue1_work_duration  #APIServiceOpenAPIAggregationControllerQueue1的工作时间，有3个不同的label项
    APIServiceRegistrationController_queue_latency  #APIServiceRegistrationController队列延迟，有3个不同的label项
    DiscoveryController_queue_latency  #DiscoveryController队列延迟，有3个不同的label项
    AvailableConditionController_work_duration  #AvailableConditionController工作时间，有3个不同的label项
    APIServiceOpenAPIAggregationControllerQueue1_queue_latency  #APIServiceOpenAPIAggregationControllerQueue1队列延迟，有3个不同的label项
    etcd_request_cache_add_latencies_summary  #etcd请求缓存add延迟summary，有3个不同的label项
    http_request_size_bytes  #http请求大小字节，有3个不同的label项
    AvailableConditionController_queue_latency  #AvailableConditionController队列延迟，有3个不同的label项
    DiscoveryController_work_duration  #DiscoveryController的工作时间，有3个不同的label项
    http_request_duration_microseconds  #http请求持续时间微秒，有3个不同的label项
    admission_quota_controller_work_duration  #admission_quota控制器的持续工作时间，有3个不同的label项
    crdEstablishing_work_duration  #crd建立连接的工作时间，有3个不同的label项
    apiserver_current_inflight_requests  #apiserver当前进行中的请求，有两个不同的label项
    get_token_fail_count  #get token失败计数
    scrape_duration_seconds  #采集时间单位为秒
    APIServiceRegistrationController_depth  #APIServiceRegistrationController深度
    AvailableConditionController_queue_latency_count  #AvailableConditionController队列延迟计数
    AvailableConditionController_retries  #AvailableConditionController重试
    AvailableConditionController_work_duration_count  #AvailableConditionController工作持续时间计数
    admission_quota_controller_work_duration_count  #admission_quota_controller工作持续时间计数
    apiserver_client_certificate_expiration_seconds_sum  #apiserver客户端证书到期秒数总和
    AvailableConditionController_work_duration_sum  #AvailableConditionController工作持续时间总和
    etcd_helper_cache_miss_count  #etcd helper缓存未命中计数
    DiscoveryController_queue_latency_count  #DiscoveryController队列延迟计数
    APIServiceOpenAPIAggregationControllerQueue1_depth  #APIServiceOpenAPIAggregationControllerQueue1深度
    APIServiceRegistrationController_adds
    admission_quota_controller_adds
    etcd_request_cache_get_latencies_summary_count  #etcd请求缓存获取延迟汇总计数
    http_request_duration_microseconds_sum  #http请求持续时间微秒总和
    autoregister_work_duration_count  #自动注册工作时间计数
    APIServiceOpenAPIAggregationControllerQueue1_queue_latency_count  #APIServiceOpenAPIAggregationControllerQueue1队列延迟计数
    autoregister_queue_latency_sum  #自动注册队列延迟总和
    autoregister_retries  #自动注册重试
    DiscoveryController_work_duration_count  #DiscoveryController工作持续时间计数
    APIServiceRegistrationController_queue_latency_sum  #APIServiceRegistrationController队列延迟总和
    APIServiceOpenAPIAggregationControllerQueue1_adds
    AvailableConditionController_depth
    AvailableConditionController_queue_latency_sum
    APIServiceRegistrationController_work_duration_count
    apiserver_audit_event_total  #apiserver审核事件总计
    etcd_request_cache_add_latencies_summary_count
    etcd_helper_cache_entry_count
    apiserver_storage_data_key_generation_failures_total  #apiserver存储数据密钥生成失败总数
    DiscoveryController_adds
    admission_quota_controller_queue_latency_count
    admission_quota_controller_work_duration_sum
    etcd_helper_cache_hit_count
    up
    kubernetes_build_info  #kubernetes构建信息
    http_response_size_bytes_count
    crdEstablishing_retries
    process_resident_memory_bytes
    http_response_size_bytes_sum
    DiscoveryController_retries  #DiscoveryController重试
    admission_quota_controller_queue_latency_sum
    AvailableConditionController_adds
    etcd_request_cache_get_latencies_summary_sum
    http_request_size_bytes_count
    process_start_time_seconds
    APIServiceOpenAPIAggregationControllerQueue1_retries
    admission_quota_controller_depth
    apiserver_storage_envelope_transformation_cache_misses_total
    autoregister_work_duration_sum
    crdEstablishing_work_duration_sum
    apiserver_client_certificate_expiration_seconds_count
    DiscoveryController_queue_latency_sum
    APIServiceOpenAPIAggregationControllerQueue1_queue_latency_sum
    apiserver_storage_data_key_generation_latencies_microseconds_sum
    autoregister_depth
    APIServiceOpenAPIAggregationControllerQueue1_work_duration_count
    crdEstablishing_queue_latency_sum
    apiserver_storage_data_key_generation_latencies_microseconds_count
    DiscoveryController_work_duration_sum
    etcd_request_cache_add_latencies_summary_sum
    APIServiceOpenAPIAggregationControllerQueue1_work_duration_sum
    scrape_samples_scraped
    APIServiceRegistrationController_queue_latency_count
    APIServiceRegistrationController_retries
    APIServiceRegistrationController_work_duration_sum








