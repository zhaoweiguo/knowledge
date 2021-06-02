node_exporter
==================

* github [1]_

安装::

    VERSION="0.18.1"   // 20200118最新版
    wget https://github.com/prometheus/node_exporter/releases/download/v$PROMETHEUS_VERSION/node_exporter-$VERSION.linux-amd64.tar.gz -O /tmp/node_exporter-$PROMETHEUS_VERSION.linux-amd64.tar.gz
    tar -xvzf /tmp/node_exporter-$PROMETHEUS_VERSION.linux-amd64.tar.gz --directory /tmp/ --strip-components=1
    
    $ /tmp/node_exporter --version

常用查询语句::

    CPU 使用率:
    100 - (avg by (instance) (irate(node_cpu{instance="xxx", mode="idle"}[5m])) * 100)

    CPU 各 mode 占比率
    avg by (instance, mode) (irate(node_cpu{instance="xxx"}[5m])) * 100

    机器平均负载
    node_load1{instance="xxx"} // 1分钟负载
    node_load5{instance="xxx"} // 5分钟负载
    node_load15{instance="xxx"} // 15分钟负载

    内存使用率
    100 - ((
      node_memory_MemFree{instance="xxx"}+
      node_memory_Cached{instance="xxx"}+
      node_memory_Buffers{instance="xxx"}
    )/node_memory_MemTotal) * 100

    磁盘使用率
    100 - 
    node_filesystem_free_bytes{instance="xxx",fstype!~"rootfs|selinuxfs|autofs|rpc_pipefs|tmpfs|udev|none|devpts|sysfs|debugfs|fuse.*"} / 
    node_filesystem_size_bytes{instance="xxx",fstype!~"rootfs|selinuxfs|autofs|rpc_pipefs|tmpfs|udev|none|devpts|sysfs|debugfs|fuse.*"} * 100

    网络 IO:
    // 上行带宽
    sum by (instance) (irate(node_network_receive_bytes{instance="xxx",device!~"bond.*?|lo"}[5m])/128)
    // 下行带宽
    sum by (instance) (irate(node_network_transmit_bytes{instance="xxx",device!~"bond.*?|lo"}[5m])/128)

    网卡出/入包:
    // 入包量
    sum by (instance) (rate(node_network_receive_bytes{instance="xxx",device!="lo"}[5m]))
    // 出包量
    sum by (instance) (rate(node_network_transmit_bytes{instance="xxx",device!="lo"}[5m]))






.. [1] https://github.com/prometheus/node_exporter