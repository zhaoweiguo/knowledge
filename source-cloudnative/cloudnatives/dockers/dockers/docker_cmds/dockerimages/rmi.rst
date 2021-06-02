docker rmi
###############

Usage::

    // Remove one or more images
    docker rmi [OPTIONS] IMAGE [IMAGE...]

Options::

    -f, --force      Force removal of the image
        --no-prune   Do not delete untagged parents
 
实例::

    // 删除images
    $ docker rmi training/sinatra

    // 删除本地的所有镜像可以像这样
    # docker rmi `docker images -a -q`
    // 如果有多个镜像有相同的image id则要使用-f强制删除
    # docker rmi `docker images -a -q`







