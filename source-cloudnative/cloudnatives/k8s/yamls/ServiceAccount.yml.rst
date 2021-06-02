.. _ServiceAccount_yaml:

ServiceAccount.yaml
###################



.. literalinclude:: /files/k8s/yamls/ServiceAccount.yaml
   :language: yaml

创建sa和clusterrolebinding::

    $ kubectl create serviceaccount website-controller
    $ kubectl create clusterrolebinding website-controller --clusterrole=cluster-admin \
      --serviceaccount=default:website-controller






