prometheus
##########

* github [1]_
* 官方文档 [2]_

::

    开源协议: Apache-2.0
    语言: Golang

简介
====

Prometheus is an open-source systems monitoring and alerting toolkit originally built at SoundCloud. 
Since its inception in 2012, many companies and organizations have adopted Prometheus, and the project has a very active developer and user community.
It is now a standalone open source project and maintained independently of any company. 
To emphasize this, and to clarify the project's governance structure, Prometheus joined the Cloud Native Computing Foundation in 2016 as the second hosted project, after Kubernetes.

Prometheus的特点::

    多维度数据模型。
    灵活的查询语言。
    不依赖分布式存储，单个服务器节点是自主的。
    通过基于HTTP的pull方式采集时序数据。
    可以通过中间网关进行时序列数据推送。
    通过服务发现或者静态配置来发现目标服务对象。
    支持多种多样的图表和界面展示，比如Grafana等。


安装
====

linux版安装 [3]_
----------------

基本::

    PROMETHEUS_VERSION="2.15.2"   // 20200118最新版
    wget https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz -O /tmp/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
    tar -xvzf /tmp/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz --directory /tmp/ --strip-components=1

    $ /tmp/prometheus --version

配置::

    $ cat > /tmp/test-etcd.yaml <<EOF
    global:
      scrape_interval: 10s
    scrape_configs:
      - job_name: test-etcd
        static_configs:
        - targets: ['10.240.0.32:2379','10.240.0.33:2379','10.240.0.34:2379']
    EOF
    $ cat /tmp/test-etcd.yaml


Set up the Prometheus handler::

    nohup /tmp/prometheus \
        -config.file /tmp/test-etcd.yaml \
        -web.listen-address ":9090" \
        -storage.local.path "test-etcd.data" >> /tmp/test-etcd.log  2>&1 &

* Now Prometheus will scrape etcd metrics every 10 seconds.



Docker版安装
------------

::

    $ docker run \
      -p 9090:9090 \
      -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml \
      prom/prometheus


文档
====

* https://yunlzheng.gitbook.io/prometheus-book/





.. [1] https://github.com/prometheus/prometheus
.. [2] https://prometheus.io/docs/introduction/overview/
.. [3] https://prometheus.io/download/