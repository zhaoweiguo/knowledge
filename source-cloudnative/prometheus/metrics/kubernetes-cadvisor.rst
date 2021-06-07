kubernetes-cadvisor
###################

* 查看信息类型地址: https://github.com/google/cadvisor/blob/master/metrics/testdata/prometheus_metrics

指标::

    container_tasks_state  #gauge类型，容器特定状态的任务数,根据不同的pod_name和state有600+的不同label.
    container_memory_failures_total  #counter类型，内存分配失败的累积计数,根据不同的pod_name和state有600+的不同label.
    container_network_receive_errors_total  #counter类型，容器网络接收时遇到的累计错误数。
    container_network_transmit_bytes_total  #counter类型，容器发送传输的累计字节数。
    container_network_transmit_packets_dropped_total  #counter类型，容器传输时丢弃的累计包数
    container_network_transmit_packets_total  #counter类型，传输数据包的累计计数
    container_network_transmit_errors_total  #counter类型，传输时遇到的累积错误数
    container_network_receive_bytes_total  #counter类型，收到的累计字节数
    container_network_receive_packets_dropped_total  #counter类型，接收时丢弃的累计数据包数
    container_network_receive_packets_total  #counter类型，收到的累计数据包数
    container_spec_cpu_period  #gauge类型，容器的CPU period。
    container_spec_memory_swap_limit_bytes  #容器swap内存交换限制字节
    container_memory_failcnt  #counter类型，内存使用次数达到限制
    container_spec_memory_reservation_limit_bytes  #容器规格内存预留限制字节
    container_spec_cpu_shares  #gauge类型，
    container_spec_memory_limit_bytes  #容器规格内存限制字节
    container_memory_max_usage_bytes  #gauge类型，以字节为单位记录的最大内存使用量
    container_cpu_load_average_10s  #gauge类型，最近10秒钟内的容器CPU平均负载值。
    container_memory_rss  #gauge类型，容器RSS的大小（以字节为单位）
    container_start_time_seconds  #gauge类型，从Unix纪元开始的容器开始时间（以秒为单位）。
    container_memory_mapped_file  #gauge类型，内存映射文件的大小（以字节为单位）
    container_cpu_user_seconds_total  #conter类型，累计CPU user 时间（以秒为单位）
    container_memory_cache  #gauge类型，内存的cache字节数。
    container_memory_working_set_bytes  #gague类型，当前工作集（以字节为单位）
    container_cpu_system_seconds_total  #conter类型，累计CPU system时间（以秒为单位）
    container_memory_swap  #gauge类型，容器交换使用量（以字节为单位）
    container_memory_usage_bytes  #gauge类型，当前内存使用情况（以字节为单位），包括所有内存，无论何时访问
    container_last_seen  #gauge类型，上一次export看到此容器的时间
    container_fs_writes_total  #counter类型，累计写入次数
    container_fs_reads_total   #counter类型，类型读取次数
    container_cpu_usage_seconds_total  #counter类型，累计消耗CPU的总时间
    container_fs_reads_bytes_total  #容器读取的总字节数
    container_fs_writes_bytes_total  #容器写入的总字节数
    container_fs_sector_reads_total  #counter类型，扇区已完成读取的累计计数
    container_fs_inodes_free  #gauge类型，可用的Inode数量
    container_fs_io_current  #gauge类型，当前正在进行的I/O数
    container_fs_io_time_weighted_seconds_total  #counter类型，累积加权I/O时间（以秒为单位）
    container_fs_usage_bytes  #gauge类型，此容器在文件系统上使用的字节数
    container_fs_limit_bytes  #gauge类型，此容器文件系统上可以使用的字节数
    container_fs_inodes_total  #gauge类型，inode数
    container_fs_sector_writes_total  #counter类型，扇区写入累计计数
    container_fs_io_time_seconds_total  #counter类型，I/O花费的秒数累计
    container_fs_writes_merged_total  #counter类型，合并的累计写入数
    container_fs_reads_merged_total  #counter类型，合并的累计读取数
    container_fs_write_seconds_total  #counter类型，写花费的秒数累计
    container_fs_read_seconds_total   #counter类型，读花费的秒数累计
    container_cpu_cfs_periods_total  #counter类型，执行周期间隔时间数
    container_cpu_cfs_throttled_periods_total  #counter类型，节流周期间隔数
    container_cpu_cfs_throttled_seconds_total  #counter类型，容器被节流的总时间
    container_spec_cpu_quota  #gauge类型，容器的CPU配额
    machine_memory_bytes  #gauge类型，机器上安装的内存量
    scrape_samples_post_metric_relabeling
    cadvisor_version_info
    scrape_duration_seconds
    machine_cpu_cores  #gauge类型，机器上的CPU核心数
    container_scrape_error  #gauge类型，如果获取容器指标时出错，则为1，否则为0
    scrape_samples_scraped








