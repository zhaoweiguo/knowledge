Serverless
#################

原始定义::

    Serverless 里这个 less 更确切的说是开发不用关心服务器的意思。

云原生时代::

    Serverless 不仅仅理解成为不用关心服务器。
    云上的资源除了服务器所包含的基础计算、网络、存储资源之外，还包括各种类别的更上层的资源，例如数据库、缓存、消息等等。


2019年2月，UC 伯克利大学发表了一篇标题为 `《Cloud Programming Simplified: A Berkeley View on Serverless Computing》 <https://www2.eecs.berkeley.edu/Pubs/TechRpts/2019/EECS-2019-3.pdf>`_ 的论文，论文中也有一个非常清晰形象的比喻，文中这样描述::

    在云的上下文中，Serverful 的计算就像使用低级的汇编语言编程，而 Serverless 的计算就像使用 Python 这样的高级语言进行编程。
    例如 c = a + b 这样简单的表达式，如果用汇编描述，就必须先选择几个寄存器，把值加载到寄存器，进行数学计算，再存储结果。
    这就好比今天在云环境下 Serverful 的计算，开发需要:
        首先分配或找到可用的资源，然后加载代码和数据，再执行计算，将计算的结果存储起来，最后还需要管理资源的释放。

.. note:: Serverless 的愿景应该是 Write locally, compile to the cloud，即代码只关心业务逻辑，由工具和云去管理资源。

Serverless 平台的主要特点::

    1. 不用关心服务器
    2. 自动弹性
    3. 按实际资源使用计费
    4. 更少的代码，更快的交付速度

实现 Serverless 面临的挑战::

    1. 业务轻量化困难
    2. 基础设施响应能力不足
    3. 业务进程生命周期与容器不一致
    4. 可观测能力需完善
    5. 研发运维心智需要改变

定义::

    Serverless = FaaS + BaaS





参考
====

* 喧哗的背后：Serverless 的概念及挑战✅: https://developer.aliyun.com/article/758888
* Serverless 技术公开课: https://developer.aliyun.com/learning/roadmap/serverless

