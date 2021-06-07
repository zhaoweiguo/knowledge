docker port
###################

Usage::

    // List port mappings or a specific mapping for the container
    $ docker port CONTAINER [PRIVATE_PORT[/PROTO]]

实例::

    
    // 查看某container的指定port绑定的本地port
    $ sudo docker port nostalgic_morse 5000
    0.0.0.0:49154


    查看容器绑定和映射的端口及Ip地址
    $ docker port 44de1b0b5312(容器ID)
    80/tcp -> 127.0.0.1:32770



