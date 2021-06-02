kubectl config
#####################

Usage::

    $ kubectl config SUBCOMMAND [options]

    $ kubectl config set-context NAME [--cluster=cluster_nickname] [--user=user_nickname] [--namespace=namespace] [options]

kubeconfig文件::

    目录: ~/.kube/config
    由4部分组成:
    1. 集群列表
    2. 用户列表
    3. 上下文列表
    4. 当前上下文名称

实例::

    # 获取当前上下文
    $ kubectl config current-context
    # 列出集群
    $ kubectl config get-clusters
    # 列出上下文
    $ kubectl config get-contexts
    $ kubectl config view

    # 添加/修改一个集群(本质是修改~/.kube/config文件内容)
    $ kubectl config set-cluster <clusterName> --server=https://k8s.example.com:6443 --certificate-authority=<path/to/cafile>

    # 添加/修改用户凭据
    1. 使用用户名、密码
    $ kubectl config set-credentials <name> --username=<userName> --password=<pwd>
    2. 使用token
    $ kubectl config set-credentials <name> --token=<token>

    # 切换上下文
    $ kubectl config use-context <contextName>

    # 切换namespace(可设置别名 alias kcd=`xxxx`)
    $ kubectl config set-context $(kubectl config current-context) --namespace <nsName>
    $ kubectl config set-context minikube --namespace=<nsName>

    # 创建上下文并将集群和用户凭据联系到一起
    $ kubectl config set-context --cluster<clusterName> --user=<userName> --namespace=<nsName>

    # 删除上下文
    $ kubectl config delete-context <contextName>
    # 删除集群
    $ kubectl config delete-cluster <clusterName>

SUBCOMMAND::

    current-context Displays the current-context
    delete-cluster  Delete the specified cluster from the kubeconfig
    delete-context  Delete the specified context from the kubeconfig
    get-clusters    Display clusters defined in the kubeconfig
    get-contexts    Describe one or many contexts
    rename-context  Renames a context from the kubeconfig file.
    set             Sets an individual value in a kubeconfig file
    set-cluster     Sets a cluster entry in kubeconfig
    set-context     Sets a context entry in kubeconfig
    set-credentials Sets a user entry in kubeconfig
    unset           Unsets an individual value in a kubeconfig file
    use-context     Sets the current-context in a kubeconfig file
    view            Display merged kubeconfig settings or a specified kubeconfig file








