hostPort选项
############


.. note:: hostPort与NodePort的区别是：如下图所示，NodePort服务是把请求转发到随机的一个运行的Pod上，而hostPort是直接转发到本Node上的指定Pod。

.. image:: /images/k8s/option_hostPort_vs_nodePort.png

.. note:: 一个Node只能启动一个hostPort，所以最初是用于把服务DaemonSets部署到每个Node(确保一个Node只有一个hostPort)。如下图所示，如一3个Node上部署4个带hostPort的Pod，会有一个不成功。

.. image:: /images/k8s/option_hostPort_vs_nodePort2.png


下面这个实例, 展示了可以使用8080端口访问指定Node的此服务，也可以使用9000端口访问随机Node上的此服务。

.. literalinclude:: /files/k8s/yamls/option_hostPort.yaml
   :language: yaml






