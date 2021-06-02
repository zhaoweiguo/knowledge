docker diff命令
###############

Usage::

    docker diff CONTAINER
    
说明::

    Inspect changes to files or directories on a container's filesystem


操作命令::

    # 运行
    $ docker run --name webserver -d -p 80:80 nginx

    # 修改
    $ docker exec -it webserver bash
    root@3729b97e8226:/# echo '<h1>Hello, Docker!</h1>' > /usr/share/nginx/html/index.html
    root@3729b97e8226:/# exit
    exit

    # 查看不同
    $ docker diff webserver
    C /root
    A /root/.bash_history
    C /run
    C /usr
    C /usr/share
    C /usr/share/nginx
    C /usr/share/nginx/html
    C /usr/share/nginx/html/index.html




