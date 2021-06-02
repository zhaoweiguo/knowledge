跨os相关问题
=================

cannot execute binary file
--------------------------------

原因::

    编译生成的是32位的二进制
    却运行在64位系统中

解决方法::

    env GOOS=linux GOARCH=amd64 go build alilog.go


Golang编译的二进制文件在alpine中无法运行
----------------------------------------


使用golang编译了一个二进制程序，在CentOS和Ubuntu的镜像上运行是可以的，但是在Alpine运行就不行，使用./运行报错::

    /bin/sh: ./saas_server: not found
    1
    /bin/sh: ./saas_server: not found

解决方案 [2]_ ::

    // 编译时添加参数CGO_ENABLED=0，关闭CGO就可以了
    // 注意: Neither GOOS=linux nor GOARCH=amd6 was necessary.
    $> CGO_ENABLED=0 go build

交叉编译问题
------------

一般情况 [3]_ ::

    # mac上编译linux和windows二进制
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build 
    CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build 
     
    # linux上编译mac和windows二进制
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build 
    CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
     
    # windows上编译mac和linux二进制
    SET CGO_ENABLED=0 SET GOOS=darwin SET GOARCH=amd64 go build main.go
    SET CGO_ENABLED=0 SET GOOS=linux SET GOARCH=amd64 go build main.go

交叉编译是不支持CGO的，也就是说如果你的代码中存在C代码，是编译不了的::

    // 注意: 比如说你的程序中使用了sqlite数据库，在编译go-sqlite驱动时按照上面的做法是编译不通过的
    // 需要CGO支持的，要将CGO_ENABLED的0改为1，也就是CGO_ENABLED=1
    linux上编译arm版的二进制:
    # Build for arm
    CGO_ENABLED=1 GOOS=linux GOARCH=arm CC=arm-linux-gnueabi-gcc go build

go tool cgo: exit status 2
-------------------------------

原因::

    有两个go版本:
    执行命令的是A
    GOPATH用的是B

解决方法::

    使用相同的版本




.. [2] https://stackoverflow.com/questions/34729748/installed-go-binary-not-found-in-path-on-alpine-linux-docker
.. [3] https://www.jb51.net/article/146168.htm