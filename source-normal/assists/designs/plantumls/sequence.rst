时序图
######

* 文档 [1]_

说明::

    ->    来绘制参与者之间传递的消息
    -->   绘制一个虚线箭头

简单示例
========

.. literalinclude:: ./files/sequences/diagram1.puml

.. uml:: ./files/sequences/diagram1.puml


声明参与者
==========

actor关键字::

    actor
    boundary
    control
    entity
    database
    collections
    participant



参与者不同的类型:

.. literalinclude:: ./files/sequences/diagram2.puml

.. uml:: ./files/sequences/diagram2.puml

关键字 as 指定另名, 指定颜色:

.. literalinclude:: ./files/sequences/diagram3_as.puml

.. uml:: ./files/sequences/diagram3_as.puml

自定义顺序来打印参与者:


.. literalinclude:: ./files/sequences/diagram4_order.puml

.. uml:: ./files/sequences/diagram4_order.puml


.. note:: 在参与者中使用非字母符号时使用双引号

修改箭头样式
============

说明::

    表示一条丢失的消息：末尾加 x
    让箭头只有上半部分或者下半部分：将 < 和 > 替换成 \ 或者 /
    细箭头：将箭头标记写两次 (如 >> 或 //)
    虚线箭头：用 -- 替代 -
    箭头末尾加圈：->o
    双向箭头：<->

.. literalinclude:: ./files/sequences/diagram5_arraw.puml

.. uml:: ./files/sequences/diagram5_arraw.puml

箭头颜色::

    @startuml
    Bob -[#red]> Alice : hello
    Alice -[#0000FF]->Bob : ok
    @enduml

.. uml::

    @startuml
    Bob -[#red]> Alice : hello
    Alice -[#0000FF]->Bob : ok
    @enduml


对消息序列编号
==============

关键字::

    autonumber                    用于自动对消息编号
    autonumber start              用于指定编号的初始值
    autonumber start increment    同时指定编号的初始值和每次增加的值
    autonumber stop               表示暂停
    autonumber resume increment   继续使用自动编号


.. literalinclude:: ./files/sequences/diagram6_number.puml

.. uml:: ./files/sequences/diagram6_number.puml

在双引号内指定编号的格式:


.. literalinclude:: ./files/sequences/diagram7_number.puml

.. uml:: ./files/sequences/diagram7_number.puml

暂停或继续使用自动编号:

.. literalinclude:: ./files/sequences/diagram7_number.puml

.. uml:: ./files/sequences/diagram7_number.puml

页面标题,页眉,页脚
==================

关键词::

    title   关键词增加标题
    header  关键词增加页眉
    footer  关键词增加页脚

.. literalinclude:: ./files/sequences/diagram10.puml

.. uml:: ./files/sequences/diagram10.puml

去掉底部的重复参与者对象::

    hide footbox

.. literalinclude:: ./files/sequences/diagram10-2.puml

.. uml:: ./files/sequences/diagram10-2.puml


分割示意图
==========

.. literalinclude:: ./files/sequences/diagram11.puml

.. uml:: ./files/sequences/diagram11.puml


组合消息
========

关键词::

    alt/else
    opt
    loop
    par
    break
    critical
    group


.. literalinclude:: ./files/sequences/diagram12.puml

.. uml:: ./files/sequences/diagram12.puml

注释
====

在消息后面添加关键词::

    note left
    note right
    
    end note 来添加多行注释


.. literalinclude:: ./files/sequences/diagram15_note1.puml

.. uml:: ./files/sequences/diagram15_note1.puml


在节点 (participant) 的相对位置放置注释::

    note left of
    note right of
    note over

.. literalinclude:: ./files/sequences/diagram15_note2.puml

.. uml:: ./files/sequences/diagram15_note2.puml

改变备注框的形状:

.. literalinclude:: ./files/sequences/diagram15_note3.puml

.. uml:: ./files/sequences/diagram15_note3.puml

Creole 和 HTML
==============

.. literalinclude:: ./files/sequences/diagram17_creole.puml

.. uml:: ./files/sequences/diagram17_creole.puml



分隔符
======

.. literalinclude:: ./files/sequences/diagram16_split.puml

.. uml:: ./files/sequences/diagram16_split.puml


外观参数(skinparam)
====================

改变字体:

.. literalinclude:: ./files/sequences/diagram13_skinparam1.puml

.. uml:: ./files/sequences/diagram13_skinparam1.puml


改变颜色

.. literalinclude:: ./files/sequences/diagram13_skinparam2.puml

.. uml:: ./files/sequences/diagram13_skinparam2.puml


填充区设置
==========

.. literalinclude:: ./files/sequences/diagram14_padding.puml

.. uml:: ./files/sequences/diagram14_padding.puml









.. [1] https://plantuml.com/zh/sequence-diagram