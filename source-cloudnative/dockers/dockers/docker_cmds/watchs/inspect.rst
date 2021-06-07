docker inspect
#######################

Usage::

    // 返回Docker对象低级别信息
    // Return low-level information on Docker objects
    docker inspect [OPTIONS] NAME|ID [NAME|ID...]


Options::

    -f, --format string   Format the output using the given Go template
    -s, --size            Display total file sizes if the type is container
        --type string     Return JSON for specified type

实例::

    # inspect container全部信息
    $ docker inspect gordon-container

    # 只查看ip地址
    $ docker inspect -f '{{ .NetworkSettings.IPAddress }}' nostalgic_morse
    172.17.0.5

    # 查看container's name
    $ docker inspect -f "{{ .Name }}" aed84ee21bde
    /web

    # 容器的第一个进程的 PID
    $ docker inspect --format "{{ .State.Pid }}" <container ID or NAMES>






