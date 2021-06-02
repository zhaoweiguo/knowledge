Prometheus集群版
################

$ cat prometheus0_eu1.yml::

    global:
      scrape_interval: 15s
      evaluation_interval: 15s
      external_labels:
        cluster: eu1
        replica: 0

    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['127.0.0.1:9090']


$ cat prometheus0_us1.yml::

    global:
      scrape_interval: 15s
      evaluation_interval: 15s
      external_labels:
        cluster: us1
        replica: 0

    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['127.0.0.1:9091','127.0.0.1:9092']

$ cat prometheus1_us1.yml::

    global:
      scrape_interval: 15s
      evaluation_interval: 15s
      external_labels:
        cluster: us1
        replica: 1

    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['127.0.0.1:9091','127.0.0.1:9092']

Deploying "EU1"::

    $ mkdir prometheus0_eu1_data
    $ docker run -d --net=host --rm \
    -v $(pwd)/prometheus0_eu1.yml:/etc/prometheus/prometheus.yml \
    -v $(pwd)/prometheus0_eu1_data:/prometheus \
    -u root \
    --name prometheus-0-eu1 \
    quay.io/prometheus/prometheus:v2.14.0 \
    --config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/prometheus \
    --web.listen-address=:9090 \
    --web.external-url=https://2886795324-9090-ollie08.environments.katacoda.com \
    --web.enable-lifecycle \  # allows Thanos Sidecar to reload Prometheus configuration and rule files if used.
    --web.enable-admin-api \  # allows Thanos Sidecar to get metadata from Prometheus like external labels
    && echo "Prometheus EU1 started!"

Deploying "US1"::

    // 启动结点0
    $ mkdir prometheus0_us1_data
    $ docker run -d --net=host --rm \
    -v $(pwd)/prometheus0_us1.yml:/etc/prometheus/prometheus.yml \
    -v $(pwd)/prometheus0_us1_data:/prometheus \
    -u root \
    --name prometheus-0-us1 \
    quay.io/prometheus/prometheus:v2.14.0 \
    --config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/prometheus \
    --web.listen-address=:9091 \
    --web.external-url=https://2886795324-9091-ollie08.environments.katacoda.com \
    --web.enable-lifecycle \
    --web.enable-admin-api && echo "Prometheus 0 US1 started!"

    // 启动结点1
    $ mkdir prometheus1_us1_data
    $ docker run -d --net=host --rm \
    -v $(pwd)/prometheus1_us1.yml:/etc/prometheus/prometheus.yml \
    -v $(pwd)/prometheus1_us1_data:/prometheus \
    -u root \
    --name prometheus-1-us1 \
    quay.io/prometheus/prometheus:v2.14.0 \
    --config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/prometheus \
    --web.listen-address=:9092 \
    --web.external-url=https://2886795324-9092-ollie08.environments.katacoda.com \
    --web.enable-lifecycle \
    --web.enable-admin-api && echo "Prometheus 1 US1 


Installing Thanos sidecar
=========================

Thanos Components::

    $ docker run --rm quay.io/thanos/thanos:v0.12.1 --help
    ...
    sidecar [<flags>]
      sidecar for Prometheus server
    ...
    $ docker run --rm quay.io/thanos/thanos:v0.12.1 sidecar --help
    --http-address="0.0.0.0:10902"
              Listen host:port for HTTP endpoints.
    --grpc-address="0.0.0.0:10901"
              Listen ip:port address for gRPC endpoints (StoreAPI). 
              Make sure this address is routable from other components.
    --reloader.config-file=""  
              Config file watched by the reloader.
    --prometheus.url=http://localhost:9090
              URL at which to reach Prometheus API. 
              For better performance use local network.

Adding sidecar to "EU1" Prometheus::

    $ docker run -d --net=host --rm \
    -v $(pwd)/prometheus0_eu1.yml:/etc/prometheus/prometheus.yml \
    --name prometheus-0-sidecar-eu1 \
    -u root \
    quay.io/thanos/thanos:v0.12.1 \
    sidecar \
    --http-address 0.0.0.0:19090 \
    --grpc-address 0.0.0.0:19190 \
    --reloader.config-file /etc/prometheus/prometheus.yml \
    --prometheus.url http://127.0.0.1:9090 
    && echo "Started sidecar for Prometheus 0 EU1"

Adding sidecars to each replica of Prometheus in "US1"::

    $ docker run -d --net=host --rm \
    -v $(pwd)/prometheus0_us1.yml:/etc/prometheus/prometheus.yml \
    --name prometheus-0-sidecar-us1 \
    -u root \
    quay.io/thanos/thanos:v0.12.1 \
    sidecar \
    --http-address 0.0.0.0:19091 \
    --grpc-address 0.0.0.0:19191 \
    --reloader.config-file /etc/prometheus/prometheus.yml \
    --prometheus.url http://127.0.0.1:9090 
    && echo "Started sidecar for Prometheus 0 US1"

    $ docker run -d --net=host --rm \
    -v $(pwd)/prometheus1_us1.yml:/etc/prometheus/prometheus.yml \
    --name prometheus-1-sidecar-us1 \
    -u root \
    quay.io/thanos/thanos:v0.12.1 \
    sidecar \
    --http-address 0.0.0.0:19092 \
    --grpc-address 0.0.0.0:19192 \
    --reloader.config-file /etc/prometheus/prometheus.yml \
    --prometheus.url http://127.0.0.0.1:9090 
    && echo "Started sidecar for Prometheus 1 US1"

验证
====

修改配置文件, 如修改prometheus0_eu1.yml文件::

    $ cat prometheus0_eu1.yml
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
      external_labels:
        cluster: eu1
        replica: 0

    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['127.0.0.1:9090']
      - job_name: 'sidecar'
        static_configs:
          - targets: ['127.0.0.1:19090']

打开 `浏览器 <https://127.0.0.1:9090/config>`_ ::

    global:
      scrape_interval: 15s
      scrape_timeout: 10s
      evaluation_interval: 15s
      external_labels:
        cluster: eu1
        replica: "0"
    scrape_configs:
    - job_name: prometheus
      honor_timestamps: true
      scrape_interval: 15s
      scrape_timeout: 10s
      metrics_path: /metrics
      scheme: http
      static_configs:
      - targets:
        - 127.0.0.1:9090
    - job_name: sidecar   # 这儿下面会自动出现
      honor_timestamps: true
      scrape_interval: 15s
      scrape_timeout: 10s
      metrics_path: /metrics
      scheme: http
      static_configs:
      - targets:
        - 127.0.0.1:19090

Adding Thanos Querier
=====================

Deploying Thanos Querier::

    $ docker run -d --net=host --rm \
    --name querier \
    quay.io/thanos/thanos:v0.12.1 \
    query \
    --http-address 0.0.0.0:29090 \
    --query.replica-label replica \
    --store 127.0.0.1:19190 \
    --store 127.0.0.1:19191 \
    --store 127.0.0.1:19192 && echo "Started Thanos Querier"

Setup verification::

    打开浏览器: https://127.0.0.1:29090/stores

    可使用以下命令获得集群总series
    sum(prometheus_tsdb_head_series)

总结
====

1. us1看到数据比en1的多, 因为us1的targets是俩
2. us1有两个结点, 可以容忍一个结点挂掉, 实现了高可用


