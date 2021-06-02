程序执行顺序
##############

同一文件
========

初始化顺序::

    常量初始化->变量初始化->init()->main()

多个import执行顺序::

    import (
        sub1
        sub2
        sub3
    )

    sub1.init() -> sub2.init() -> sub3.init()


同一包
======

同一个包的init执行顺序，golang没有明确定义，编程时要注意程序不要依赖这个执行顺序




多级包
======

.. figure:: /images/languages/golangs/skill_import_init_order.png

   import包&init函数执行顺序

多级包的init函数按照包导入的依赖关系决定执行顺序







