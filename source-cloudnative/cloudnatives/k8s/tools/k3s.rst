k3s&k3d
#######

* github [1]_
* k3s 是由 Rancher Labs 于2019年年初推出的一款轻量级 Kubernetes 发行版，满足在边缘计算环境中运行在 x86、ARM64 和 ARMv7 处理器上的小型、易于管理的 Kubernetes 集群日益增长的需求。
* k3s 除了在边缘计算领域的应用外，在研发侧的表现也十分出色。我们可以快速在本地拉起一个轻量级的 k8s 集群，而 k3d 则是 k3s 社区创建的一个小工具，可以在一个 docker 进程中运行整个 k3s 集群，相比直接使用 k3s 运行在本地，更好管理和部署。

安装
====

使用脚本安装::

    $ wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    # 或
    $ curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

    # 安装指定版本
    $ curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=v1.3.4 bash

使用 Homebrew 安装::

    $ brew install k3d

k3s 集群
=============

创建 k3s 集群::

    $ k3d create -n k3s-local
    INFO[0000] Created cluster network with ID 4f966a0738b22f77eb0fa37d38d954541947fe2b0f8f0e1fdf731d4a78a55ab8
    INFO[0000] Created docker volume  k3d-k3s-local-images
    INFO[0000] Creating cluster [k3s-local]
    INFO[0000] Creating server using docker.io/rancher/k3s:v1.17.3-k3s1...
    INFO[0000] Pulling image docker.io/rancher/k3s:v1.17.3-k3s1...
    INFO[0017] SUCCESS: created cluster [k3s-local]
    INFO[0017] You can now use the cluster with:

    export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-local')"
    kubectl cluster-info
    // 注意, 镜像拉取需要梯子

查看集群列表::

    $ k3d ls
    +-----------+------------------------------------+---------+---------+
    |   NAME    |               IMAGE                | STATUS  | WORKERS |
    +-----------+------------------------------------+---------+---------+
    | k3s-local | docker.io/rancher/k3s:v1.17.3-k3s1 | running |   0/0   |
    +-----------+------------------------------------+---------+---------+

删除集群::

    $ k3d delete -n k3s-local
    INFO[0000] Removing cluster [k3s-local]
    INFO[0000] ...Removing server
    INFO[0000] ...Removing docker image volume
    INFO[0000] Removed cluster [k3s-local]

使用k3d集群::

    $ export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-local')"

    $ kubectl cluster-info
    Kubernetes master is running at https://localhost:6443
    CoreDNS is running at https://localhost:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    Metrics-server is running at https://localhost:6443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

    $ kubectl get pod -n kube-system

停止集群::

    $ k3d stop --name='k3s-local'

启动集群::

    $ k3d start --name='k3s-local'

k3d命令::

    NAME:
       k3d - Run k3s in Docker!

    USAGE:
       k3d [global options] command [command options] [arguments...]

    VERSION:
       v1.7.0

    COMMANDS:
         check-tools, ct   Check if docker is running
         shell             Start a subshell for a cluster
         create, c         Create a single- or multi-node k3s cluster in docker containers
         add-node          [EXPERIMENTAL] Add nodes to an existing k3d/k3s cluster (k3d by default)
         delete, d, del    Delete cluster
         stop              Stop cluster
         start             Start a stopped cluster
         list, ls, l       List all clusters
         get-kubeconfig    Get kubeconfig location for cluster
         import-images, i  Import a comma- or space-separated list of container images from your local docker daemon into the cluster
         version           print k3d and k3s version
         help, h           Shows a list of commands or help for one command

    GLOBAL OPTIONS:
       --verbose      Enable verbose output
       --timestamp    Enable timestamps in logs messages
       --help, -h     show help
       --version, -v  print the version




.. [1] https://github.com/rancher/k3d