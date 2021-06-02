docker rm
################


Usage::

    // 移除containers
    // Remove one or more containers
    docker rm [OPTIONS] CONTAINER [CONTAINER...]


Options::

    -f, --force     Force the removal of a running container (uses SIGKILL)
    -l, --link      Remove the specified link
    -v, --volumes   Remove the volumes associated with the container

实例::

    $ docker rm container1
    # 一次删除2个
    $ docker rm container2 container3

配合docker image ls 命令::

    # 删除所有仓库名为 redis 的镜像：
    $ docker image rm $(docker image ls -q redis)
    # 删除所有在 mongo:3.2 之前的镜像：
    $ docker image rm $(docker image ls -q -f before=mongo:3.2)



