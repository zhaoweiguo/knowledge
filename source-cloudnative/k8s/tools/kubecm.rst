kubecm
######

* github [1]_
  
简介::

    管理你的 kubeconfig

.. note:: 该项目脱胎于 `mergeKubeConfig <https://github.com/sunny0826/mergeKubeConfig>`_ 项目，最早写该项目的目的是在一堆杂乱无章的 kubeconfig 中自由的切换。随着需要操作的 Kubernetes 集群越来越多，在不同的集群之间切换也越来越麻烦，而操作 Kubernetes 集群的本质不过是通过 kubeconfig 访问 Kubernetes 集群的 API Server，以操作 Kubernetes 的各种资源，而 kubeconfig 不过是一个 yaml 文件，用来保存访问集群的密钥，最早的 mergeKubeConfig 不过是一个操作 yaml 文件的 Python 脚本。而随着 golang 学习的深入，也就动了重写这个项目的念头，就这样 kubecm 诞生了。





下载
====

Homebrew::

    $ brew install sunny0826/tap/kubecm


binary::

    $ VERSION=0.8.0
    # linux x86_64
    $ curl -Lo kubecm.tar.gz https://github.com/sunny0826/kubecm/releases/download/v${VERSION}/kubecm_${VERSION}_Linux_x86_64.tar.gz
    # macos
    $ curl -Lo kubecm.tar.gz https://github.com/sunny0826/kubecm/releases/download/v${VERSION}/kubecm_${VERSION}_Darwin_x86_64.tar.gz
    # windows
    $ curl -Lo kubecm.tar.gz https://github.com/sunny0826/kubecm/releases/download/v${VERSION}/kubecm_${VERSION}_Windows_x86_64.tar.gz

Auto-Completion
===============

bash::

    # bash
    kubecm completion bash > ~/.kube/kubecm.bash.inc
    printf "
    # kubecm shell completion
    source '$HOME/.kube/kubecm.bash.inc'
    " >> $HOME/.bash_profile
    source $HOME/.bash_profile

zsh::

    # add to $HOME/.zshrc 
    source <(kubecm completion zsh)
    # or
    kubecm completion zsh > "${fpath[1]}/_kubecm"

使用
====

kubecm -h::

    Usage:
      kubecm [flags]
      kubecm [command]

    Available Commands:
      add         Merge configuration file with $HOME/.kube/config
      completion  Generates bash/zsh completion scripts
      delete      Delete the specified context from the kubeconfig
      help        Help about any command
      merge       Merge the kubeconfig files in the specified directory
      namespace   Switch or change namespace interactively
      rename      Rename the contexts of kubeconfig
      switch      Switch Kube Context interactively
      version     Print version info

    Flags:
          --config string   path of kubeconfig (default "$HOME/.kube/config")
      -h, --help   help for kubecm

add子命令::

    # Merge example.yaml with $HOME/.kube/config.yaml
    kubecm add -f example.yaml 

    # Merge example.yaml and name contexts test with $HOME/.kube/config.yaml
    kubecm add -f example.yaml -n test

    # Overwrite the original kubeconfig file
    kubecm add -f example.yaml -c

merge子命令::

    # Merge kubeconfig in the directory
    kubecm merge -f dir

    # Merge kubeconfig in the directory and overwrite the original kubeconfig file
    kubecm merge -f dir -c








.. [1] https://github.com/sunny0826/kubecm