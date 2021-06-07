代码自动生成
############


代码生成的场景有很多如::

    protobuf 根据一个协议字段配置文件生成客户端和服务端的.go代码
    IDE中的自动测试用例和接口实现函数代码生成
    一些web框架自动生成RESTFUL接口代码
    operator脚手架工具生成k8s controller代码等

代码生成原理::

    1. 解析我们写的源码，提取我们所需要的内容，如包名，结构体名，等
    2. 渲染模板文件
    3. 生成源码文件

最重要的就是::

    go/ast语法树解析和go/parser解析库的运用


Metaprogramming is a programming technique in which computer programs have the ability to treat programs as their data.






