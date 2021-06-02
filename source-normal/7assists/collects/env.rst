环境变量
########

个人::

    alias proxy='export all_proxy=socks5://127.0.0.1:1086;export ALL_PROXY=$all_proxy'
    alias unproxy='unset all_proxy;unset ALL_PROXY'
    alias httpproxy='export http_proxy=127.0.0.1:1087;export https_proxy=$http_proxy;export HTTP_PROXY=$http_proxy;export HTTPS_PROXY=$http_proxy'
    alias unhttpproxy='unset http_proxy;unset https_proxy;unset HTTP_PROXY;unset HTTPS_PROXY'
    alias proxyget='echo "httpproxy:";echo $http_proxy;echo $https_proxy;echo $HTTP_PROXY;echo $HTTPS_PROXY;echo "all_proxy:";echo $all_proxy;echo $ALL_PR


    alias kali='export KUBECONFIG=~/.kube/ali.config'
    alias unkube='unset KUBECONFIG'
    alias kget='echo $KUBECONFIG'

Linux::

    $ echo $SHELL
    /bin/zsh

    // HISTSIZE is the maximum number of lines that are kept in a session
    $ echo $SAVEHIST
    10000
    // SAVEHIST is the maximum number of lines that are kept in the history file. 
    $ echo $HISTFILE
    /Users/zhaoweiguo/.zsh_history
    // HISTFILE is the file name where your system is saving history.
    $ echo $HISTSIZE
    50000


Golang::

    export GOROOT=$HOME/sdk/go
    export GOPATH=$HOME/9tool/go
    export GO111MODULE=on
    export GOPROXY=https://goproxy.cn,direct
    export GOSUMDB=sum.golang.google.cn
    export GOPRIVATE=gitcodecloud.com.cn

Java::

    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

oh-my-zsh::

    $ echo $ZSH
    /Users/zhaoweiguo/.oh-my-zsh
    $ echo $ZSH_CUSTOM
    /Users/zhaoweiguo/.oh-my-zsh/custom








