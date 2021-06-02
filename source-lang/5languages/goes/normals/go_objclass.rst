面向对象编程
==================

为任意类型增加方法::

    type Integer int
    func (a Integer) Less(b Integer) bool {
        return a < b
    }
    // 使用
    var a Integer = 1
    a.Less(2)

接口::

    非侵入式接口

类型::

    var v1 interface{}
    v1.(type)   // 变量v1的类型: int, string








