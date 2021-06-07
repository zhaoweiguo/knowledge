DaemonSet
#########

实例-阿里日志:

.. literalinclude:: /files/k8s/yamls/DaemonSet.yaml
   :language: yaml


.. note:: 最主要特征: 一台 node 一个 DaemonSet



DaemonSet 更新策略::

    1. nDelete: 
        使用 OnDelete 更新策略时，在更新 DaemonSet 模板后
          只有当你手动删除老的 DaemonSet pods 之后，新的 DaemonSet Pod 才会被自动创建。
        跟 Kubernetes 1.6 以前的版本类似。
    2. RollingUpdate: 
        这是默认的更新策略。
        使用 RollingUpdate 更新策略时，在更新 DaemonSet 模板后
          老的 DaemonSet pods 将被终止，并且将以受控方式自动创建新的 DaemonSet pods
        更新期间，最多只能有 DaemonSet 的一个 Pod 运行于每个节点上






