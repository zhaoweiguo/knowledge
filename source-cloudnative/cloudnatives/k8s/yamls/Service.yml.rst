Service.yml
#################

默认spec.type为cluster-ip(只能内部用):

.. literalinclude:: /files/k8s/yamls/Service_Default.yml
   :language: yaml


spec.type为NodePort:

.. literalinclude:: /files/k8s/yamls/Service_NodePort.yml
   :language: yaml


spec.type为LoadBalancer:

.. literalinclude:: /files/k8s/yamls/Service_LoadBalancer.yml
   :language: yaml







