Kubernetes集群组建
#######################

安装前准备
=============

1、关闭selinux::

    1.1 临时方案
    $ setenforce 0
    1.2 永久禁用
    修改文件 /etc/selinux/config
    将SELINUX=enforcing更改为SELINUX=permissive
    $ sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

2、添加hosts::

    // 使各结点能有效联通:
    $ cat >> /ets/hosts <<END
    k8s01 1.1.1.62
    k8s02 1.1.1.63
    k8s03 1.1.1.64
    END

3、配置代理::

    echo proxy=socks5://192.168.190.161:1080 >>/etc/yum.conf
    % 或使用阿里,163镜像解决

4、禁用防火墙::

    $ systemctl disable firewalld && systemctl stop firewalld

5、禁用交换区::

    $ swapoff -a && sed -i '/ swap / s/^/#/' c


6、结点要求::

    大于2G的内存
    至少2个逻辑 CPU
    节点之间网络互通
    每个节点具有唯一的主机名、Mac 地址
    开放相关端口
    关闭swap（很重要）



安装docker, kubeadm相关(全部结点)
==================================

Centos
----------

Yum仓库添加Kubernetes::

    // 增加文件/etc/yum.repos.d/kubernetes.repo
    1. Google版
    [kubernetes]
    name=Kubernetes
    baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg

    2. 上面需要翻墙，可用国内阿里镜像
    [kubernetes]
    name=Kubernetes
    baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
    enabled=1
    gpgcheck=0
    repo_gpgcheck=0
    gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
            http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg

安装docker, kubelet, kubeadm, kubectl和kubernetes-CNI::

    $ yum install -y docker kubelet kubeadm kubectl kubernetes-cni
    $ systemctl enable docker && systemctl start docker
    $ systemctl enable kubelet && systemctl start kubelet
    // 启用NET.BRIDGE.BRIDGE-NF-CALL-IPTABLES内核选项
    $ sysctl -w net.bridge.bridge-nf-call-iptables=1
    $ echo "net.bridge.bridge-nf-call-iptables=1" > /etc/sysctl.d/k8s.conf


Ubuntu [1]_
----------------

使用国内镜像源::

    // vim /etc/apt/sources.list
    deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted
    deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted
    deb http://mirrors.aliyun.com/ubuntu/ xenial universe
    deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
    deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse
    deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse
    deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
    deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main

安装 docker kubelet kubeadm kubectl::

    $ apt-get update
    $ apt-get install apt-transport-https -y
    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    $ apt-get install docker.io -y

    $ sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    $ apt-get update
    //如果认证有问题 就加上--allow-unauthenticated 
    $ apt-get install -y kubelet kubeadm kubectl --allow-unauthenticated

镜像加速::

    // 鉴于国内网络问题，后续拉取 Docker 镜像十分缓慢，我们可以需要配置加速器来解决
    /etc/docker/daemon.json:
    {
      "registry-mirrors": ["http://hub-mirror.c.163.com"]
    }


Debian [3]_
------------------

卸载旧版本::

    $ sudo apt-get remove docker \
               docker-engine \
               docker.io

使用 APT 安装依赖::

    $ sudo apt-get update

    $ sudo apt-get install \
         apt-transport-https \
         ca-certificates \
         curl \
         gnupg2 \
         lsb-release \
         software-properties-common

添加软件源的 GPG 密钥::

    # 1. 国内源
    $ curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | sudo apt-key add -

    # 2. 官方源
    # $ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

添加 Docker CE 软件源::

    $ sudo add-apt-repository \
       "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian \
       $(lsb_release -cs) \
       stable"

    # 官方源
    # $ sudo add-apt-repository \
    #    "deb [arch=amd64] https://download.docker.com/linux/debian \
    #    $(lsb_release -cs) \
    #    stable"

安装 Docker CE::

    $ sudo apt-get update
    $ sudo apt-get install docker-ce





拉取需要的镜像(所有结点都要有这7个镜像)
===============================================

方法一
----------

原始需要拉取的镜像::

    $ docker pull k8s.gcr.io/kube-apiserver:v1.15.0
    $ docker pull k8s.gcr.io/kube-controller-manager:v1.15.0
    $ docker pull k8s.gcr.io/kube-scheduler:v1.15.0
    $ docker pull k8s.gcr.io/kube-proxy:v1.15.0
    $ docker pull k8s.gcr.io/pause:3.1
    $ docker pull k8s.gcr.io/etcd:3.3.10
    $ docker pull k8s.gcr.io/coredns:1.3.1

方法二
--------

gcr被墙，国内拉不到镜像，docker官方做了镜像备份::

    $ docker pull mirrorgooglecontainers/kube-apiserver:v1.15.0
    $ docker pull mirrorgooglecontainers/kube-controller-manager:v1.15.0
    $ docker pull mirrorgooglecontainers/kube-scheduler:v1.15.0
    $ docker pull mirrorgooglecontainers/kube-proxy:v1.15.0
    $ docker pull mirrorgooglecontainers/pause:3.1
    $ docker pull mirrorgooglecontainers/etcd:3.3.10
    $ docker pull coredns/coredns:1.3.1

打成k8s.gcr.io镜像::

    $ docker tag mirrorgooglecontainers/kube-apiserver:v1.15.0 k8s.gcr.io/kube-apiserver:v1.15.0
    $ docker tag mirrorgooglecontainers/kube-controller-manager:v1.15.0 k8s.gcr.io/kube-controller-manager:v1.15.0
    $ docker tag mirrorgooglecontainers/kube-scheduler:v1.15.0 k8s.gcr.io/kube-scheduler:v1.15.0
    $ docker tag mirrorgooglecontainers/kube-proxy:v1.15.0 k8s.gcr.io/kube-proxy:v1.15.0
    $ docker tag mirrorgooglecontainers/pause:3.1  k8s.gcr.io/pause:3.1
    $ docker tag mirrorgooglecontainers/etcd:3.3.10 k8s.gcr.io/etcd:3.3.10
    $ docker tag mirrorgooglecontainers/coredns:1.3.1 k8s.gcr.io/coredns:1.3.1
    $ docker tag mirrorgooglecontainers/flannel:v0.11.0-amd64 quay.io/coreos/flannel:v0.11.0-amd64

方法三
--------

直接使用本人在aliyun的镜像::

     $ docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-proxy:v1.15.0
     $ docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-apiserver:v1.15.0
     $ docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-controller-manager:v1.15.0
     $ docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-scheduler:v1.15.0
     $ docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/coredns:1.3.1
     $ docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/etcd:3.3.10
     $ docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/pause:3.1

打成k8s.gcr.io镜像::

    $ docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-apiserver:v1.15.0 k8s.gcr.io/kube-apiserver:v1.15.0
    $ docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-controller-manager:v1.15.0 k8s.gcr.io/kube-controller-manager:v1.15.0
    $ docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-scheduler:v1.15.0 k8s.gcr.io/kube-scheduler:v1.15.0
    $ docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/kube-proxy:v1.15.0 k8s.gcr.io/kube-proxy:v1.15.0
    $ docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/pause:3.1  k8s.gcr.io/pause:3.1
    $ docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/etcd:3.3.10 k8s.gcr.io/etcd:3.3.10
    $ docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/coredns:1.3.1 k8s.gcr.io/coredns:1.3.1

初始化集群(Master节点)
========================

执行::

    $ kubeadm init --kubernetes-version=v1.15.0

    // 成功执行显示:
    Your Kubernetes control-plane has initialized successfully!

    To start using your cluster, you need to run the following as a regular user:

      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config

    You should now deploy a pod network to the cluster.
    Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
      https://kubernetes.io/docs/concepts/cluster-administration/addons/

    Then you can join any number of worker nodes by running the following on each as root:

    kubeadm join 192.168.99.232:6443 --token psvou0.zy4lwqsrkh3kaf4g \
        --discovery-token-ca-cert-hash sha256:dfe3957e15a7c0a3afe8448391db836835824ef3592d8f9e2cbe0c8580f115dd

配置::

    $ mkdir -p $HOME/.kube
    $ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    $ sudo chown $(id -u):$(id -g) $HOME/.kube/config

查看::

    $ kubectl -n kube-system get nodes
    $ kubectl -n kube-system get po -o wide


安装网络插件(Master节点)
=========================

kube插件 [2]_

方法1: 执行安装Flannel(未实测) [附录2]_::

    $ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml

    $ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

方法2: 执行安装Weave Net [附录1]_ ::

    kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl  version | base64 | tr -d '\n')"

    使用的资源文件详见附录

加入集群(从结点)
===========================

加入集群::

    // 初使化集群
    $ kubeadm join 192.168.99.232:6443 --token psvou0.zy4lwqsrkh3kaf4g \
        --discovery-token-ca-cert-hash sha256:dfe3957e15a7c0a3afe8448391db836835824ef3592d8f9e2cbe0c8580f115dd
    [preflight] Running pre-flight checks
    [preflight] Reading configuration from the cluster...
    [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.15" ConfigMap in the kube-system namespace
    [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    [kubelet-start] Activating the kubelet service
    [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

    This node has joined the cluster:
    * Certificate signing request was sent to apiserver and a response was received.
    * The Kubelet was informed of the new secure connection details.

    Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

配置::

    $ mkdir -p $HOME/.kube
    $ sudo cp -i /etc/kubernetes/kubelet.conf $HOME/.kube/config
    $ sudo chown $(id -u):$(id -g) $HOME/.kube/config

查看::

    // 在master节点执行 kubectl get nodes，可以检查是否成功加入
    $ kubectl get nodes
    $ kubectl -n kube-system get po -o wide  // 查看是否所有结点状态都变成Running
    $ kubectl -n kube-system describe pod <podName>    // 查看pod详情



遇到的问题
=============

1. 翻墙问题::

    a. 使用ssh -D建立通道
    b. export all_proxy=socks5://127.0.0.1:1087
    很奇怪使用curl可以,kubeadm init命令超时

2. docker image在3个结点上都要有::

    2.1 kubeadm init成功后执行如下命令
    $ kubectl -n kube-system get po
    NAME                                 READY   STATUS              RESTARTS   AGE
    coredns-5c98db65d4-59b6p             0/1     ContainerCreating   0          3h41m
    coredns-5c98db65d4-phrv2             0/1     ContainerCreating   0          3h41m
    etcd-master.k8s                      1/1     Running             0          3h40m
    kube-apiserver-master.k8s            1/1     Running             0          3h40m
    kube-controller-manager-master.k8s   1/1     Running             0          3h40m
    kube-proxy-95g5f                     1/1     Running             0          3h41m
    kube-proxy-sm6tp                     0/1     ContainerCreating   0          3h33m
    kube-proxy-z9687                     0/1     ImagePullBackOff    0          3h34m
    kube-scheduler-master.k8s            1/1     Running             0          3h40m
    weave-net-bfj6g                      2/2     Running             0          3h26m
    weave-net-d4f94                      1/2     CrashLoopBackOff    31         3h26m
    weave-net-k7rtf                      0/2     ContainerCreating   0          3h26m

    2.2 查看报错详情
    $ kubectl -n kube-system  describe pod weave-net-d4f94
    Events:
      Type     Reason                  Age                   From                Message
      ----     ------                  ----                  ----                -------
      Normal   Scheduled               66m                   default-scheduler   Successfully assigned kube-system/weave-net-8tlnl to node2.k8s
      Warning  FailedCreatePodSandBox  4m17s (x12 over 62m)  kubelet, node2.k8s  Failed create pod sandbox: rpc error: code = Unknown desc = failed pullin
    g image "k8s.gcr.io/pause:3.1": Get https://k8s.gcr.io/v1/_ping: dial tcp 74.125.203.82:443: i/o timeout
      Warning  FailedCreatePodSandBox  94s (x14 over 65m)    kubelet, node2.k8s  Failed create pod sandbox: rpc error: code = Unknown desc = failed pullin
    g image "k8s.gcr.io/pause:3.1": Get https://k8s.gcr.io/v1/_ping: dial tcp 108.177.97.82:443: i/o timeout
      Normal   Pulling                 81s                   kubelet, node2.k8s  Pulling image "docker.io/weaveworks/weave-kube:2.5.2"
      Normal   Pulled                  7s                    kubelet, node2.k8s  Successfully pulled image "docker.io/weaveworks/weave-kube:2.5.2"
      Normal   Created                 7s                    kubelet, node2.k8s  Created container weave
      Normal   Started                 7s                    kubelet, node2.k8s  Started container weave
      Normal   Pulling                 7s                    kubelet, node2.k8s  Pulling image "docker.io/weaveworks/weave-npc:2.5.2"

    2.3 原因
    CrashLoopBackOff大多数原因是因为没有image镜像
    我当时就是master结点下载了镜像，在slave结点没有下载镜像

3. 要指定ns::

    $ kubectl get ns
    NAME              STATUS   AGE
    default           Active   25h
    kube-node-lease   Active   25h
    kube-public       Active   25h
    kube-system       Active   25h

    $ kubectl get pod -n kube-system -o wide
    $ kubectl get svc -n kube-system -o wide


执行命令
=============

$> kubeadm join::

    $ kubeadm join 192.168.99.232:6443 --token psvou0.zy4lwqsrkh3kaf4g \
        --discovery-token-ca-cert-hash sha256:dfe3957e15a7c0a3afe8448391db836835824ef3592d8f9e2cbe0c8580f115dd
    [preflight] Running pre-flight checks
    [preflight] Reading configuration from the cluster...
    [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.15" ConfigMap in the kube-system namespace
    [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    [kubelet-start] Activating the kubelet service
    [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

    This node has joined the cluster:
    * Certificate signing request was sent to apiserver and a response was received.
    * The Kubelet was informed of the new secure connection details.

    Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

$> kubeadm init::

    [root@master ingress-nginx]# kubeadm init
    W0716 16:06:00.272095   72486 version.go:98] could not fetch a Kubernetes version from the internet: unable to get URL "https://dl.k8s.io/release/stable-1.txt": Get https://dl.k8s.io/release/stable-1.txt: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
    W0716 16:06:00.272464   72486 version.go:99] falling back to the local client version: v1.15.0
    [init] Using Kubernetes version: v1.15.0
    [preflight] Running pre-flight checks
    [preflight] Pulling images required for setting up a Kubernetes cluster
    [preflight] This might take a minute or two, depending on the speed of your internet connection
    [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
    [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    [kubelet-start] Activating the kubelet service
    [certs] Using certificateDir folder "/etc/kubernetes/pki"
    [certs] Generating "etcd/ca" certificate and key
    [certs] Generating "etcd/server" certificate and key
    [certs] etcd/server serving cert is signed for DNS names [master.k8s localhost] and IPs [192.168.99.232 127.0.0.1 ::1]
    [certs] Generating "etcd/peer" certificate and key
    [certs] etcd/peer serving cert is signed for DNS names [master.k8s localhost] and IPs [192.168.99.232 127.0.0.1 ::1]
    [certs] Generating "etcd/healthcheck-client" certificate and key
    [certs] Generating "apiserver-etcd-client" certificate and key
    [certs] Generating "ca" certificate and key
    [certs] Generating "apiserver-kubelet-client" certificate and key
    [certs] Generating "apiserver" certificate and key
    [certs] apiserver serving cert is signed for DNS names [master.k8s kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.99.232]
    [certs] Generating "front-proxy-ca" certificate and key
    [certs] Generating "front-proxy-client" certificate and key
    [certs] Generating "sa" key and public key
    [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
    [kubeconfig] Writing "admin.conf" kubeconfig file
    [kubeconfig] Writing "kubelet.conf" kubeconfig file
    [kubeconfig] Writing "controller-manager.conf" kubeconfig file
    [kubeconfig] Writing "scheduler.conf" kubeconfig file
    [control-plane] Using manifest folder "/etc/kubernetes/manifests"
    [control-plane] Creating static Pod manifest for "kube-apiserver"
    [control-plane] Creating static Pod manifest for "kube-controller-manager"
    [control-plane] Creating static Pod manifest for "kube-scheduler"
    [etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
    [wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
    [apiclient] All control plane components are healthy after 37.504192 seconds
    [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
    [kubelet] Creating a ConfigMap "kubelet-config-1.15" in namespace kube-system with the configuration for the kubelets in the cluster
    [upload-certs] Skipping phase. Please see --upload-certs
    [mark-control-plane] Marking the node master.k8s as control-plane by adding the label "node-role.kubernetes.io/master=''"
    [mark-control-plane] Marking the node master.k8s as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
    [bootstrap-token] Using token: ylzhq5.maygo3jvcpue9bi5
    [bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
    [bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
    [bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
    [bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
    [bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
    [addons] Applied essential addon: CoreDNS
    [addons] Applied essential addon: kube-proxy

    Your Kubernetes control-plane has initialized successfully!

    To start using your cluster, you need to run the following as a regular user:

      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config

    You should now deploy a pod network to the cluster.
    Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
      https://kubernetes.io/docs/concepts/cluster-administration/addons/
    127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
    ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
    #192.168.18.128       master.k8s
    #192.168.18.129       node1.k8s
    #192.168.18.130       node2.k8s


    192.168.99.232        master.k8s
    192.168.99.205        node1.k8s
    192.168.99.221        node2.k8s
    ...skipping...

    Then you can join any number of worker nodes by running the following on each as root:

    kubeadm join 192.168.99.232:6443 --token ylzhq5.maygo3jvcpue9bi5 \
        --discovery-token-ca-cert-hash sha256:e1015866efdd2aed6569453b6c9daac30df1dcfbc406c9c755804b33e0500bb1



.. [附录1] Weave Net资源文件net.yml:

.. literalinclude:: /files/k8s/practices/net_Weave.yml


.. [附录2] Flannel资源文件net_kube-flannel-rbac.yml和net_kube-flannel-rbac.yml:

.. literalinclude:: /files/k8s/practices/net_kube-flannel.yml

.. literalinclude:: /files/k8s/practices/net_kube-flannel-rbac.yml


.. [1] https://blog.csdn.net/u013171997/article/details/93607025
.. [2] http://kuber-netes.io/docs/admin/addons/
.. [3] https://yeasy.gitbooks.io/docker_practice/install/debian.html


