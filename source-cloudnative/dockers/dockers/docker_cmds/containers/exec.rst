docker exec
###################

Usage::

    // 在一运行的容器内运行一个命令
    // Run a command in a running container
    docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

实例::

    // 缺少i: 无法输入任何命令
    // 缺少t: 命令提示符不会显示,且一些命令会提示TERM变量没有设置
    $ docker exec -it gordon-container bash

    // 以root用户操作
    $ docker exec -u root -it gordon-container bash

    // 不必进入容器，让dokcer执行指定命令
    docker exec -it xxxxx echo "hello world"


Options::

    -d, --detach               Detached mode: run command in the background
        --detach-keys string   Override the key sequence for detaching a container
    -e, --env list             Set environment variables
    -i, --interactive          Keep STDIN open even if not attached
        --privileged           Give extended privileges to the command
    -t, --tty                  Allocate a pseudo-TTY
    -u, --user string          Username or UID (format: <name|uid>[:<group|gid>])
    -w, --workdir string       Working directory inside the container










