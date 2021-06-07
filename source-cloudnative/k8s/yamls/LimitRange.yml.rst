.. _limitRange.yml:

LimitRange.yml
###############


相关参考: :ref:`ResourceQuota<ResourceQuota_yaml>`

说明::

    cpu: 500m   // 500 millicpus
    等同
    cpu: "0.5"


LimitRange是namespace级别的, 即在namespace中有一个LimitRange, 则此namespace下创建pod时会自动加上LimitRange上的限制。

.. literalinclude:: /files/k8s/yamls/LimitRange.yaml
   :language: yaml


QoS等级
=======

Guaranteed::

    优先级最高
    设备request和limit并设置相等 --> QoS=Guaranteed

BestEffort::

    优先级最低
    未设置request和limit --> QoS=BestEffort

Burstable::

    其他情况   --> QoS=Burstable

内存不足时哪个进程会被杀死::

    BestEffort -> Burstable -> Guaranteed

.. image:: /images/k8s/LimitRangeQoS.png










