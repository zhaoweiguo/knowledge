dashboard服务安装
#######################


配置kubernetes-dashboard [1]_
==================================

安装kubernetes-dashboard，并使得能够远程访问，yaml文件dashboard.yaml详见 [2]_
执行::

    $ kubectl apply -f dashboard.yaml
    文件执行完成后，可以通过https://IP:30000 来访问（注意: 是https不是http）

    在kubernetes 1.7之后建议使用token去登录

token获取方法:

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 2,7

    // 查询secret列表
    $ kubectl -n kube-system get secret
    attachdetach-controller-token-pqtcp              kubernetes.io/service-account-token   3      3h18m
    bootstrap-signer-token-qnx4s                     kubernetes.io/service-account-token   3      3h18m
    bootstrap-token-y89hw4                           bootstrap.kubernetes.io/token         7      3h18m
    certificate-controller-token-r6wl6               kubernetes.io/service-account-token   3      3h18m
    clusterrole-aggregation-controller-token-6mrrv   kubernetes.io/service-account-token   3      3h18m
    coredns-token-f4nfd                              kubernetes.io/service-account-token   3      3h18m
    ...

    // 指定某个secret
    $ kubectl -n kube-system get secret | grep aggregation-controller-token
    clusterrole-aggregation-controller-token-6mrrv   kubernetes.io/service-account-token   3      3h18m


.. code-block:: yaml
   :linenos:
   :emphasize-lines: 2,15


    // 查看clusterrole-aggregation-controller-token详情
    $ kubectl -n kube-system describe secret clusterrole-aggregation-controller-token-6mrrv
    #######
    Name:         clusterrole-aggregation-controller-token-6fzrv
    Namespace:    kube-system
    Labels:       <none>
    Annotations:  kubernetes.io/service-account.name: clusterrole-aggregation-controller
                  kubernetes.io/service-account.uid: e132b88c-efe2-11e8-b652-005056a0b094

    Type:  kubernetes.io/service-account-token
    Data
    ====
    ca.crt:     1025 bytes
    namespace:  11 bytes
    token:      eyJhbGciO...（太长了省略下）
    #######



附录
========


.. [1] https://yq.aliyun.com/articles/672970

.. [2] dashboard文件内容:

.. literalinclude:: /files/k8s/yamls/dashboard.yaml
   :language: yaml
   :linenos:






