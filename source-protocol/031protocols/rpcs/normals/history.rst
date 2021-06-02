历史
====

* 1980 年代初期，传奇的施乐 Palo Alto 研究中心，发布了基于 Cedar 语言的 RPC 框架 Lupine，并实现了世界上第一个基于 RPC 的商业应用 Courier。这里施乐 PARC 定义的 “远程服务调用” 的概念。所以，尽管此前已经有用其他名词指代 RPC 的操作，我们也一般认为 RPC 的概念，最早是由施乐公司所提出的::
    
    Remote procedure call is the synchronous language-level transfer of control 
      between programs in address spaces whose primary communication is a narrow channel.
    —— Bruce Jay Nelson，Remote Procedure Call，Xerox PARC，1981

    定义:
    RPC 是一种语言级别的通讯协议，
    它允许运行于一台计算机上的程序以某种管道作为通讯媒介（即某种传输协议的网络），
    去调用另外一个地址空间（通常为网络上的另外一台计算机）。

* 1987 年，当 “透明的 RPC 调用” 一度成为主流范式的时候，安德鲁・塔能鲍姆（Andrew Tanenbaum）教授曾发表了一篇论文 `“A Critique of the Remote Procedure Call Paradigm” <https://www.cs.vu.nl/~ast/Publications/Papers/euteco-1988.pdf>`_ ，对这种透明的 RPC 范式提出了一系列质问::

    两个进程通讯，谁作为服务端，谁作为客户端？
    怎样进行异常处理？
    异常该如何让调用者获知？
    服务端出现多线程竞争之后怎么办？
    如何提高网络利用的效率，比如连接是否可被多个请求复用以减少开销？
    是否支持多播？
    参数、返回值如何表示？
    应该有怎样的字节序？
    如何保证网络的可靠性，比如调用期间某个链接忽然断开了怎么办？
    服务端发送请求后，收不到回复该怎么办？

    论文的中心观点是：
    把本地调用与远程调用当作一样的来处理，是犯了方向性的错误，把系统间的调用做成透明的，反而会增加程序员工作的复杂度。

* 80 年代中后期，惠普和 Apollo 提出了网络运算架构（Network Computing Architecture，NCA）的设想，并随后在 DCE 项目中，发展成了在 Unix 系统下的远程服务调用框架 `DCE/RPC <https://zh.wikipedia.org/wiki/DCE/RPC>`_ ::
  
    这是历史上第一次对分布式有组织的探索尝试。
    因为 DCE 本身是基于 Unix 操作系统的，所以 DCE/RPC 也仅面向于 Unix 系统程序之间的通用

    注:
    微软 COM/DCOM 的前身 MS RPC，就是 DCE 的一种变体版本，而它就可以在 Windows 系统中使用。
    https://en.wikipedia.org/wiki/Microsoft_RPC

* 在 1988 年，Sun Microsystems 起草并向互联网工程任务组（Internet Engineering Task Force，IETF）提交了 RFC 1050 规范，此规范中设计了一套面向广域网或混合网络环境的、基于 TCP/IP 网络的、支持 C 语言的 RPC 协议，后来也被称为是 `ONC RPC（Open Network Computing RPC/Sun RPC） <https://en.wikipedia.org/wiki/Open_Network_Computing_Remote_Procedure_Call>`_ ::
  
    DCE/RPC和ONC RPC是如今各种 RPC 协议的鼻祖

* 1991 年，对象管理组织（Object Management Group，OMG）便发布了跨进程、面向异构语言的、支持面向对象的服务调用协议：CORBA 1.0（Common Object Request Broker Architecture）


* 1994 年至 1997 年间，由 ACM 和 Sun 的院士 Peter Deutsch、套接字接口发明者 Bill Joy、Java 之父 James Gosling 等众多在 Sun Microsystems 工作的大佬们，共同总结了`通过网络进行分布式运算的八宗罪（8 Fallacies of Distributed Computing） <https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing>`_

* 1998 年，XML 1.0 发布，并成为了万维网联盟（World Wide Web Consortium，W3C）的推荐标准
* 1999 年末，以 XML 为基础的 SOAP 1.0（Simple Object Access Protocol）规范的发布，代表着一种被称为 “Web Service” 的全新 RPC 协议的诞生。Web Service 是由微软和 DevelopMentor 公司共同起草的远程服务协议，随后被提交给 W3C，并通过投票成为了国际标准。所以，Web Service 也被称为是 W3C Web Service。Web Service求全，定义几乎数不清个数的家族协议，对开发者来说学习负担极其沉重。结果就是，得罪惨了开发者，谁爱用谁用去。

* 最近几年，RPC 框架有明显朝着更高层次（不仅仅负责调用远程服务，还管理远程服务）与插件化方向发展的趋势::
  
    不再选择自己去解决表示数据、传递数据和表示方法这三个问题，
    而是将全部或者一部分问题设计为扩展点，实现核心能力的可配置，
    再辅以外围功能，如负载均衡、服务注册、可观察性等方面的支持。
    这一类框架的代表，有 Facebook 的 Thrift 和阿里的 Dubbo





