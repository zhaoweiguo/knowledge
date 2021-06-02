.. _go_doc:

go doc命令
##########

格式::

    $ go doc [-u] [-c] [package|[package.]symbol[.methodOrField]]

无参命令::

    $ go doc
    默认是当前目录

一个参数命令::

    go doc <pkg>
    go doc <sym>[.<methodOrField>]
    go doc [<pkg>.]<sym>[.<methodOrField>]
    go doc [<pkg>.][<sym>.]<methodOrField>

 two arguments::

    go doc <pkg> <sym>[.<methodOrField>]

.. note:: 大写字母只匹配大写，小写字母可以匹配大写也可以匹配小写

实例::

    go doc
        Show documentation for current package.
    go doc Foo
        Show documentation for Foo in the current package.
        (Foo starts with a capital letter so it cannot match a package path.)
    go doc encoding/json
        Show documentation for the encoding/json package.
    go doc json
        Shorthand for encoding/json.
    go doc json.Number (or go doc json.number)
        Show documentation and method summary for json.Number.
    go doc json.Number.Int64 (or go doc json.number.int64)
        Show documentation for json.Number's Int64 method.
    go doc cmd/doc
        Show package docs for the doc command.
    go doc -cmd cmd/doc
        Show package docs and exported symbols within the doc command.
    go doc template.new
        Show documentation for html/template's New function.
        (html/template is lexically before text/template)
    go doc text/template.new # One argument
        Show documentation for text/template's New function.
    go doc text/template new # Two arguments
        Show documentation for text/template's New function.

    At least in the current tree, these invocations all print the documentation for json.Decoder's Decode method:

    go doc json.Decoder.Decode
    go doc json.decoder.decode
    go doc json.decode
    cd go/src/encoding/json; go doc decode

godoc命令
=========

安装::

    $ go get golang.org/x/tools/cmd/godoc

使用::

    $ godoc -http:8080
    启动一web server， 打开$GOPATH下面库生成的文档

说明::

    Standard library        标准的golang库文档
    Third party             第3方库文档, 即$GOPATH下面的库
    Other packages
        Sub-repositories
        Community

.. image:: /images/languages/golangs/command_godoc1.png

添加文档示例
------------

总结::

    示例代码必须单独存放在一个文件中，文件名字为example_test.go。
    在这个go文件里，定义一个名字为Example的函数，参数为空
    示例的输出采用注释的方式，以//Output:开头，另起一行，每行输出占一行。

实例::

    $ cat example_test.go
    package lib
    import "fmt"
    func Example() {
        sum:=Add(1,2)
        fmt.Println("1+2=",sum)
        //Output:
        //1+2=3
    }

    $ cat example.go
    /*
     提供的常用库，有一些常用的方法，方便使用
     */
    package lib

    // 一个加法实现
    // 返回a+b的值
    func Add(a,b int) int {
        return a+b
    }

.. image:: /images/languages/golangs/command_godoc2.png




API 文档服务器
==============

* https://gowalker.org/
* https://godoc.org/

参考
====

* https://www.flysnow.org/2017/03/09/go-in-action-go-doc.html
