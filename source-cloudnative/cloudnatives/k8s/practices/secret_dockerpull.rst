*********************
私有仓库拉取镜像 [1]_
*********************

目的::

    从私有docker仓库拉取镜像，部署pod

.. note:: 阿里本帐号的k8s集群使用本帐号下的私有镜像库有更方便的办法，具体参考ali相关资料

创建Secret
==========

命令行::

    // k8s集群使用类型为docker-registry
    $ kubectl -n goweb create secret docker-registry <registry-key> \
    --docker-server=registry.cn-beijing.aliyuncs.com \
    --docker-username=zhaoweiguo \
    --docker-password=<your-pword> \
    --docker-email=xxxx@163.com
    // 查看
    $ kubectl get secret
    NAME                  TYPE                                  DATA      AGE
    <registry-key>    kubernetes.io/dockerconfigjson             1         29s

通过secret yaml文件创建pull image所用的secret::

    // 注: 不知道是不是版本, 现在~/.docker/config.json里面没有相关密钥信息了
    // 所以此方法好像不可用了
    apiVersion: v1
    kind: Secret
    metadata:
      name: <registry-key2>
      namespace: default
    data:
        .dockerconfigjson: {base64 -w 0 ~/.docker/config.json}
    type: kubernetes.io/dockerconfigjson

    # 查看
    NAME                  TYPE                                  DATA      AGE
    <registry-key>     kubernetes.io/dockerconfigjson             1         2h
    <registry-key2>      kubernetes.io/dockercfg                  1         1h



使用
====

::

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: anlysis-web-deploy
      namespace: goweb
    spec:
      selector:
        matchLabels:
          app: anlysis-web
      replicas: 2
      template:
        metadata:
          labels:
            app: anlysis-web
        spec:
          imagePullSecrets:
            - name: <registry-key>
          containers:
            - name: anlysis-web
              image: registry.cn-beijing.aliyuncs.com/xxxxxxxx/analysis-backend:v3
              command: ["/analysis-backend"]

如果一个pod的2个container来自两个不同的私有仓库::

    // 可以一次指定2个secret来解决此问题
    imagePullSecrets:
    - name: registrykey-m2-1
    - name: registrykey-m2-2












.. [1] https://help.aliyun.com/document_detail/86307.html
