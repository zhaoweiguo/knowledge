一个简单的 exporter
###################

sample_exporter.go:

.. literalinclude:: /files/golangs/prometheus_exporter_sample.go


当运行此程序，你访问 http://localhost:8080/metrics, 将看到这样的页面::

    # HELP sample_http_requests_total The total number of HTTP requests.
    # TYPE sample_http_requests_total counter
    sample_http_requests_total{method="post",code="200"} 1027 1395066363000
    sample_http_requests_total{method="post",code="400"}    3 1395066363000

    ...

    sample_rpc_duration_seconds{quantile="0.5"} 4773
    sample_rpc_duration_seconds{quantile="0.9"} 9001
    sample_rpc_duration_seconds{quantile="0.99"} 76656
    sample_rpc_duration_seconds_sum 1.7560473e+07
    sample_rpc_duration_seconds_count 2693

与 Prometheus 集成::

    利用 Prometheus 的 static_configs 来收集 sample_exporter 的数据

打开 prometheus.yml 文件, 在 scrape_configs 中添加如下配置::

    - job_name: "sample"
        static_configs:
          - targets: ["127.0.0.1:8080"]

重启加载配置，然后到 Prometheus Console 查询，你会看到 simple_exporter 的数据:

.. image:: /images/monitors/prometheus/simple_exporter.png








