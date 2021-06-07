NetworkPolicy.yaml
##################

Enabling network isolation in a namespace
=========================================

默认拒绝

.. literalinclude:: /files/k8s/yamls/NetworkPolicy_default_deny.yaml
   :language: yaml

Allowing only some pods in the namespace to connect to a server pod
===================================================================

podSelector指定lable可连接:The NetworkPolicy allows pods with the app=webserver label to connect to pods with the app=database label, and only on port 5432。

.. literalinclude:: /files/k8s/yamls/NetworkPolicy_pod.yaml
   :language: yaml


.. image:: /images/k8s/networkpolicy_pod.png

Isolating the network between Kubernetes namespaces
===================================================

namespaceSelector指定lable可连接，This NetworkPolicy ensures only pods running in namespaces labeled as tenant:
manning can access their Shopping Cart microservice

.. literalinclude:: /files/k8s/yamls/NetworkPolicy_namespace.yaml
   :language: yaml

.. image:: /images/k8s/networkpolicy_namespace.png


Isolating using CIDR notation
=============================

allow the shopping-cart pods to only be accessible from IPs in the 192.168.1.1 to .255 range::

    ingress: 
    - from:
      - ipBlock:
          cidr: 192.168.1.0/24

Limiting the outbound traffic of a set of pods
==============================================

allows pods that have the app=webserver label to only access pods that have the app=database label::

    spec:
      podSelector:
        matchLabels:
          app: webserver
      egress: 
      - to:
        - podSelector: 
            matchLabels:
              app: database










