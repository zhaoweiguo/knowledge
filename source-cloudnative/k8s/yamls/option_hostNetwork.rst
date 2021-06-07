hostNetwork选项
###############

.. note:: 使用hostNetwork选项，让pod没有自己的ip地址，而是直接使用host的网络接口。如果在此pod中运行一个进程绑定一个port，则这个进程直接绑定到node的端口。



.. literalinclude:: /files/k8s/yamls/option_hostNetwork.yaml
   :language: yaml


在pod内执行ifconfig与在host上执行结果一样::

    $ kubectl exec pod-with-host-network ifconfig
    docker0 Link encap:Ethernet HWaddr 02:42:14:08:23:47
        inet addr:172.17.0.1 Bcast:0.0.0.0 Mask:255.255.0.0 
        ...
    eth0 Link encap:Ethernet HWaddr 08:00:27:F8:FA:4E
        inet addr:10.0.2.15 Bcast:10.0.2.255 Mask:255.255.255.0 
        ...
    lo Link encap:Local Loopback
        inet addr:127.0.0.1 Mask:255.0.0.0
        ...
    veth1178d4f Link encap:Ethernet  HWaddr 1E:03:8D:D6:E1:2C
        inet6 addr: fe80::1c03:8dff:fed6:e12c/64 Scope:Link
        UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1


.. note:: 使用kubeadm部署集群，就使用到了hostNetwork选项


hostPID
=======

.. literalinclude:: /files/k8s/yamls/option_hostPID.yaml
   :language: yaml

使用hostPID则可以在pod上查看到host上的进程,而使用hostIPC则可以与host上的其他进程进行Inter-Process Communication::

    $ kubectl exec pod-with-host-pid-and-ipc ps aux
    PID   USER     TIME   COMMAND
     1    root     0:01   /usr/lib/systemd/systemd --switched-root --system ... 
     2    root     0:00   [kthreadd]
     2    root     0:00   [ksoftirqd/0]
     3    root     0:00   [kworker/0:0H]
     4    root     0:00   [kworker/u2:0]
     5    root     0:00   [migration/0]
     6    root     0:00   [rcu_bh]
     7    root     0:00   [rcu_sched]
     8    root     0:00   [watchdog/0]
    ...






