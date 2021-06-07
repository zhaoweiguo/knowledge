docker container
#######################

Usage::

    # containers管理
    docker container COMMAND



kill实例::

    $ docker container kill <hash>         # Force shutdown of the specified container


logs实例::

    $ docker container logs [container ID or NAMES]
    hello world


ls实例::

    $ docker container ls     // 列出全部运行的container
    CONTAINER ID         IMAGE     COMMAND      STATUS         PORTS             NAMES
    1fa450fe1843        grafana    "/run.sh"    Up 47 hours  3000->3000/tcp      grafana
    // 列出全部container
    $ docker container ls -a
    CONTAINER ID           IMAGE     COMMAND       STATUS       PORTS              NAMES
    1fa450fe1843        grafana     "/run.sh"    Up 47 hours  3000->3000/tcp      grafana
    6aa48b8ef586        influxdb   "/entrypoint"   Exited                        influxdb
    // 只列出container的ID
    $ docker container ls -a -q
    1fa450fe1843
    6aa48b8ef586

prune实例::

    # 清理所有处于终止状态的容器
    $ docker container prune

rm实例::

    # 删除容器
    $ docker container rm  trusting_newton

    $ docker container rm <hash>        # Remove specified container from this machine
    $ docker container rm $(docker container ls -a -q)         # Remove all containers


stop实例::

    # 终止一个运行中的容器
    $ docker container stop <hash>           # Gracefully stop the specified container





Commands::

    attach      Attach local standard input, output, and error streams to a running container
    commit      Create a new image from a container's changes
    cp          Copy files/folders between a container and the local filesystem
    create      Create a new container
    diff        Inspect changes to files or directories on a container's filesystem
    exec        Run a command in a running container
    export      Export a container's filesystem as a tar archive
    inspect     Display detailed information on one or more containers
    kill        Kill one or more running containers
    logs        Fetch the logs of a container
    ls          List containers
    pause       Pause all processes within one or more containers
    port        List port mappings or a specific mapping for the container
    prune       Remove all stopped containers
    rename      Rename a container
    restart     Restart one or more containers
    rm          Remove one or more containers
    run         Run a command in a new container
    start       Start one or more stopped containers
    stats       Display a live stream of container(s) resource usage statistics
    stop        Stop one or more running containers
    top         Display the running processes of a container
    unpause     Unpause all processes within one or more containers
    update      Update configuration of one or more containers
    wait        Block until one or more containers stop, then print their exit codes





