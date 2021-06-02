定义
###########


Deployment
----------------

k8s 1.2引入的概念，内部使用Replica Set来实现




退出码::

    Exit Code: 128+x
    如: Exit Code=137: x=137-128=9, 9是SIGKILL信号的编号
    143对应x=15, 15是SIGTERM信号的编号

存活探针::

    1. http get探针
    2. TCP Socket探针
    3. Exec探针

就绪探针::

    1. http get探针
    2. TCP Socket探针
    3. Exec探针



环境变量::

    <PodName>_SERVICE_HOST: 服务的集群IP
    <PodName>_SERVICE_PORT: 服务所在的端口

imagePullPolicy::

    1. IfNotPresent: 只有在本地docker images不存在时才拉取镜像
    2. Always: 每次都会重新拉取镜像
    3. Never: 只使用本地镜像，从不拉取，即使本地没有
    注: 如果省略imagePullPolicy 镜像tag为 :latest 策略为always,否则 策略为 IfNotPresent



restartPolicy::

    1. Never      # 容器启动后未成功就会一直创建新的容器
    2. OnFailure  # 容器启动后未成功不会在创建新的容器，他会一直重启(容器终止运行且退出码不为0时重启)
    3. Always     # 容器失效时，kubelet 自动重启该容器
    注: 一般启动失败会不断重启，重启间隔会逐渐加大，最大间隔是5分钟

persistentVolumeReclaimPolicy::

    PersistentVolume专用:
    1. Retain: 声明被释放后，pv将会被保留(不清理和删除)
    2. Delete   # 声明被释放后，pv将会被清理、删除

PVC状态::

    RWO: ReadWriteOnce——仅允许单结点挂载读写
    ROX: ReadOnlyMany——允许多结点 挂载只读
    RWX: ReadWriteMany——允许多节点挂载读写









