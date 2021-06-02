安装配置kubectl [1]_
####################

安装
=====

安装最新版::

    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

安装v1.16.0版::

    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl

ubuntu,debian包安装::

    sudo apt-get update && sudo apt-get install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl

CentOS安装::

    cat <<EOF > /etc/yum.repos.d/kubernetes.repo
    [kubernetes]
    name=Kubernetes
    baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    EOF
    yum install -y kubectl

自动补全
========

bash
-------
安装bash-completion::

    apt-get install bash-completion 
    or
    yum install bash-completion

Enable kubectl autocompletion::

    echo 'source <(kubectl completion bash)' >>~/.bashrc

Add the completion script to the /etc/bash_completion.d directory::

    kubectl completion bash >/etc/bash_completion.d/kubectl

如果对kubectl使用了alias::

    echo 'alias k=kubectl' >>~/.bashrc
    echo 'complete -F __start_kubectl k' >>~/.bashrc

zsh
---

在文件~/.zshrc file中增加如下::

    source <(kubectl completion zsh)

如果对kubectl使用了alias::

    echo 'alias k=kubectl' >>~/.zshrc
    echo 'complete -F __start_kubectl k' >>~/.zshrc

出现 ``complete:13: command not found: compdef`` 问题::

    // 在最前面加:
    autoload -Uz compinit
    compinit



.. [1] https://kubernetes.io/docs/tasks/tools/install-kubectl/