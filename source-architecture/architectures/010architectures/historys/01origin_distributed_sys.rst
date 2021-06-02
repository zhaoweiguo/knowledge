原始分布式时代
##############

Unix 设计哲学下的服务探索

.. important:: Unix 的分布式设计哲学
      Simplicity of both the interface and the implementation are more important than any other attributes of the system — including correctness, consistency, and completeness.
      保持接口与实现的简单性，比系统的任何其他属性，包括准确性、一致性和完整性，都来得更加重要。




分布式架构的目标是使用多个独立的分布式服务，来共同构建一个更大型的系统::

      惠普公司在 80 年代初期提出的网络运算架构（ `Network Computing Architecture，NCA <https://en.wikipedia.org/wiki/Network_Computing_System>`_ ），可以说是未来远程服务调用的雏形

      卡内基・梅隆大学提出的 AFS 文件系统（ `Andrew File System <https://en.wikipedia.org/wiki/Andrew_File_System>`_ ），可以看作是分布式文件系统的最早实现

      麻省理工学院提出的 `Kerberos 协议 <https://en.wikipedia.org/wiki/Kerberos_(protocol)>`_ ，是服务认证和访问控制（ACL）的基础性协议，是分布式服务安全性的重要支撑，目前包括 Windows 和 macOS 在内的众多操作系统的登录、认证功能，等等，都会利用到这个协议。

而为了避免 `Unix 系统的版本战争 <https://en.wikipedia.org/wiki/Unix_wars>`_ 在分布式领域中重演，负责制定 Unix 系统技术标准的开放软件基金会（Open Software Foundation，OSF，也就是后来的 “国际开放标准组织”）就邀请了各个主要的研究厂商一起参与，共同制订了 “分布式运算环境”（Distributed Computing Environment，DCE）的分布式技术体系。


DCE
===

DCE 包括了一整套完整的分布式服务组件的规范与实现::

      源自 NCA 的远程服务调用规范（Remote Procedure Call，RPC，在当时被称为是 `DCE/RPC`
      跟后来不局限于 Unix 系统的、基于通用 TCP/IP 协议的远程服务标准 `ONC RPC`
      `DCE/RPC` 和 `ONC RPC` 一起被认为是现代 RPC 的共同鼻祖

      源自 AFS 的分布式文件系统（Distributed File System，DFS）规范，在当时被称为 `DCE/DFS`

      源自 Kerberos 的服务认证规范，还有时间服务、命名与目录服务，就连现在程序中很常用的通用唯一识别符 UUID，也是在 DCE 中发明出来的。

因为 OSF 本身的背景（它是一个由 Unix 开发者组成的 Unix 标准化组织），所以在当时研究这些分布式技术，通常都会有一个预设的重要原则(`Unix Philosophyt`)，也就是在实现分布式环境中的服务调用、资源访问、数据存储等操作的时候，要尽可能地透明化、简单化，让开发人员不用去过于关注他们访问的方法，或者是要知道其他资源是位于本地还是远程。

`Unix philosophy: <https://en.wikipedia.org/wiki/Unix_philosophy>`_ (有过几个版本的不同说法，这里我指的是 Common Lisp 作者 Richard P. Gabriel 提出的简单优先 “Worse is Better” 原则），但这个目标其实是过于理想化了，它存在一些在当时根本不可能完美解决的技术困难。

“调用远程方法” 与 “调用本地方法” 尽管只是两字之差，但要是想能同时兼顾到简单、透明、性能、正确、鲁棒（Robust）、一致的目标的话，两者的复杂度就完全不能相提并论了。

.. note:: 原始分布式时代的教训：
      Just because something can be distributed doesn’t mean it should be distributed. Trying to make a distributed call act like a local call always ends in tears.
      某个功能能够进行分布式，并不意味着它就应该进行分布式，强行追求透明的分布式操作，只会自寻苦果。
      —— Kyle Brown，IBM Fellow，Beyond buzzwords: A brief history of microservices patterns，2016

在当时计算机科学面前，有两条通往更大规模软件系统的道路，一条路是尽快提升单机的处理能力，以避免分布式的种种问题；另一条路是找到更完美的解决方案，来应对如何构筑分布式系统的问题。在 20 世纪 80 年代，正是摩尔定律开始稳定发挥作用的黄金时期，微型计算机的性能以每两年就增长一倍的惊人速度在提升，用单台或者几台计算机，就可以作为服务器来支撑大型信息系统的运作了，信息系统进入了单体时代







