docker image
##################

Usage::
  
    # 管理images
    docker image COMMAND

ls实例::

    // 查看镜像
    $ docker image ls   # 等同于docker images


prune实例::

    // 删除无用镜像
    $ docker image prune
    WARNING! This will remove all dangling images.
    Are you sure you want to continue? [y/N] y
    Deleted Images:
    untagged: registry.cn-beijing.aliyuncs.com/zhaoweiguo/tool_notice@sha256:137e97e61c8dde9c7e053a54cbf320209fdf0fc6314e3e01bf55943058410f06
    deleted: sha256:cb332b0cbee0b67a50d73ca97492d49128eccc21d0475b167b071226a7825d98
    deleted: sha256:73ac8c66cd64c7119b6237247fe194c5dc951815292ccb520b558544470e0519
    deleted: sha256:38e4ccf0bdf9cd4f8d8a42daab44a70249ea6916f2d2f2dd1f4331726a255c10
    deleted: sha256:14723b5ee7fe55baa24de1d64cdbe61b011b5de539150fe83fe1617a9c708ef1
    deleted: sha256:4564ce843578b149a403959b4a526b08e0ec38564c78d97011203577bf8b4c10

    Total reclaimed space: 19.57MB


rm实例::

    $ docker image rm 127.0.0.1:5000/ubuntu:latest


Commands::

    build       Build an image from a Dockerfile
    history     Show the history of an image
    import      Import the contents from a tarball to create a filesystem image
    inspect     Display detailed information on one or more images
    load        Load an image from a tar archive or STDIN
    ls          List images
    prune       Remove unused images
    pull        Pull an image or a repository from a registry
    push        Push an image or a repository to a registry
    rm          Remove one or more images
    save        Save one or more images to a tar archive (streamed to STDOUT by default)
    tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE




