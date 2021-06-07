kubectl port-forward
############################

Usage::

    kubectl port-forward TYPE/NAME [LOCAL_PORT:]REMOTE_PORT [...[LOCAL_PORT_N:]REMOTE_PORT_N] [options]


实例::

    kubectl port-forward <podName> 80:8080

    // 把此pod下的5000端口映射到本地
    $ kubectl port-forward webapp-deployment-7946f7db77-gtsbg 5000:5000









