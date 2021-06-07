集群结点升级
##################

1. 执行以下命令，把待升级驱动的GPU节点设置为不可调度::

    kubectl cordon node-name

2. 执行以下命令，把步骤1节点上的Pod转移到其他节点::

    kubectl drain node-name --grace-period=120 --ignore-daemonsets=true

3. 执行升级命令...

4. 在Master节点的任意路径下执行以下命令，将此节点设置为可调度::
      
    kubectl uncordon node-name


