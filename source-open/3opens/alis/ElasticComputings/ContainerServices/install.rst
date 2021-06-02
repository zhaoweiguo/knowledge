安装 [1]_
#############


mac安装
=============

安装kubectl::

    // 下载最新版本
    $> curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl
    $> chmod +x ./kubectl
    $> kubectl version

安装Minikube::

    1. 安装前检查
    // If you see VMX in the output, the VT-x feature is supported on your OS.
    sysctl -a | grep machdep.cpu.features

    2. 安装
      2.1 安装kubectl
      2.2 安装Hypervisor（如未安装，请安装下面其中一个）
        • HyperKit，https://github.com/moby/hyperkit(替代xhyve driver)
        • VirtualBox，https://www.virtualbox.org/wiki/Downloads
        • VMware Fusion，https://www.vmware.com/products/fusion
      2.3 安装minikube
        a. brew cask install minikube
        b. curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && chmod +x minikube

Cleanup local state::

    运行minikube start时报错:
    machine does not exist
    解决方法:
    minikube delete









.. [1] https://kubernetes.io/docs/tasks/tools/install-kubectl/

