docker commit
###################

Usage::

    // Create a new image from a container's changes
    docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]

Options::

    -a, --author string    Author (e.g., "John Hannibal Smith <hannibal@a-team.com>")
    -c, --change list      Apply Dockerfile instruction to the created image
    -m, --message string   Commit message
    -p, --pause            Pause container during commit (default true)

.. warning:: 慎用 docker commit。使用 docker commit 命令虽然可以比较直观的帮助理解镜像分层存储的概念，但是实际环境中并不会这样使用。



实例::

    // 提交commit: -m: 消息内容, -a: 提交者
    $ docker commit -m="Added json gem" -a="Kate Smith" 0b2616b0e5a8 zhaoweiguo/sinatra:v2


    $ docker commit \
        --author "zhaoweiguo <xxxxx@gmail.com>" \
        --message "update" \
        webserver \
        nginx:v2
    sha256:07e33465974800ce65751acc279adc6ed2dc5ed4e0838f8b86f0c87aa1795214





