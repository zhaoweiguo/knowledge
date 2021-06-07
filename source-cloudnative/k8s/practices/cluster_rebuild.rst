Kubernetes集群重建
#######################

清除原来数据
==================

ubuntu::

    kubeadm reset
    sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*   
    sudo apt-get autoremove  
    sudo rm -rf ~/.kube
    // 重启服务器

centos::

    kubeadm reset
    yum erase kubeadm kubectl kubelet kubernetes-cni kube*
    yum autoremove
    rm -rf ~/.kube




遇到的问题
=============

1. 更改node的ip重建不成功(待解决)
2. 修改/etc/hosts文件导致不成功::

    127.0.0.1   localhost localhost.localdomain
    在修改时，不小心改成
    27.0.0.1   localhost localhost.localdomain
    导致一直不成功，各种尝试都不成功(包括卸载重新安装)
    // 报错内容如下:

    [root@node2 ~]# kubeadm join 192.168.99.232:6443 --token ylzhq5.maygo3jvcpue9bi5     --discovery-token-ca-cert-hash sha256:e1015866efdd2aed6569453b6c9daac30df1dcfbc406c9c755804b33e0500bb1
    [preflight] Running pre-flight checks
    [preflight] Reading configuration from the cluster...
    [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.15" ConfigMap in the kube-system namespace
    [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    [kubelet-start] Activating the kubelet service
    [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    [kubelet-check] Initial timeout of 40s passed.
    [kubelet-check] It seems like the kubelet isn't running or healthy.
    [kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get http://localhost:10248/healthz: dial tcp [::1]:10248: connect: connection refused.
    [kubelet-check] It seems like the kubelet isn't running or healthy.
    [kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get http://localhost:10248/healthz: dial tcp [::1]:10248: connect: connection refused.
    error execution phase kubelet-start: error uploading crisocket: timed out waiting for the condition



执行命令
=============

$> kubeadm reset::

    [root@master ingress-nginx]# kubeadm reset::

    [reset] Reading configuration from the cluster...
    [reset] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    [reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
    [reset] Are you sure you want to proceed? [y/N]: y
    [preflight] Running pre-flight checks
    [reset] Removing info for node "master.k8s" from the ConfigMap "kubeadm-config" in the "kube-system" Namespace
    [reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
    [reset] Are you sure you want to proceed? [y/N]: y
    [preflight] Running pre-flight checks
    [reset] Stopping the kubelet service
    [reset] Unmounting mounted directories in "/var/lib/kubelet"
    [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
    [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
    [reset] Deleting contents of stateful directories: [/var/lib/kubelet /etc/cni/net.d /var/lib/dockershim /var/run/kubernetes]

    The reset process does not reset or clean up iptables rules or IPVS tables.
    If you wish to reset iptables, you must do so manually.
    For example:
    iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

    If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
    to reset your system's IPVS tables.

    The reset process does not clean your kubeconfig files and you must remove them manually.
    Please, check the contents of the $HOME/.kube/config file.



