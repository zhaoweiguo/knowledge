Golang安装相关
====================

安装命令::

    // 先下载指定os的包
    tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz


修改文件$HOME/.profile::

    // 设置GOPATH(指定Golang的安装目录)
    export GOPATH=$HOME/9tool/go
    // 设置GOROOT(指定Golang的项目根目录)
    export GOROOT=$HOME/go1.X


Installing extra Go versions::

    $ go get golang.org/dl/go1.10.7
    $ go1.10.7 download

    # 使用
    $ go1.10.7 version
    go version go1.10.7 linux/amd64


GOPATH::

    export GOPATH=~/work/go-proj1:~/work2/goproj2:~/work3/work4/go-proj3
    // 之后可以在任意目录对以上3个工程进行构建

GO111MODULE::

    作用: 开启或关闭模块支持

    GO111MODULE=off 无模块支持，go 会从 GOPATH 和 vendor 文件夹寻找包
    GO111MODULE=on 模块支持，go 会忽略 GOPATH 和 vendor 文件夹，只根据 go.mod 下载依赖
    GO111MODULE=auto 在 $GOPATH/src 外面且根目录有 go.mod 文件时，开启模块支持

    在使用模块的时候，GOPATH 是无意义的，不过它还是会把下载的依赖储存在 $GOPATH/pkg/mod 中
        也会把 go install 的结果放在 $GOPATH/bin 中

GOPRIVATE::

    Go 1.13后, go命令默认使用 proxy.golang.org 做下载代理镜像和校验和验证
    有些私有项目不想经过此proxy，则设置:
    GOPRIVATE=*.corp.example.com,rsc.io/private



快速使用::

    export GO111MODULE=on
    export GOPROXY=https://goproxy.cn,direct
    export GOSUMDB=sum.golang.google.cn
    export GOPRIVATE=git.zhaoweiguo.com













