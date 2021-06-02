k9s
###

* github: https://github.com/derailed/k9s
* 官网: https://k9scli.io

Installation::

    $ brew install derailed/k9s/k9s
    $ go get -u github.com/derailed/k9s
    $ docker run --rm -it -v $KUBECONFIG:/root/.kube/config quay.io/derailed/k9s

常用快捷键::

    /           查询
    :           切换资源类型，如pod -> service
    其他快捷键详见界面

命令::

    # List all available CLI options
    k9s help
    # To get info about K9s runtime (logs, configs, etc..)
    k9s info
    # 指定ns
    k9s -n mycoolns
    # Start K9s in an existing KubeConfig context
    k9s --context coolCtx
    # Start K9s in readonly mode - with all modification commands disabled
    k9s --readonly

Logs::

    k9s info
    # Will produces something like this
    #  ____  __.________
    # |    |/ _/   __   \______
    # |      < \____    /  ___/
    # |    |  \   /    /\___ \
    # |____|__ \ /____//____  >
    #         \/            \/
    #
    # Configuration:   /Users/fernand/.k9s/config.yml
    # Logs:            /var/folders/8c/hh6rqbgs5nx_c_8k9_17ghfh0000gn/T/k9s-fernand.log
    # Screen Dumps:    /var/folders/8c/hh6rqbgs5nx_c_8k9_17ghfh0000gn/T/k9s-screens-fernand

    # To view k9s logs
    tail -f /var/folders/8c/hh6rqbgs5nx_c_8k9_17ghfh0000gn/T/k9s-fernand.log

    # Start K9s in debug mode
    k9s -l debug










