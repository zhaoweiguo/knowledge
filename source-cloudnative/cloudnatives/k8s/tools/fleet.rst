fleet
#####

* github [1]_

::

    开源协议: Apache-2.0
    语言: Golang

项目作用::

    这个项目和 Rancher Labs 另一个受欢迎项目 k3s 有个千丝万缕的联系
    甚至 Fleet 可能就是就是为了管理众多 k3s 集群而生的，是 Rancher Labs 布局边缘计算和 IoT 领域的重要组成部分

安装::

    $ curl -sfL https://raw.githubusercontent.com/rancher/fleet/master/install.sh | sh -

部署控制平面::

    # 使用 CLI 工具将Fleet Manager部署到 Kubernetes 集群上
    # Kubeconfig should point to Manager cluster
    $ fleet install manager | kubectl apply -f -

生成 Cluster group token::

    控制平面部署好了，接下来部署agent目标集群
    下面命令生成一个 yaml 文件，内容包含 fleet 需要的 RBAC 权限和 fleet-agent 的 Deployment:
    $ fleet install agent-token > token.yml

目标集群注册::

    $ kubectl apply -f token.yml

部署 bundles::

    $ fleet apply ./examples/helm-kustomize

查看状态::

    查看所有集群 bundles 的状态了，这里可以看到 bundles 在多个集群都部署成功
    $ kubectl get fleet
    NAME                                   CLUSTER-COUNT   BUNDLES-READY   BUNDLES-DESIRED   STATUS
    clustergroup.fleet.cattle.io/default   2               3               4                 Modified: 1 (helm-kustomize )

    NAME                                    CLUSTERS-READY   CLUSTERS-DESIRED   STATUS
    bundle.fleet.cattle.io/fleet-agent      2                2
    bundle.fleet.cattle.io/helm-kustomize   1                2                  Modified: 1 (default-default-group/cluster-5a186072-acbd-4f54-8f22-fb1651ce902f )

名字来源::

    Fleet 不是 CoreOS 早已经停止维护的项目, 是Rancher Labs 新开的项目
    “我一直是它的忠实粉丝，将这一项目命名为 Fleet 也包含了我的私心。
        所以我希望重新使用 Fleet 这一名字，这是对这个非常出色的容器领域早期项目的致敬。
        同时，对于推动 Kubernetes 集群管理的演进，我们感到十分兴奋及万分期待。”
        ——Darren Shepherd 解释道
    顾名思义 Fleet 是“舰队”的意思，而 Kubernetes 在希腊语意为 “舵手”




但遗憾的是，目前 Fleet 还处于项目早期，实践也仅限于尝鲜体验，并不能用于生产环境，项目 README 中还专门提到了目前 Fleet 仅适用于 10 个集群以下的小规模部署。目前文档不足且项目维护人员并不积极，文档勘误的 RP 和相关 ISSUE 也没有得到相关的反馈。项目是做到了业界首个，但是要真正生产可用甚至做到业界第一还有很长的一段路要走。






.. [1] https://github.com/rancher/fleet