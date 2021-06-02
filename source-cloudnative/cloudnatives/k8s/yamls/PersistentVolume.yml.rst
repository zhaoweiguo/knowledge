PersistentVolume
#########################

创建持久卷
==========

.. literalinclude:: /files/k8s/yamls/PersistentVolume0.yml
   :language: yaml
   :linenos:
   :emphasize-lines: 21

创建持久卷声明
==============

.. literalinclude:: /files/k8s/yamls/PersistentVolumeClaim0.yml
   :language: yaml
   :linenos:


被声明后
==============

pvc:

.. literalinclude:: /files/k8s/yamls/PersistentVolumeClaim1.yml
   :language: yaml
   :linenos:
   :emphasize-lines: 7, 19-20

pv:

.. literalinclude:: /files/k8s/yamls/PersistentVolume1.yml
   :language: yaml
   :linenos:
   :emphasize-lines: 4-5, 29



.. note:: pv 不指定 ns, 但 pvc 需要指定 ns




实操::

    1. 直接删除pv(注: 需要先删除 pvc)
    $ kubectl delete pv d-2z1   # 执行很长时间但没反应
    $ kubectl get pv   # d-2z1的STATUS变为Terminating
    NAME   CAPACITY   MODES  RECLAIM POLICY   STATUS         CLAIM           STORAGECLASS
    d-2z1   20Gi       RWO      Delete       Terminating   default/nameB1  alicloud-disk-ssd
    d-2z2   20Gi       RWO      Delete         Bound       default/nameB0  alicloud-disk-ssd
    d-2z3   20Gi       RWO      Delete         Bound       default/name0   alicloud-disk-ssd 
    d-2z4   20Gi       RWO      Delete         Bound       default/name1   alicloud-disk-ssd 
    d-2z5   20Gi       RWO      Retain         Bound       default/nameA0       disk              

    $> kubectl get pvc
    NAME    STATUS    VOLUME  CAPACITY   ACCESS MODES   STORAGECLASS
    name0   Bound     d-2z1   20Gi       RWO            alicloud-disk-ssd
    name1   Bound     d-2z2   20Gi       RWO            alicloud-disk-ssd
    nameB0  Bound     d-2z3   20Gi       RWO            alicloud-disk-ssd
    nameB1  Bound     d-2z4   20Gi       RWO            alicloud-disk-ssd
    nameA0  Bound     d-2z5   20Gi       RWO            disk

    2. 删除pv的RECLAIM POLICY为Delete的pvc
    $> kubectl delete pvc name0
    $> kubectl delete pvc name1
    $> kubectl get pvc  # pvc删除成功
    NAME    STATUS    VOLUME  CAPACITY   ACCESS MODES   STORAGECLASS
    nameB0   Bound     d-2z3   20Gi       RWO            alicloud-disk-ssd
    nameB1   Bound     d-2z4   20Gi       RWO            alicloud-disk-ssd
    nameA0   Bound     d-2z5   20Gi       RWO            disk
    $ kubectl get pv   # pv也同步删除成功（同步阿里云盘也删除成功）
    NAME   CAPACITY   MODES  RECLAIM POLICY   STATUS         CLAIM           STORAGECLASS
    d-2z3   20Gi       RWO      Delete         Bound       default/name0   alicloud-disk-ssd 
    d-2z4   20Gi       RWO      Delete         Bound       default/name1   alicloud-disk-ssd 
    d-2z5   20Gi       RWO      Retain         Bound       default/nameA0       disk 


    3. 删除pv的RECLAIM POLICY为Retain的pvc
    $> kubectl delete pvc nameA0
    $> kubectl get pvc  # pvc删除成功
    NAME    STATUS    VOLUME  CAPACITY   ACCESS MODES   STORAGECLASS
    name0   Bound     d-2z3   20Gi       RWO            alicloud-disk-ssd
    name1   Bound     d-2z4   20Gi       RWO            alicloud-disk-ssd
    $ kubectl get pv   # pv没有被删除而是置为Released
    NAME   CAPACITY   MODES  RECLAIM POLICY   STATUS         CLAIM           STORAGECLASS
    d-2z3   20Gi       RWO      Delete         Bound       default/name0   alicloud-disk-ssd 
    d-2z4   20Gi       RWO      Delete         Bound       default/name1   alicloud-disk-ssd 
    d-2z5   20Gi       RWO      Retain         Released       default/nameA0       disk 

    4. 手工指定删除pv
    $> kubectl delete pv d-2z5
    $ kubectl get pv （同步阿里云盘未删除，需要手工删除）
    NAME   CAPACITY   MODES  RECLAIM POLICY   STATUS         CLAIM           STORAGECLASS
    d-2z3   20Gi       RWO      Delete         Bound       default/name0   alicloud-disk-ssd
    d-2z4   20Gi       RWO      Delete         Bound       default/name1   alicloud-disk-ssd







