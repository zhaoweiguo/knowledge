Richardson 成熟度模型
=====================


Richardson `成熟度模型 <https://martinfowler.com/articles/richardsonMaturityModel.html>`_ ::

    RESTful Web APIs” 和 “RESTful Web Services” 的作者伦纳德・理查德森（Leonard Richardson）
    提出了一个衡量 “服务有多么 REST” 的 Richardson 成熟度模型（Richardson Maturity Model，RMM）

    Richardson 将服务接口按照 “REST 的程度”，从低到高分为 0 至 3 共 4 级：
    1. The Swamp of Plain Old XML：完全不 REST。
    2. Resources：开始引入资源的概念。
    3. HTTP Verbs：引入统一接口，映射到 HTTP 协议的方法上。
    4. Hypermedia Controls：在咱们课程里面的说法是 “超文本驱动”，
        在 Fielding 论文里的说法是 Hypertext as the Engine of Application State（HATEOAS）

第 0 级成熟度：The Swamp of Plain Old XML::

    医院开放了一个 /appointmentService 的 Web API，传入日期、医生姓名作为参数，就可以得到该时间段、该医生的空闲时间。

    1. 请求医生的空闲时间:
    POST /appointmentService?action=query HTTP/1.1
    {date: "2020-03-04", doctor: "mjones"}

    返回:
    HTTP/1.1 200 OK
    [ 
      {start:"14:00", end: "14:50", doctor: "mjones"}, 
      {start:"16:00", end: "16:50", doctor: "mjones"}
    ]

    2. 预约确认，并提交了我的基本信息:
    POST /appointmentService?action=comfirm HTTP/1.1

    {
        appointment: {date: "2020-03-04", start:"14:00", doctor: "mjones"},
        patient: {name: xx, age: 30, ……}
    }

    返回:
    a. 预约成功
    HTTP/1.1 200 OK

    {
        code: 0,
        message: "Successful confirmation of appointment"
    }

    b. 预约失败，有人在我前面抢先预约了
    HTTP/1.1 200 OK

    {
        code: 1
        message: "doctor not available"
    }

    结论: 非常直观的基于 RPC 风格的服务设计

第 1 级成熟度：Resources::

    通往 REST 的第一步是引入资源的概念
      在 API 中最基本的体现，它是围绕着资源而不是过程来设计服务

    每次请求中都应包含资源 ID，所有操作均通过资源 ID 来进行

    1. 请求医生的空闲时间:
    POST /doctors/mjones HTTP/1.1

    {date: "2020-03-04"}

    返回:
    服务器传回一个包含了 ID 的信息。
    注意，ID 是资源的唯一编号，有 ID 即代表 “医生的档期” 被视为一种资源:
    HTTP/1.1 200 OK

    [
        {id: 1234, start:"14:00", end: "14:50", doctor: "mjones"},
        {id: 5678, start:"16:00", end: "16:50", doctor: "mjones"}
    ]

    2. 预约确认，并提交了我的基本信息:
    POST /schedules/1234 HTTP/1.1

    {name: xx, age: 30, ……}

第 2 级成熟度：HTTP Verbs::

    引入统一接口（Uniform Interface）
    HTTP 协议的标准方法是经过精心设计的，它几乎涵盖了资源可能遇到的所有操作场景:

    1. 把不同业务需求抽象为对资源的增加、修改、删除等操作来解决；
    2. 针对响应代码，使用 HTTP 协议的 Status Code，可以涵盖大多数资源操作可能出现的异常（也可自定义扩展的）；
    3. 针对安全性，依靠 HTTP Header 中携带的额外认证、授权信息来解决

    1. 在获取医生档期时，应该使用具有查询语义的 GET 操作来完成
    GET /doctors/mjones/schedule?date=2020-03-04&status=open HTTP/1.1

    返回:
    HTTP/1.1 200 OK

    [
        {id: 1234, start:"14:00", end: "14:50", doctor: "mjones"},
        {id: 5678, start:"16:00", end: "16:50", doctor: "mjones"}
    ]

    2. 预约确认，并提交了我的基本信息:
    POST /schedules/1234 HTTP/1.1

    {name: xx, age: 30, ……}

    返回:
    a. 预约成功
      HTTP/1.1 201 Created

      Successful confirmation of appointment
    b. 失败
      HTTP/1.1 409 Conflict

      doctor not available

第 3 级成熟度：Hypermedia Controls::

    关键词: HATEOAS, 超文本驱动

    希望能达到这样一种效果:
      除了第一个请求是由你在浏览器地址栏输入的信息所驱动的之外，
      其他的请求都应该能够自己描述清楚后续可能发生的状态转移，由超文本自身来驱动。


    1. 在获取医生档期时，应该使用具有查询语义的 GET 操作来完成
    GET /doctors/mjones/schedule?date=2020-03-04&status=open HTTP/1.1

    返回(服务器传回的响应信息应该包括如何预约档期、如何了解医生信息等可能的后续操作):
    HTTP/1.1 200 OK

    {
        schedules：[
            {
                id: 1234, start:"14:00", end: "14:50", doctor: "mjones",
                links: [
                    {rel: "comfirm schedule", href: "/schedules/1234"}
                ]
            },
            {
                id: 5678, start:"16:00", end: "16:50", doctor: "mjones",
                links: [
                    {rel: "comfirm schedule", href: "/schedules/5678"}
                ]
            }
        ],
        links: [
           {rel: "doctor info", href: "/doctors/mjones/info"}
        ]
    }

    做到了第 3 级 REST，那么服务端的 API 和客户端就可以做到完全解耦了。
    这样一来，你再想要调整服务数量，或者同一个服务做 API 升级，将会变得非常简单。
    gordon评: 做成web页面了




