docker pull
################

Usage::

    # Pull an image or a repository from a registry
    docker pull [OPTIONS] NAME[:TAG|@DIGEST]


Options::

    -a, --all-tags                Download all tagged images in the repository
        --disable-content-trust   Skip image verification (default true)

实例::

    // 获取一个新的images
    $ docker pull centos

    $ docker pull registry.cn-beijing.aliyuncs.com/gordon-test/gordondemo:v1



