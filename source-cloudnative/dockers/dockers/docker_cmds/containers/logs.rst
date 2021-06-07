docker logs
##################

Usage::

    // Fetch the logs of a container
    docker logs [OPTIONS] CONTAINER



实例::


    # 查看日志
    docker logs <containerName>
    $ docker logs insane_babbage   # insane_babbage是上面ps的names
    or
    $ docker logs 1e5535038e28   # 1e5535038e28是上面ps的CONTAINER ID

    # -f: --follow, 跟踪日志
    docker logs -f <containerName>
    $ docker logs -f insane_babbage



Options::

        --details        Show extra details provided to logs
    -f, --follow         Follow log output
        --since string   Show logs since timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)
        --tail string    Number of lines to show from the end of the logs (default "all")
    -t, --timestamps     Show timestamps
        --until string   Show logs before a timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)


