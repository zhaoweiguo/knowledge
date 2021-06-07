docker search
####################

Usage::

    # Search the Docker Hub for images
    docker search [OPTIONS] TERM


Options::

    -f, --filter filter   Filter output based on conditions provided
        --format string   Pretty-print search using a Go template
        --limit int       Max number of search results (default 25)
        --no-trunc        Don't truncate output

实例::

    // 查询指定images
    $ docker search sinatra

    // 只搜索那些被收藏 10 次以上的镜像
    $ docker search --filter=stars=10 ubuntu
    $ docker search -f stars=10 ubuntu



