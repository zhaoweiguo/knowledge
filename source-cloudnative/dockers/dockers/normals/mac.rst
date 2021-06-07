mac路径相关
###############




mac下docker的镜像保存位置::

    ~/Library/Containers/com.docker.docker/Data/...

使用移动硬盘存放vm数据::

    mv ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/ /otherPath/com.docker.driver.amd64-linux
    ln -s /otherPath/com.docker.driver.amd64-linux /Users/<username>/Library/Containers/com.docker.docker/Data








