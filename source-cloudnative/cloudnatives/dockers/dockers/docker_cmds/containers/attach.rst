docker attach
#####################

Usage::

    // Attach local standard input, output, and error streams to a running container
    docker attach [OPTIONS] CONTAINER

实例::

    $ docker run -dit ubuntu
    243c32535da7d142fb0e6df616a3c3ada0b8ab417937c853a9e1c251f499f550

    $ docker container ls
    CONTAINER ID  IMAGE          COMMAND      CREATED      STATUS          PORTS   NAMES
    243c32535da7  ubuntu:latest  "/bin/bash"  18 seconds   Up 17 seconds           nostalgic_hypatia

    $ docker attach 243c
    root@243c32535da7:/# exit   注意： 如果从这个 stdin 中 exit，会导致容器的停止




Options::

      --detach-keys string   Override the key sequence for detaching a container
      --no-stdin             Do not attach STDIN
      --sig-proxy            Proxy all received signals to the process (default true)


在使用 -d 参数时，容器启动后会进入后台。某些时候需要进入容器进行操作，包括使用 docker attach 命令或 docker exec 命令，推荐大家使用 docker exec 命令



