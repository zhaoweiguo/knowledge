集群测试
#############



HA测试 [1]_
===============


* 在每个master 上删除pod，在相应node上看容器是否被删除
* 在每个master上修改pod的副本个数，在相应node上看是否有容器个数
* 依次关闭各个master 查看，etcd，scheduler，controller-manager这个三个组件的leader情况

* node关机，pod是否被在别的node上重新创建::

    现象：get node 可以很快看到对应node 状态变成no ready，但是pod状态还是一直是running，
    大约持续5分钟后关机的node上的pod状态变成 unknown,同时在其他node重建。

* 逐个关闭maset，然后逐个起来，看集，群是否能正常工作::

    现象：关闭master之后，master上面的pod的status也变成unknow，在master1上删除和创建pod都仍然有效。
    但是发现存活的etcd存在raft status不一致的情况，不知道正不正常。
    
    健康状态都是正常
    
    Node1的controller-manage和scheduler成为集群的leader

    重启master之后，master恢复功能
    但是关闭master和master1之后，集群出现问题



.. [1] https://developer.aliyun.com/article/704304










