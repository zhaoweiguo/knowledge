docker export
#############



导出容器::

    $ docker container ls -a
    CONTAINER ID   IMAGE         COMMAND       CREATED        STATUS       PORTS    NAMES
    7691a814370e   ubuntu:14.04  "/bin/bash"   36 hours ago   Exited (0)            test

    # 这样将导出容器快照到本地文件
    $ docker export 7691a814370e > ubuntu.tar

