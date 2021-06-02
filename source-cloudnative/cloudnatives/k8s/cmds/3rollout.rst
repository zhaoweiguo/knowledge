kubectl rollout
#####################

Usage::

    kubectl rollout SUBCOMMAND [options]

Available Commands::

    history     View rollout history
    pause       Mark the provided resource as paused
    resume      Resume a paused resource
    status      Show the status of the rollout
    undo        Undo a previous rollout
    [新]restart     v1.15版本才有

Examples::

    # Rollback to the previous deployment
    kubectl rollout undo deployment/abc

    # Check the rollout status of a daemonset
    kubectl rollout status daemonset/foo

实例::

    # 查看操作历史
    $> kubectl rollout history deployment/nginx-deployment
    # 查看当前状态
    $> kubectl rollout status deployment/nginx-deployment
    // 回退到上一版本
    $> kubectl rollout undo deployment/nginx-deployment 
    // 回退到指定版本
    $> kubectl rollout undo deployment/nginx-deployment --to-revision=2 
    // 暂停deployment升级
    $> kubectl rollout pause deployment/nginx-deployment 
    // 恢复deployment升级
    $> kubectl rollout resume deploy/nginx-deployment 


    // 重新启动 Deployment:
    注: v1.15版新增的restart子命令
    $ kubectl rollout restart deployment -n NAMESPACE













