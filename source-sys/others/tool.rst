通用工具类
#############


自动补全
==============

安装::

    // mac版
    $ brew install bash-completion

使用::

    // 把下面一句加入到.bash_profile中
    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

git补全::

    $ cd /usr/local/homebrew/opt/bash-completion/etc/bash_completion.d
    $ curl -L -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
    $ brew unlink bash-completion
    $ brew link bash-completion

k8s实例::

    要把下面这一句加入到.bash_profile中
    source <(kubectl completion bash)

    // 如果把kubectl简写为k
    alias k=kubectl
    // 那么需要使用下面这句(mac下不生效)
    source <(kubectl completion bash | sed s/kubectl/k/g)

docker实例::

    $ cd /usr/local/homebrew/opt/bash-completion/etc/bash_completion.d
    $ ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
    $ ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion
    $ ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
    $ brew unlink bash-completion
    $ brew link bash-completion











