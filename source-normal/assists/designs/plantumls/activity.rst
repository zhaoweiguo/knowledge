活动图
######

* 活动图 (新语法) [1]_
* 活动图（老语法） [2]_

.. note:: 旧语法有诸多限制和缺点，比如代码难以维护。所以从 V7947 开始提出一种全新的、更好的语法格式和软件实现供用户使用 (beta 版)。就像序列图一样，新的软件实现的另一个优点是它不再依赖于 Graphviz。新的语法将会替换旧的语法。然而考虑到兼容性，旧的语法仍被能够使用以确保 向前兼容

.. warning::  这儿只讲新版

简单活动图
==========

说明::

    活动标签 (activity label) 以冒号开始，以分号结束

::

    @startuml
    :Hello world;
    :This is on defined on
    several **lines**;
    @enduml

.. uml::

    @startuml
    :Hello world;
    :This is on defined on
    several **lines**;
    @enduml

开始 / 结束
===========

使用关键字 start 和 stop 表示图示的开始和结束:

.. literalinclude:: ./files/activities/simple.puml

.. uml:: ./files/activities/simple.puml

使用 end 关键字:

.. literalinclude:: ./files/activities/simple2.puml

.. uml:: ./files/activities/simple2.puml

条件语句
========

使用关键字 if，then 和 else 设置分支测试。标注文字则放在括号中:

.. literalinclude:: ./files/activities/condition.puml

.. uml:: ./files/activities/condition.puml

使用关键字 elseif 设置多个分支测试:

.. literalinclude:: ./files/activities/condition.puml

.. uml:: ./files/activities/condition.puml

Conditional with error on an action:

.. literalinclude:: ./files/activities/condition_error.puml

.. uml:: ./files/activities/condition_error.puml

Conditional with detach on an action:

.. literalinclude:: ./files/activities/condition_detach.puml

.. uml:: ./files/activities/condition_detach.puml


重复循环
========

repeat循环
----------

使用关键字 repeat 和 repeatwhile 进行重复循环:

.. literalinclude:: ./files/activities/repeat1.puml

.. uml:: ./files/activities/repeat1.puml

backward keyword:

.. literalinclude:: ./files/activities/repeat2.puml

.. uml:: ./files/activities/repeat2.puml

break keyword:

.. literalinclude:: ./files/activities/repeat3.puml

.. uml:: ./files/activities/repeat3.puml


while循环
---------

使用关键字 while 和 end while:

.. literalinclude:: ./files/activities/while1.puml

.. uml:: ./files/activities/while1.puml

在关键字 endwhile 后添加标注，还有一种方式是使用关键字 is:

.. literalinclude:: ./files/activities/while2.puml

.. uml:: ./files/activities/while2.puml

并行处理
========

使用关键字 fork，fork again 和 end fork 表示并行处理:

.. literalinclude:: ./files/activities/split1.puml

.. uml:: ./files/activities/split1.puml

split, split again and end split keywords:

.. literalinclude:: ./files/activities/split1.puml

.. uml:: ./files/activities/split1.puml

Input split (multi-start):

.. literalinclude:: ./files/activities/split3_multi_input.puml

.. uml:: ./files/activities/split3_multi_input.puml

Output split (multi-end):



.. literalinclude:: ./files/activities/split4_multi_output.puml

.. uml:: ./files/activities/split4_multi_output.puml


注释
====

.. literalinclude:: ./files/activities/note1.puml

.. uml:: ./files/activities/note1.puml





特殊领域语言 (SDL)
==================

修改活动标签最后的分号分隔符 (;)，可以为活动设置不同的形状::

    |
    <
    >
    /
    ]
    }

.. literalinclude:: ./files/activities/sdl1.puml

.. uml:: ./files/activities/sdl1.puml







.. [1] https://plantuml.com/zh/activity-diagram-beta
.. [2] https://plantuml.com/zh/activity-diagram-legacy