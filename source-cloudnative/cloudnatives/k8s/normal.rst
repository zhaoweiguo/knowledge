kube基本
#############

* 官网文档 [1]_
* Borg论文 [2]_
* 官网 [3]_

.. toctree::
   :maxdepth: 1

   normals/install
   normals/volume
   normals/concept
   normals/principle
   normals/cluster_testing
   normals/introduce
   normals/svc_catalog
   normals/cAdvisor


k8s的一个目标是设计功能来帮助应用完全感觉不到k8s的存在，因此让应用与api服务器通信的设计是不允许的

.. image:: /images/k8s/k8s-singlenode-docker.png





.. [1] http://docs.kubernetes.org.cn/
.. [2] https://ai.google/research/pubs/pub43438
.. [3] https://kubernetes.io/