Defining custom API objects
###########################

创建CRD及实例
=============

创建CustomResourceDefinition类型websites:

.. literalinclude:: /files/k8s/yamls/CustomResourceDefinition.yaml
   :language: yaml


使用新的CRD创建websites实例:

.. literalinclude:: /files/k8s/yamls/CustomResourceDefinition_usage.yaml
   :language: yaml

查看::

    $ kubectl get websites
    $ kubectl get website kubia -o yaml
    $ kubectl delete website kubia


让创建的CRD真正生效
===================

现在所有都已经创建成功，其实只是在api server(或etcd里面有相关数据，没有任何执行效果)


创建sa和clusterrolebinding::

    $ kubectl create serviceaccount website-controller
    $ kubectl create clusterrolebinding website-controller --clusterrole=cluster-admin --serviceaccount=default:website-controller


.. literalinclude:: /files/k8s/yamls/usage_kubeproxy.yaml
   :language: yaml

注: 这儿的image(luksa/website-controller)来自项目 [1]_



出现如下界面说明成功了::

    2020/02/21 06:13:08 Received watch event: ADDED: kubia: https://github.com/luksa/kubia-website-example.git
    2020/02/21 06:13:08 Creating services with name kubia-website in namespace default
    2020/02/21 06:13:08 response Status: 201 Created
    2020/02/21 06:13:08 Creating deployments with name kubia-website in namespace default
    2020/02/21 06:13:08 response Status: 201 Created
    2020/02/21 06:14:52 Received watch event: ADDED: kubia: https://github.com/luksa/kubia-website-example.git
    2020/02/21 06:14:52 Creating services with name kubia-website in namespace default

查看相关资源::

    $kubectl get deploy,svc,po
    NAME                                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    deployment.extensions/kubia-website        1         1         1            1           26m
    deployment.extensions/website-controller   1         1         1            1           32m

    NAME                     TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)           AGE
    service/kubia-website    NodePort   172.21.10.42   <none>        80:30679/TCP      26m

    NAME                                          READY     STATUS    RESTARTS   AGE
    pod/kubia-website-5f5db45877-gmfq7            2/2       Running   0          26m
    pod/website-controller-79cb49db46-j7bt4       2/2       Running   1          32m








.. [1] https://github.com/luksa/k8s-website-controller
