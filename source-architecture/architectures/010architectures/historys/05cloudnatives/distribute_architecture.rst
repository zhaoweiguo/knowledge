从分布式架构到云原生架构
#############################

发展趋势
========

趋势::

    软件改变世界
    开源改变软件
    云吞噬开源

互联网::

    Web 1.0 业务模式
     基于流量点击赢利的单方面信息发布的
     由 All in One 的「单体式」应用架构
    Web 2.0 业务模式
     由用户主导而生成内容的
     更加灵活的「分布式应用」架构
    移动互联网时代
     智能手机的出现以及 4G 标准的普及
     互联网应用由 PC 端迅速转向更加自由的移动端
     概念：SOA、DevOps、容器、CI/CD、微服务、Service Mesh
     产品：Docker、Kubernetes、Mesos、Spring Cloud、gRPC、Istio
     「云原生」架构

云原生生态圈
============

应用定义与开发层-Application and Development
--------------------------------------------

* 数据库::

    1. 关系型DB
     Oracle
     SQL Server
     MySQL
     PostgreSQL
     DB2
     MariaDB
    2. NoSQL
     MongoDB-面向文档
     Couchbase-面向列簇
     Redis-面向k/v
     Cassandra
     HBase
     Neo4j-面向图
    3. NewSQL
     TiDB-PingCAP
     兼容SQL，更擅长分布式处理
    4. 大数据处理方案
     Hadoop
     Spark
     Druid

* 流式处理::

    1. Streaming&Message
    2. 消息中间件
        CloudEvent
        NATS
        RabbitMQ
        Kafka
        OpenMessaging-阿里
    3. 流式实时计算框架
        Storm
        Flink

应用定义&镜像构建::

    Application Definition & Image Build
    应用定义
      Helm

持续集成&持续交付::

    Continuous Integration & Delivery
    持续交付
     Argo


编排&治理-Orchestration&Management
----------------------------------

* 调度与编排(Scheduling&Orchestration)::

    Kubernetes
    MeshOS
    Swarm
    Nomad

* 分布式协调与服务发现(Coordination & Service Discovery)::

    CoreDNS-CNCF
    etcd-CNCF
    zookeeper
    Eureka-netflix

* 远程过程调用(Remote Procedure Call)::

    gRPC-CNCF
    Thrift-Apache
    SofaRPC

* 服务代理(Service Proxy)::

    Envoy-CNCF
    contour-CNCF
    BFE-baidu,CNCF
    Nginx
    Haproxy
    traefik
    f5-硬件

* API网关(Api Gateway)::

    apisix
    kong

* 服务网格(Service Mesh)::

    Istio
    Linkerd




运行时-Runtime
--------------


云原生存储(Cloud-Native Storage)::

    ROOK-CNCF

容器运行时(Container Runtime)::

    containerd-CNCF
    cri-o
    gVisor
    kata
    SmartOS

云原生网络(Cloud-Native Network)::

    CNI-CNCF
    flannel
    Calico
    weave

供应保障层-Provisioning
-----------------------


自动化&配置(Automation&Configuration)::

    Ansible
    Puppet
    Chef
    Apollo
    KubeEdge

容器仓库(Container Registry)::

    Harbor-CNCF
    Dragonfly-CNCF

安全与规格(Security & Compliance)::

    TUF-CNCF
    falco-CNCF
    Notary-CNCF
    OpenPolicyAgent-CNCF
    Clair
    Twistlock

密钥管理(Key Management)::

    Spiffe-CNCF
    Spire-CNCF
    Vault


可观察性与分析-Observability and Analysis
-----------------------------------------

监控-Monitoring::

    Prometheus-CNCF
    Thanos-CNCF
    InfluxDB
    Grafana
    OpenMetrics

日志-Loging::

    Fluentd-CNCF
    Elastic
    logstash

跟踪-Tracing::

    Jaeger-CNCF
    OpenTracing-CNCF
    SkyWalking
    OpenTelemetry
    zipkin

混沌工程-Chaos Engineering::

    ChaosMesh
    ChaosToolKit
    ChaosKube
    ChaosBlade


观察分布式服务
==============


核心概念::

    日志（Logging）
     日志描述的是一些不连续的离散事件
    指标（Metrics）
     指标可以累加，具有原子性
    追踪（Tracing）
     又称分布式追踪

组合::

    追踪+日志
     分布式追踪系统的早期形态
     在单次请求范围内处理信息
    日志+指标
     日志分析系统的常规架构
     解析现有日志获取相关指标
    追踪+指标
     指明基于追踪系统的数据分析指标
     应用间的关系以及数据流向

分布式追踪::

    来源
     Google于2010年发布的论文
     Dapper, a Large-Scale Distributed Systems Tracing Infrastructure
    核心实现方法
     请求上下文中增加span_id和parent_id
     用于记录请求的上下文关系

常见的开源解决方案::

    Apache Zipkin
    OpenTracing
     Jaeger
     OpenCensus
     OpenTelemetry


云原生基石-Kubernetes
=====================

核心组件::

    etcd
     协同存储、负责保存整个集群的状态
    api-server
     提供资源操作的唯一入口
     提供认证、授权、访问控制、API注册和发现等机制
    controller manager
     负责维护集群状态
     执行故障检测、自动扩展、滚动更新等操作
    Scheduler
     负责资源调度
     按调度策略将Pod调度到相应的机器
    Kubelet
     负责维护容器的生命周期
     负责对容器存储接口(CSI)进行管理
     负责对容器网络接口(CNI)进行管理
    容器运行时(Docker)
     镜像管理
     Pod和容器的运行
    Proxy
     负责提供集群内部的服务发现和负载均衡

插件::

    CoreDNS
     为集群提供DNS服务
    Ingress Controller
     为服务提供外网入口
    Prometheus
     负责资源监控
    Dashboard
     提供GUI
    Federation
     提供跨可用区集群

分层架构::

    1. 核心层
      对外提供api构建高层应用
      对内插件式应用执行环境
    2. 应用层
     负责部署和路由
     可部署的应用包括
        * 无状态应用
        * 有状态应用
        * 批处理任务
        * 集群应用等
     路由类型有
        * 服务发现
        * DNS解析
    3. 管理层
     负责自动化
        * 自动扩展
        * 动态部署
     策略
        * RBAC
        * ResourceQuota
        * NetworkPolicy
    4. 接口层
     kubectl命令行工具
     客户端SDK
    5. 云原生生态系统
     接口层之上
     负责容器集群管理调度
    6. Kubernetes内部
     CRI
     CSI
     CNI
     镜像仓库
     云供应商
     身份供应商

设计哲学::

    设计模式
     命令式->声明式


ServiceMesh
===========

前期::

    Sidecar

ServiceMesh期::

    不再将代理视为单独的组件
    强调这些代理连接而成的网络
    强调服务间通信网络的整体



参考
====

* 架构新纪元（一）：从分布式架构到云原生架构: https://www.infoq.cn/article/fAjL7MEGbjKJtS75MN4E
* 架构新纪元（三）：云原生的生态圈: https://www.infoq.cn/article/RKZMdz4HOtqGUCuWmTUZ
* 架构新纪元（四）：观察分布式服务: https://www.infoq.cn/article/zp1SuoGdo09du04eliCU
* 架构新纪元（五）：云原生生态的基石 Kubernetes: https://www.infoq.cn/article/xT2yhmyewicXrecS8mQI/