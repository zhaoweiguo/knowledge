常用
##########

容器服务Kubernetes版包含了::

    1. 专有版Kubernetes（Dedicated Kubernetes）：
      需要创建3个Master（高可用）节点及若干Worker节点
      可对集群基础设施进行更细粒度的控制，需要自行规划、维护、升级服务器集群
      免费。用户承担Master节点和Worker节点的资源费用
    2. 托管版Kubernetes（Managed Kubernetes）：
      只需创建Worker节点，Master节点由容器服务创建并托管。
      具备简单、低成本、高可用、无需运维管理Kubernetes集群Master节点的特点,您可以更多关注业务本身
      免费。用户承担Worker节点的资源费用
    3. Serverless Kubernetes：
      无需创建和管理Master节点及Worker节点
      即可通过控制台或者命令配置容器实例的资源、指明应用容器镜像以及对外服务的方式，直接启动应用程序
      按容器实例的使用资源量和时长（秒）计费
      适用于批量任务、突发扩容，以及CI/CD测试


名词对照::

    容器服务ACK 原生Kubernetes
    ========   =============
    集群        Cluster
    节点        Node
    容器        Container
    镜像        Image
    命名空间    Namespace
    无状态      Deployment
    有状态      StatefulSet
    任务        Job
    定时任务    CronJob
    服务        Service
    路由        Ingress
    标签        Label
    配置项      Configmap
    保密字典    Secret
    存储卷     PersistentVolume
    存储声明    PersistentVolumeClaim
    水平弹性伸缩  HPA
    虚拟集群IP  Cluster IP
    节点端口      NodePort
    负载均衡      LoadBalancer
    节点亲和性    NodeAffinity
    应用亲和性    PodAffinity
    应用非亲和性  PodAntiAffinity
    选择器      LabelSelector
    注解        Annotation
    触发器      Webhook
    端点        Entrypoint
    资源配额    Resource Quota
    资源限制    Limit Range
    模板        Template


.. figure:: /images/alis/k8s/k8s_3type.png
   :width: 80%



.. figure:: /images/alis/k8s/k8s_3type2.png
   :width: 80%














