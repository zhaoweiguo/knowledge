类型
####

基础类型
========

基础类型有下面几种::

    bool byte complex64 complex128 error float32 float64
    int int8 int16 int32 int64 rune string
    uint uint8 uint16 uint32 uint64 uintptr

原始的数值类型包括::

    bool, 
    uint, uint8, uint16, uint32, uint64, 
    int, int8, int16, int32, int64, 
    float32, float64


自定义类型
==========

type 语法::
    
    type IZ int

类型别名::

    type IZ = int
    // 类型别名在1.9中实现，可将别名类型和原类型这两个类型视为完全一致使用

自定义类型不会继承原有类型的方法，但接口方法或组合类型的内嵌元素则保留原有的方法::


    //  Mutex 用两种方法，Lock and Unlock。
    type Mutex struct         { /* Mutex fields */ }
    func (m *Mutex) Lock()    { /* Lock implementation */ }
    func (m *Mutex) Unlock()  { /* Unlock implementation */ }

    1. NewMutex和 Mutex 一样的数据结构，但是其方法是空的。
    type NewMutex Mutex

    2. PtrMutex 的方法也是空的
    type PtrMutex *Mutex

    3. *PrintableMutex 拥有Lock and Unlock 方法
    type PrintableMutex struct {
        Mutex
    }


类型转换和断言
==============

Go 语言中不允许隐式类型转换，也就是说 = 两边，不允许出现类型不相同的变量。类型转换、类型断言本质都是把一个类型转换成另外一个类型。不同之处在于，类型断言是对接口变量进行的操作

类型转换
--------

语法::

    <结果类型> := <目标类型> ( <表达式> )

实例::

    f = 10.8
    a := int(f)


断言
----

语法::

    <目标类型的值>，<布尔参数> := <表达式>.( 目标类型 )   // 1. 安全类型断言
    <目标类型的值> := <表达式>.( 目标类型 )　　          // 2. 非安全类型断言

类型断言::

    var i interface{} = new(Student)
    s := i.(*Student)

Type-switch::

    switch v := v.(type) {
    case nil:
      fmt.Printf("%p %v\n", &v, v)

    case Student:
      fmt.Printf("%p %v\n", &v, v)

其他
----

::

    string转int：    int, err := strconv.Atoi(string)
    string转int64：  int64, err := strconv.ParseInt(string, 10, 64)
    int转string：    string := strconv.Itoa(int)
    int64转string：  string := strconv.FormatInt(int64, 10)



Unicode(UTF-8)
==============

::

    077         // 8进制
    0xFF        // 16进制

在书写 Unicode 字符时，需要在 16 进制数之前加上前缀 \u 或者 \U::

        var ch int = '\u0041'           // 前缀 \u 则跟着长度为 4 的 16 进制数
        var ch3 int = '\U00101234'      // 前缀 \U 紧跟着长度为 8 的 16 进制数










