docker volume
#############

创建一个数据卷::

    $ docker volume create my-vol

删除数据卷::

    $ docker volume rm my-vol

清理无主的数据卷::

    $ docker volume prune


查看所有的 数据卷::

    $ docker volume ls
    local               my-vol

在主机里使用以下命令可以查看指定 数据卷 的信息::

    $ docker volume inspect my-vol
    [
        {
            "Driver": "local",
            "Labels": {},
            "Mountpoint": "/var/lib/docker/volumes/my-vol/_data",
            "Name": "my-vol",
            "Options": {},
            "Scope": "local"
        }
    ]



启动一个挂载数据卷的容器::

    $ docker run -d -P \
      --name web \
      # -v my-vol:/wepapp \
      --mount source=my-vol,target=/webapp \
      training/webapp \
      python app.py

挂载一个主机目录作为数据卷::

    $ docker run -d -P \
        --name web \
        # -v /src/webapp:/opt/webapp \
        --mount type=bind,source=/src/webapp,target=/opt/webapp \
        training/webapp \
        python app.py

Docker 挂载主机目录的默认权限是 读写，用户也可以通过增加 readonly 指定为 只读::

    $ docker run -d -P \
        --name web \
        # -v /src/webapp:/opt/webapp:ro \
        --mount type=bind,source=/src/webapp,target=/opt/webapp,readonly \
        training/webapp \
        python app.py

















