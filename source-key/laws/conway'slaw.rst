康威定律(Conway's Law)
######################


在 **划分系统** 时，应该多考虑 康威定律::

    系统架构是公司组织架构的反映
    应该按照业务闭环进行系统拆分／组织架构划分，实现闭环／高内聚／低耦合，减少沟通成本
    如果沟通出现问题，那么应该考虑进行系统和组织架构的调整
    在合适时机进行系统拆分，不要一开始就把系统／服务拆的非常细，虽然闭环，但是每个人维护的系统多，维护成本高


.. note:: 定义: Organizations which design systems are constrained to produce designs which are copies of the communication structures of these organizations. - Melvin Conway(1967) 
    设计系统的组织，其产生的设计等同于组织之内、组织之间的沟通结构 


* 康威定律被视为微服务架构的理论基础





康威4大定律(1967)
=================

Law 1::

    ->
    Any organization that designs a system (defined more broadly here than just information systems)
      will inevitably produce a design whose structure is a copy of 
        the organization's communication structure.
    
    ->
    A system’s design is a copy of the organization’s communication structure.

    ->
    Communication dictates design
    o> The mode of organizational communication is expressed through system design

Law 2::

    There is never enough time to do something right, but there is always enough time to do it over
    o> A task can never be done perfectly, even with unlimited time, but there is always time to complete a task

    Satisficing v. Sacrificing  -- Eric Hollnagel, 2009
    -> Satisficing is explained as a consequence of limited cognitive capacity. 
    -> Sacrificing is explained as a consequence of the intractability of the work environment
    1. Problem too complicated? Ignore details.
    2. Not enough resources? Give up features.

    Increasing Intractability
    1. Systems grow too large 
    2. Rate of change increases 
    3. Overall expectations keep rising
    系统的复杂性、功能数量、市场竞争以及投资人的期望值都在增加，而人的智力是有上限的，没有企业能说一定能找到合适的人，
        对于一个极其复杂的系统，总会有考虑不周全的地方，Erik认为这个问题最好的解决办法就是：不去管它。

    持续集成和敏捷开发


Law 3::

    There is a homomorphism from the linear graph of a system to the linear graph of its design organization
    o> Homomorphism exists between linear systems and linear organizational structures

    homomorphism    - Eric S. Raymond, 1991
    “If you have four groups working on a compiler, you'll get a 4-pass compiler.”

Law 4::

    The structures of large systems tend to disintegrate during development, qualitatively more so than small systems
    o> A large system organization is easier to decompose than a smaller one

    Disintegration: Reason #1
    “The realization that the system will be large, together with organization pressures, 
        make irresistible the temptation to assign too many people to a design effort”
    Brooks’ Law:
    Adding manpower to a late software project makes it later   -- Fred Brooks, 1975
    Intercommunication formula: n(n − 1) / 2

    Disintegration: Reason #2
    Application of the conventional wisdom of management to a large design organization 
        causes its communication structure to disintegrate.
    Dunbar’s Number   -- Robin Dunbar, 1992
    A measurement of the “cognitive limit to the number of individuals with whom 
        any one person can maintain stable relationships.

    Disintegration: Reason #3
    “Homomorphism insures that the structure of the system will 
        reflect the disintegration which has occurred in the design organization.”


参考
====

1. `【wikipedia】Conway's law <https://en.wikipedia.org/wiki/Conway's_law>`_
2. `【论文】Conway's Law <https://app.yinxiang.com/fx/1d4a3db5-5221-46bf-9fbf-8e2d8805b2c8>`_
3. `【云栖芷沁】Conway's Law – A Theoretical Basis for the Microservice Architecture <https://app.yinxiang.com/fx/5bfa6baa-8383-4aa6-881e-4564900014f4>`_
4. `【ppt】Conway's Law at a Distance <https://app.yinxiang.com/fx/b6ed51d1-0280-4005-b75c-953003537d98>`_
5. `【segmentfault】康威定律——这个50年前就被提出的微服务概念，你知多少 <https://app.yinxiang.com/fx/5dd09498-35b0-4f60-9a55-ecb1e587bb45>`_

说明::

    1. 康威定律的wiki定义
    2. 康威定律出现的论文
    3. 云栖芷沁对4中ppt内容的介绍并在最后论证了与「微服务」的相似点
    4. Mike Amundsen(Author of 「Design RESTful API」)讲解的ppt，并总结出康威4大定律
    5. 是3的中文翻译版，用作参考

