Kustomize
###############

* github [1]_
* 官网 [2]_

* kubectl1.14使用Kustomize2.0.3
* kubernetes 1.14 发布时候，它被集成到 kubectl 中，成为了一个子命令
* Kustomize 允许用户以一个应用描述文件 （YAML 文件）为基础（Base YAML），然后通过 Overlay 的方式生成最终部署应用所需的描述文件，而不是像 Helm 那样只提供应用描述文件模板，然后通过字符替换（Templating）的方式来进行定制化。——张磊
* Kustomize introduces a template-free way to customize application configuration that simplifies the use of off-the-shelf applications. Now, built into kubectl as apply -k.


安装 [3]_
=========

二进制安装::

    $ curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" -o install_kustomize.sh
    $ cat install_kustomize.sh | bash

Go安装::

    $ GO111MODULE=on go install sigs.k8s.io/kustomize/kustomize/v3
    // 安装指定版本
    $ GO111MODULE=on go get sigs.k8s.io/kustomize/kustomize/v3@v3.3.0

Mac安装::
  
    $ brew install kustomize

检测::

    $ kustomize version

实例1: 简单使用
===============

* 实例地址: https://github.com/zhaoweiguo/demo-go/tree/master/k8s/kustomize/helloWorld/base

命令::

    $ cd demo-go/tree/master/k8s
    $ DEMO_HOME=./kustomize/helloWorld
    $ BASE=$DEMO_HOME/base
    $ cp $BASE/kustomization_base.yaml $BASE/kustomization.yaml

    $ kustomize build $BASE

修改commonLabels查看效果::

    $ sed -i.bak 's/app: hello/app: my-hello/' $BASE/kustomization.yaml
    看效果:
    $ kustomize build $BASE | grep -C 3 app:

实例2: Overlays使用
===================

* 实例地址: https://github.com/zhaoweiguo/demo-go/tree/master/k8s/kustomize/helloWorld/overlays

包含 staging 和 production 的 overlay::

    Staging 包含生产环境中无法应用的带有风险的功能
    Production 包含更多的副本数

指定overlays目录::

    $ OVERLAYS=$DEMO_HOME/overlays

生成staging::

    $ kustomize build $OVERLAYS/staging

生成production版::

    $ kustomize build $OVERLAYS/production

直接比较 staging 和 production 输出的不同::

    diff \
      <(kustomize build $OVERLAYS/staging) \
      <(kustomize build $OVERLAYS/production) |\
      more

部署::

    $ kustomize build $OVERLAYS/staging | kubectl apply -f -
    $ kustomize build $OVERLAYS/production | kubectl apply -f -

    // 使用 kubectl(v1.14.0 以上版本):
    $ kubectl apply -k $OVERLAYS/staging
    $ kubectl apply -k $OVERLAYS/production

其他实例
========

实例1::

    $ kustomize edit set image {your-docker-registry}:${DRONE_BUILD_NUMBER} 



参考
====

* `郭旭东x——1什么是Kustomize <https://developer.aliyun.com/article/699126>`_




.. [1] https://github.com/kubernetes-sigs/kustomize
.. [2] https://kustomize.io/
.. [3] https://github.com/kubernetes-sigs/kustomize/blob/master/docs/INSTALL.md