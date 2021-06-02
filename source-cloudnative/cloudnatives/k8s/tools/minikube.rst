Minikube相关
############

查看::

    $ minikube version
    minikube version: v1.8.1
    commit: cbda04cf6bbe65e987ae52bb393c10099ab62014

启动::

    $ minikube start --wait=false
    * minikube v1.8.1 on Ubuntu 18.04
    * Using the none driver based on user configuration
    * Running on localhost (CPUs=2, Memory=2460MB, Disk=145651MB) ...
    * OS release is Ubuntu 18.04.4 LTS
    * Preparing Kubernetes v1.17.3 on Docker 19.03.6 ...
      - kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
    * Launching Kubernetes ...
    * Enabling addons: default-storageclass, storage-provisioner
    * Configuring local host environment ...
    * Done! kubectl is now configured to use "minikube"

检查启动情况::

    $ kubectl cluster-info
    $ kubectl get nodes
    // 创建一个deployment看看效果
    $ kubectl create deployment first-deployment --image=katacoda/docker-http-server
    $ kubectl expose deployment first-deployment --port=80 --type=NodePort
    $ export PORT=$(kubectl get svc first-deployment -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')
    $ echo "Accessing host01:$PORT"
    Accessing host01:31043
    $ curl host01:$PORT

启动dashboard::

    1. 启动dashboard
    $ minikube addons enable dashboard
    2. kubectl apply -f /opt/kubernetes-dashboard.yaml


enable RBAC::

    --extra-config=apiserver.Authorization.Mode=RBAC

Docker Desktop
==============

* https://blog.csdn.net/shenhonglei1234/article/details/106219257




