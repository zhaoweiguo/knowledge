.. _ResourceQuota_yaml:

ResourceQuota.yaml
##################

相关参考: :ref:`limitRange<limitRange.yml>`

.. literalinclude:: /files/k8s/yamls/ResourceQuota.yaml
   :language: yaml



ResourceQuota是namespace级别的, 即在namespace中有一个ResourceQuota, 则此namespace下面的所有pod都受此限制。LimitRange与ResourceQuota的不同:

.. image:: /images/k8s/LimitRange_vs_ResourceQuota.png





