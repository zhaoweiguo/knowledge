小技巧-翻墙才能用的镜像使用方法
###############################

说明::

    此技巧特别适合你用各种方法下载的镜像共享给别人快速使用

把用各种方法下载到的镜像备份::

    $ docker save -o k8s-v1.16.5.rar k8s.gcr.io/kube-proxy:v1.16.5 k8s.gcr.io/kube-apiserver:v1.16.5 k8s.gcr.io/kube-controller-manager:v1.16.5 k8s.gcr.io/kube-scheduler:v1.16.5 kubernetesui/dashboard:v2.0.0 k8s.gcr.io/coredns:1.6.2 k8s.gcr.io/pause:3.1 k8s.gcr.io/etcd:3.3.15-0

使用时加载镜像::

    $ docker load -i k8s-v1.16.5.rar
    Loaded image: k8s.gcr.io/kube-scheduler:v1.16.5
    Loaded image: kubernetesui/dashboard:v2.0.0
    Loaded image: k8s.gcr.io/coredns:1.6.2
    Loaded image: k8s.gcr.io/pause:3.1
    Loaded image: k8s.gcr.io/etcd:3.3.15-0
    Loaded image: k8s.gcr.io/kube-proxy:v1.16.5
    Loaded image: k8s.gcr.io/kube-apiserver:v1.16.5
    Loaded image: k8s.gcr.io/kube-controller-manager:v1.16.5




参考
====

* https://blog.csdn.net/shenhonglei1234/article/details/106219257
