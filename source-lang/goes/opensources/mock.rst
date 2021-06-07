mock
######


GoMock是用于Go编程语言的模拟框架。 它与Go的内置测试包testing很好地集成在一起，但是也可以在其他环境中使用。

安装与使用
==========

安装::

    $ go get github.com/golang/mock/mockgen
    // 建议: GO111MODULE=on

    //文档
    go doc github.com/golang/mock/gomock
    or
    https://godoc.org/github.com/golang/mock/gomock


参数说明::

    -source： 指定接口文件
    -destination: 生成的文件名
    -package:生成文件的包名
    -imports: 依赖的需要import的包
    -aux_files:接口文件不止一个文件时附加文件
    -build_flags: 传递给build工具的参数


两种模式
========

源码模式(source mod)::

    // Source mode从源文件中生成mock interface
    格式:
    $ mockgen -source=<source>.go [other options]
    例:
    $ mockgen -source=foo.go [other options]
    // [other options]: -imports and -aux_files.

反射模式(reflect mod)::

    // Reflect mode通过构建使用反射的程序了解interfaces来生成mock interfaces
    格式:
    mockgen <package> <Type1>,<Type2>
    例:
    mockgen database/sql/driver Conn,Driver


实例
====

::

    $ mockgen -destination spider/mock_spider.go -package spider -source spider/spider.go

drone实例::

    $ mockgen -package=mock -destination=mock_gen.go github.com/drone/drone/core Pubsub,Canceler,ConvertService,ValidateService,NetrcService,Renewer,HookParser,UserService,RepositoryService,CommitService,StatusService,HookService,FileService,Batcher,BuildStore,CronStore,LogStore,PermStore,SecretStore,GlobalSecretStore,StageStore,StepStore,RepositoryStore,UserStore,Scheduler,Session,OrganizationService,SecretService,RegistryService,ConfigService,Triggerer,Syncer,LogStream,WebhookSender,LicenseService


mock意义
========

用一个实例说明::

    tree .
    .
    ├── go_version.go
    ├── main.go
    └── spider
        └── spider.go

cat spider.go::

    package spider

    // 定义了spider包的接口
    type Spider interface {
        GetBody() string
    }

cat go_version.go::

    import (
        "github.com/cz-it/blog/blog/Go/testing/gomock/example/spider"
    )

    func GetGoVersion(s spider.Spider) string {
        body := s.GetBody()
        return body
    }

    // 单元测试
    func TestGetGoVersion(t *testing.T) {
        v := GetGoVersion(spider.CreateGoVersionSpider())
        if v != "go1.8.3" {
            t.Error("Get wrong version %s", v)
        }
    }

说明::

    单元测试里的spider.CreateGoVersionSpider()返回一个实现了Spider接口的用来获得Go版本号的爬虫
    这个单元测试其实既测试了函数GetGoVersion也测试了spider.CreateGoVersionSpider返回的对象。
    而有时候，我们可能仅仅想测试下GetGoVersion函数，
    或者我们的spider.CreateGoVersionSpider爬虫实现还没有写好，那该如何是好呢

    这就是mock工具的意义

生成要mock的接口的实现::

    mockgen -destination spider/mock_spider.go -package spider 
      github.com/cz-it/blog/blog/Go/testing/gomock/example/spider Spider

这里生成了文件::

    └── spider
        ├── mock_spider.go
        └── spider.go

使用::

    import (
        "github.com/cz-it/blog/blog/Go/testing/gomock/example/spider"
        "github.com/golang/mock/gomock"
        "testing"
    )

    func TestGetGoVersion(t *testing.T) {
        mockCtl := gomock.NewController(t)
        mockSpider := spider.NewMockSpider(mockCtl)
        mockSpider.EXPECT().GetBody().Return("go1.8.3")
        goVer := GetGoVersion(mockSpider)

        if goVer != "go1.8.3" {
            t.Error("Get wrong version %s", goVer)
        }
    }

说明::

    这里在单元测试中再也不用先去实现一个Spider接口了，而通过gomock为我们直接生成，然后再集成到我们的单元测试里面。
    可以看到gomock和testing单元测试框架可以紧密的结合起来工作。

gomock的接口使用
================

将* testing.T传递给gomock生成一个"Controller"对象，该对象控制了整个Mock的过程::

    mockCtl := gomock.NewController(t)

在操作完后还需要进行回收，所以一般会在New后面defer一个Finish::

    defer mockCtl.Finish()

然后就是调用mock生成代码里面为我们实现的接口对象::

    mockSpider := spider.NewMockSpider(mockCtl)
    // "spider"是mockgen命令里面传递的包名
    // NewMockXxxx格式的对象创建函数,其中"Xxx"是接口名
    // 传递控制器对象进去, 返回一个接口的实现对象

EXPECT()得到实现的对象，然后调用实现对象的接口方法，接口方法返回第一个"Call"对象，然后对其进行条件约束::

    mockSpider.EXPECT().GetBody().Return("go1.8.3")

"Call"对象有如下方法::

    func (c *Call) After(preReq *Call) *Call
    func (c *Call) Do(f interface{}) *Call
    func (c *Call) SetArg(n int, value interface{}) *Call
    func (c *Call) String() string
    // 指定返回值:
    func (c *Call) Return(rets ...interface{}) *Call
    // 指定执行次数:
    func (c *Call) Times(n int) *Call
    // 0到多次
    func (c *Call) AnyTimes() *Call
    // 最多执行n次
    func (c *Call) MaxTimes(n int) *Call
    // 最少执行n次
    func (c *Call) MinTimes(n int) *Call

指定执行顺序::

    // 如: 要先执行Init操作，然后才能执行Recv操作
    initCall := mockSpider.EXPECT().Init()
    mockSpider.EXPECT().Recv().After(initCall)






参考
====

* 参考1: https://www.jianshu.com/p/598a11bbdafb
* 官方文档: https://godoc.org/github.com/golang/mock/gomock

