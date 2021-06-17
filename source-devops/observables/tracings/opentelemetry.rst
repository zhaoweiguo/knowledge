OpenTelemetry
#############

* 官网 [1]_
* github [2]_
* specification: [3]_
* golang版实现 [4]_
* Google论文Dapper: :ref:`here <dapper>`

* OpenTelemetry makes robust, portable telemetry a built-in feature of cloud-native software.
* OpenTelemetry provides a single set of APIs, libraries, agents, and collector services to capture distributed traces and metrics from your application. You can analyze them using Prometheus, Jaeger, and other observability tools.

* OpenTracing支持、OpenCensus支持、直接进入CNCF sanbox项目

他的核心工作主要集中在3个部分::

    规范的制定，包括概念、协议、API，除了自身的协议外，还需要把这些规范和W3C、GRPC这些协议达成一致
    相关SDK、Tool的实现和集成，包括各类语言的SDK、代码自动注入、其他三方库(Log4j、LogBack等)的集成
    采集系统的实现，目前还是采用OpenCensus的采集架构，包括Agent和Collector



.. [1] https://opentelemetry.io
.. [2] https://github.com/open-telemetry
.. [3] https://github.com/open-telemetry/opentelemetry-specification
.. [4] https://github.com/open-telemetry/opentelemetry-go