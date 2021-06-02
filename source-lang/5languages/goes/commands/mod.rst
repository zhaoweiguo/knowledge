.. _mod:

go mod命令
##########

Usage::

    $ go mod <command> [arguments]
    $ go help mod <command>

<command>::

    download    download modules to local cache
    edit        edit go.mod from tools or scripts
    graph       print module requirement graph
    init        initialize new module in current directory
    tidy        add missing and remove unused modules
    vendor      make vendored copy of dependencies
    verify      verify dependencies have expected content
    why         explain why packages or modules are needed

实例init::

    $ go mod init example.com/m
    实例:

    $ go mod init github.com/zhaoweiguo/abc
    or
    $ go mod init github.com/zhaoweiguo/abc/v2

移除mod::

    1. 移出所有代码中不需要的包
    $ go mod tidy

    2. 仅仅修改 go.mod 配置文件的内容
    $ go mod edit --droprequire=golang.org/x/crypto

查看依赖包::

    1. 可以直接查看 go.mod 文件，或者使用命令行：
    $ go list -m all

    2. json 格式输出
    $ go list -m -json all

升级相关::

    1. 实例查看要升级的依赖:
    $ go list -u -m all

    2. 升级次级或补丁版本号:
    $ go get -u rsc.io/quote

    3. 仅升级补丁版本号：
    $ go get -u=patch rscio/quote

    4. 升降级版本号，可以使用比较运算符控制：
    $ go get foo@'<v1.6.2'

    5. 增加确定版本
    $ go get foo@v1.6.2

发布版本::

    官方推荐将上述过程在一个新分支来避免混淆，那么类如上述例子可以创建一个 v2 分支，但这个不是强制要求的
    还有一种方式发布新版本，那就是在主线版本种加入 v2 文件夹，相应的也需要内置 go.mod 这个文件
    $ go mod edit --module=github.com/islishude/gomodtest/v2



说明::

    在 Go v1.12 功能基本稳定，到下一个版本 v1.13 将默认开启
    在1.11版本引入，尚且是初期版本。考虑向前兼容，目前仍然可以用go get，但最终这个命令是会消失的。
    go命令(‘go build’, ‘go test’, 甚至 ‘go list’)执行时，会自己去修改go.mod文件







参考
====

* `Go Modules : v2 及更高版本 <https://juejin.im/post/5de7c00d518825122b0f7113>`_


