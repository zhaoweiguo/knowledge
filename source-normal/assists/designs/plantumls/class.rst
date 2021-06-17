类图 [1]_
#########

类之间的关系
============

.. image:: /images/sphinxdocs/plantumls/relation1.png

实例::

    @startuml
    Class01 <|-- Class02
    Class03 *-- Class04
    Class05 o-- Class06
    Class07 .. Class08
    Class09 -- Class10
    @enduml

.. image:: /images/sphinxdocs/plantumls/relation2.png


可访问性
========

+-----------+-------------------------+--------------------------+-----------------+
| Character | Icon for field          | Icon for method          | Visibility      |
+===========+=========================+==========================+=================+
| -         | |private-field|         | |private-method|         | private         |
+-----------+-------------------------+--------------------------+-----------------+
| #         | |protected-field|       | |protected-method|       | protected       |
+-----------+-------------------------+--------------------------+-----------------+
| ~         | |package-private-field| | |package-private-method| | package private |
+-----------+-------------------------+--------------------------+-----------------+
| +         | |public-field|          | |public-method|          | public          |
+-----------+-------------------------+--------------------------+-----------------+

实例::

    @startuml

    class Dummy {
     -field1
     #field2
     ~method1()
     +method2()
    }

    @enduml

.. uml::

    @startuml

    class Dummy {
     -field1
     #field2
     ~method1()
     +method2()
    }
    @enduml

你可以采用以下命令停用这些特性 skinparam classAttributeIconSize 0::

    @startuml
    skinparam classAttributeIconSize 0
    class Dummy {
     -field1
     #field2
     ~method1()
     +method2()
    }
    @enduml

.. uml::

    @startuml
    skinparam classAttributeIconSize 0
    class Dummy {
     -field1
     #field2
     ~method1()
     +method2()
    }
    @enduml


高级类体
========

定义分隔符来重排方法和属性::

    --
    ..
    ==
    __

实例:

.. literalinclude:: ./files/classes/class1_advance.puml

.. uml:: ./files/classes/class1_advance.puml

备注和模板
==========

你可以使用这些关键字来添加备注::

    note left of , 
    note right of , 
    note top of , 
    note bottom of

你还可以在类的声明末尾来添加备注::

    note left, 
    note right,
    note top, 
    note bottom

实例:

.. literalinclude:: ./files/classes/class2_remark.puml

.. uml:: ./files/classes/class2_remark.puml

包
===

你可以通过关键词 package 声明包::

    同时可选的来声明对应的背景色（通过使用html色彩代码或名称）
    注意：包可以被定义为嵌套

    包可以定义不同的样式。
    你可以通过以下的命令来设置默认样式 : skinparam packageStyle,或者对包使用对应的模板:


实例1:


.. literalinclude:: ./files/classes/class3_package.puml

.. uml:: ./files/classes/class3_package.puml

实例-包样式:


.. literalinclude:: ./files/classes/class4_package.puml

.. uml:: ./files/classes/class4_package.puml

命名空间(Namespaces)
====================

::

    在使用包（package）时（区别于命名空间），类名是类的唯一标识。 
    也就意味着，在不同的包（package）中的类，不能使用相同的类名。
    
    在那种情况下，你应该使用命名空间来取而代之。
    你可以从其他命名空间，使用全限定名来引用类， 
    默认命名空间下的类，以一个“."开头（的类名）来引用
    注意：你不用显示地创建命名空间：一个使用全限定名的类会自动被放置到对应的命名空间。

实例:


.. literalinclude:: ./files/classes/class5_ns.puml

.. uml:: ./files/classes/class5_ns.puml


自动创建命名空间::

.. literalinclude:: ./files/classes/class6_ns.puml

.. uml:: ./files/classes/class6_ns.puml


箭头方向
========

::

    类之间默认采用两个破折号 -- 显示出垂直 方向的线. 
    要得到水平方向的可以像这样使用单破折号 (或者点):

实例::

    @startuml
    Room o- Student
    Room *-- Chair
    @enduml

.. uml::

    @startuml
    Room o- Student
    Room *-- Chair
    @enduml

可通过在箭头内部使用关键字， 例如left, right, up 或者 down，来改变方向::

    @startuml
    foo -left-> dummyLeft
    foo -right-> dummyRight
    foo -up-> dummyUp
    foo -down-> dummyDown
    @enduml

.. uml::

    @startuml
    foo -left-> dummyLeft
    foo -right-> dummyRight
    foo -up-> dummyUp
    foo -down-> dummyDown
    @enduml

皮肤参数 [2]_
==============


.. literalinclude:: ./files/classes/class7_skin.puml

.. uml:: ./files/classes/class7_skin.puml


Skinned Stereotypes:

.. literalinclude:: ./files/classes/class8_skin.puml

.. uml:: ./files/classes/class8_skin.puml


Extends and implements
======================

::

    @startuml
    class ArrayList implements List
    class ArrayList extends AbstractList
    @enduml

.. uml::

    @startuml
    class ArrayList implements List
    class ArrayList extends AbstractList
    @enduml



.. |private-field| image:: ./icon/private-field.png
.. |private-method| image:: ./icon/private-method.png
.. |public-field| image:: ./icon/public-field.png
.. |public-method| image:: ./icon/public-method.png
.. |protected-field| image:: ./icon/protected-field.png
.. |protected-method| image:: ./icon/protected-method.png
.. |package-private-field| image:: ./icon/package-private-field.png
.. |package-private-method| image:: ./icon/package-private-method.png


.. [1] https://plantuml.com/zh/class-diagram
.. [2] https://plantuml.com/zh/skinparam