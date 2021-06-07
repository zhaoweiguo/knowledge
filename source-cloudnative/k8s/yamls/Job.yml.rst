Job.yml
###########



Job实例:

.. literalinclude:: /files/k8s/yamls/Job.yml
   :language: yaml

.spec.ttlSecondsAfterFinished
=============================

以下是设置 Job 的 .spec.ttlSecondsAfterFinished 字段的一些示例::

    1. 在资源清单（manifest）中指定此字段，以便 Job 在完成后的某个时间被自动清除
    2. 将此字段设置为存在的、已完成的资源，以采用此新功能
    3. 在创建资源时使用 mutating admission webhook 动态设置该字段
       集群管理员可以使用它对完成的资源强制执行 TTL 策略
    4. 使用 mutating admission webhook 在资源完成后动态设置该字段
       并根据资源状态、标签等选择不同的 TTL 值




