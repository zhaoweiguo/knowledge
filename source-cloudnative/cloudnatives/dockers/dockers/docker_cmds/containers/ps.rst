docker ps
##############

Usage::
    
    // 列出container列表
    docker ps [OPTIONS]

实例::

    # 查看docker的进程(只能查看running的进程)
    $ docker ps
    CONTAINER ID  IMAGE         COMMAND         CREATED        STATUS       PORTS NAMES
    1e5535038e28  ubuntu:14.04  /bin/sh -c..  2 minutes ago  Up 1 minute        insane_babbage



Options::

    -a, --all             Show all containers (default shows just running)
    -f, --filter filter   Filter output based on conditions provided
        --format string   Pretty-print containers using a Go template
    -n, --last int        Show n last created containers (includes all states) (default -1)
    -l, --latest          Show the latest created container (includes all states)
        --no-trunc        Don't truncate output
    -q, --quiet           Only display numeric IDs
    -s, --size            Display total file sizes

实例::

    // -l: latest,最近的container
    $ sudo docker ps -l






