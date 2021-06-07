docker cp命令
#############

Usage::

    docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
    docker cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH

说明::

    Copy files/folders between a container and the local filesystem

Options::

    -a, --archive       Archive mode (copy all uid/gid information)
    -L, --follow-link   Always follow symbol link in SRC_PATH

实例::

    $ docker cp e65000ded291:/ali-log-service .







