docker network
##############

用法::

    Usage:  docker network COMMAND

    Manage networks

    Commands:
      connect     Connect a container to a network
      create      Create a network
      disconnect  Disconnect a container from a network
      inspect     Display detailed information on one or more networks
      ls          List networks
      prune       Remove all unused networks
      rm          Remove one or more networks

使用::

    // 创建时指定网段：172.18.0.0/16
    $ docker network create --subnet=172.18.0.0/16 mynetwork

    $ docker network inspect mynetwork

    // Docker网络允许您将容器附加到任意数量的网络。
    // 您还可以附加已在运行的容器。继续并将正在运行的web应用程序附加到tinywan_bridge
    $ docker network connect mynetwork web



实例::

    // 1. 创建网络
    $ docker network create test-network
    // 2. 启动容器时，加入创建的网络
    $ docker run -it --network test-network --network-alias mysqlhost -e MYSQL_ROOT_PASSWORD=123 mysql:5.7
    // 3. 启动被链接的容器
    $ docker run -it --network test-network --network-alias centoshost  centos /bin/bash
    centos> ping mysqlhost    // 可以直接用上面指定的network-alias
    centos> mysql -h mysqlhost -uroot -p123

create命令::

    $ docker network create -d bridge my-net
    -d 参数指定 Docker 网络类型，有 bridge overlay

inspect命令::

    $ docker network inspect bridge
    [{
        "Name": "bridge",
        "Id": "93196df71406f690bf83ba65d7556 a4ba9fae676b828e578c53832f8b59608ef",
        "Created": "2019-05-30T07:42:54.43279813+05:30", 
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default", 
            "Options": null, 
            "Config": [{
                "Subnet": "172.17.0.0/16", 
                "Gateway": "172.17.0.1"
            }]
        },
                        // Removed for Brevity
    }]








