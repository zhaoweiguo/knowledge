REST概念
========

REST 概念的提出来自于罗伊・菲尔丁（Roy Fielding）在 2000 年发表的博士论文: `《Architectural Styles and the Design of Network-based Software Architectures》(架构风格与网络的软件架构设计) <https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm>`_ 。中文版参见 `这儿 <https://www.infoq.cn/article/2007/07/dlee-fielding-rest/>`_

罗伊・菲尔丁（Roy Fielding）简介::

    是一名很优秀的软件工程师
    是 Apache 服务器的核心开发者，后来成为了著名的 Apache 软件基金会的联合创始人
    是 HTTP 1.0 协议（1996 年发布）的专家组成员
    是 HTTP 1.1 协议（1999 年发布）的负责人
        指导设计 HTTP 1.1 协议的理论和思想，最初是以备忘录的形式，在专家组成员之间交流，
        这个备忘录其实就是 REST 的雏形。

.. note:: 什么叫『表征状态转移』？即什么是REST(Representational State Transfer)。

Fielding 在提出 REST 时，所谈论的范围是 “架构风格与网络的软件架构设计”（Architectural Styles and Design of Network-based Software Architectures），而不是现在被人们所狭义理解的一种 “远程服务设计风格”。Fielding 提的 REST 是更通用的一种设计理念

超文本(Hypertext)
-----------------

.. note:: 先去理解什么是 HTTP，再配合一些实际例子来进行类比，你就会发现 “REST” 实际上是 “HTT”（Hyper Text Transfer，超文本传输）的进一步抽象，它们就像是接口与实现类之间的关系。

.. note:: HTTP 中使用的 “超文本” 一词，是美国社会学家泰德・H・尼尔森（Theodor Holm Nelson）在 1967 年于`《Brief Words on the Hypertext》 <https://archive.org/details/SelectedPapers1977>`_ 一文里提出的

Nelson在 1992 年修正后的定义::

    By now the word "hypertext" has become generally accepted for branching and responding text, 
    but the corresponding word "hypermedia", meaning complexes of 
        branching and responding graphics, movies and sound – as well as text – is much less used. 
    Instead they use the strange term "interactive multimedia": 
        this is four syllables longer, and does not express the idea of extending hypertext.
    —— Theodor Holm Nelson Literary Machines, 1992

    “超文本（或超媒体）” 指的是一种 “能够对操作进行判断和响应的文本（或声音、图像等）”


REST 中的关键概念
-----------------

资源（Resource）::

    内容本身（可以将其视作是某种信息、数据），我们称之为 “资源”

表征（Representation）::

    “表征” 这个概念是指信息与用户交互时的表示形式:
    如:
      同一资源:
        服务端向浏览器返回的 HTML 格式的数据
        服务端向浏览器返回的 PDF 格式的数据
        服务端向浏览器返回的 Markdown 格式的数据
        服务端向浏览器返回的 RSS 格式的数据
        ...
      上面就是同一资源的多种表征

状态（State）::

    在特定语境中才能产生的上下文信息就被称为 “状态”，如:
      读完了这篇文章，想再接着看下一篇文章的内容时，你向服务器发出请求 “给我下一篇文章”。
      但是 “下一篇” 是个相对概念，必须依赖 “当前你正在阅读的文章是哪一篇”，这样服务器才能正确回应

    有状态（Stateful）还是无状态（Stateless），都是只相对于服务端来说的:
    1. 服务器记住用户的状态，这是有状态
    2. 客户端来记住状态，在请求的时候明确告诉服务器，这是无状态

转移（Transfer）::

    服务器通过某种方式，把 “用户当前阅读的文章” 转变成 “下一篇文章”，这就被称为 “表征状态转移”

1. 统一接口（Uniform Interface）::

    “统一接口”，包括：GET、HEAD、POST、PUT、DELETE、TRACE、OPTIONS 七种基本操作

    任何一个支持 HTTP 协议的服务器都会遵守这套规定，对特定的 URI 采取这些操作，服务器就会触发相应的表征状态转移。

2. 超文本驱动（Hypertext Driven）::

    浏览器作为通用的客户端，任何网站的导航（状态转移）行为都不可能是预置于浏览器代码之中，
        而是由服务器发出的请求响应信息（超文本）来驱动的。
    这点与其他带有客户端的软件有十分本质的区别，
        在那些软件中，业务逻辑往往是预置于程序代码之中的，
        有专门的页面控制器（无论在服务端还是在客户端中）来驱动页面的状态转移。

3. 自描述消息（Self-Descriptive Messages）::

    一种被广泛采用的自描述方法，是在名为 “Content-Type” 的 HTTP Header 中标识出互联网媒体类型（MIME type）
    比如 “Content-Type : application/json; charset=utf-8”

    互联网媒体类型（MIME type）:
    https://zh.wikipedia.org/wiki/%E4%BA%92%E8%81%94%E7%BD%91%E5%AA%92%E4%BD%93%E7%B1%BB%E5%9E%8B






