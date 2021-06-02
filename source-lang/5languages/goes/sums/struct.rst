struct结构
##########

基本
====

字段
----

填充字段::

    struct {
        x, y int
        _ float32  // 填充
        A *[]int
    }

匿名字段::

    struct {
        T1          // 字段名 T1
        *T2         // 字段名 T2
        P.T3        // 字段名 T3
        *P.T4       // 字段名T4
        x, y int    // 字段名 x 和 y
    }

实例化::

    var t T         // 给 t 分配内存，并零值化内存，这时 t 是类型T
    t := new(T)     // 变量 t 是一个指向 T的指针, 即*T
    var p *T   // p是指向一个结构体类型变量的指针

    表达式 new(Type) 和 &Type{} 是等价的。
    &struct1{a, b, c} 是一种简写，底层仍然会调用 new ()

    origin := Point3D{}                             //  Point3D 是零值
    line := Line{origin, Point3D{y: -4, z: 12.3}}   //   line.q.x 是零值


标签(tag)
---------

标签的内容不可以在一般的编程中使用，只有 reflect 包能获取它::

    type Student struct {
        name string "学生名字"          // 结构体标签
        Room int    `json:"Roomid"` // 结构体标签
    }
    func main() {
        st := Student{"Titan", 14}
        fmt.Println(reflect.TypeOf(st).Field(0).Tag)  // 学生名字
        fmt.Println(reflect.TypeOf(st).Field(1).Tag)  // json:"Roomid"
    }

匿名成员
--------

.. note:: Go语言结构体中可以包含一个或多个匿名（内嵌）字段，即这些字段没有显式的名字，只有字段的类型是必须的，此时类型就是字段的名字（这一特征决定了在一个结构体中，每种数据类型只能有一个匿名字段）

嵌入与聚合
----------

1. 在接口中嵌入接口::

    相当于合并了两个接口类型定义的全部函数

2. 在接口中嵌入结构体(不合法)
3. 在结构体中内嵌接口::

    初始化的时候，内嵌接口要用一个实现此接口的结构体赋值
    这个新结构体可作为初始化时实现了内嵌接口的结构体来赋值

4. 在结构体中嵌入结构体::

    不能嵌入自身值类型，可以嵌入自身的指针类型即递归嵌套
    在初始化时，内嵌结构体也进行赋值；外层结构自动获得内嵌结构体所有定义的字段和实现的方法

语法糖::

    stu := new(Student)
    fmt.Printf("%d\n", stu.name)    // 相当于: (*stu).name, 这是一个语法糖

内嵌结构体的字段::

    stu.Human.name
    如果外层结构体中没有同名的name字段，也可用: stu.name

命名冲突
--------

当两个字段拥有相同的名字（可能是继承来的名字）时该怎么办呢？外层名字会覆盖内层名字（但是两者的内存空间都保留）。
如果相同的名字在同一级别出现了两次，如果这个名字被程序使用了，将会引发一个错误，但不使用没关系

下面代码中如果写成 c.a 是错误的::

    type A struct {a int}
    type B struct {a, b int}

    type C struct {A; B}
    var c C

    fmt.Printf(c.A.a, c.B.a)    // ✅
    fmt.Printf(c.a)             // 🚫

值接收者和指针接收者
====================

纯结构体实现
------------

在调用方法的时候::

    值类型既可以调用值接收者的方法，也可以调用指针接收者的方法；
    指针类型既可以调用指针接收者的方法，也可以调用值接收者的方法

.. note:: 不管方法的接收者是什么类型，该类型的值和指针都可以调用

结构体类型::

    type Person struct {
      age int
    }

    func (p Person) howOld() int {
      return p.age
    }
    func (p *Person) growUp() {
      p.age += 1
    }

1. 值类型::

    func main() {
      qcrao := Person{age: 18}

      // 值类型 调用接收者也是值类型的方法
      fmt.Println(qcrao.howOld())     // 18

      // 值类型 调用接收者是指针类型的方法
      qcrao.growUp()    // 语法糖1️⃣实际上调用的是: (&qcrao).growUp()
      fmt.Println(qcrao.howOld())     // 19
    }

2. 指针类型::

    func main() {
      stefno := &Person{age: 100}

      // 指针类型 调用接收者是值类型的方法
      fmt.Println(stefno.howOld())    // 100: (语法糖2️⃣实际上调用的是: (*stefno).howOld())

      // 指针类型 调用接收者也是指针类型的方法
      stefno.growUp()
      fmt.Println(stefno.howOld())    // 101
    }

接口实现
--------

定义接口::

    type Human interface {
      howOld() int
      growUp()
    }

1. 指针类型请求值类型✅::

    func main() {
      var c Human = &Person{18}
      fmt.Println(c.howOld())
      c.growUp()
      fmt.Println(c.howOld())
    }

2. 值类型请求指针类型🚫::

    func main() {
      var c Human = Person{18}
      fmt.Println(c.howOld())
      c.growUp()  // 🚫
      fmt.Println(c.howOld())
    }
    ./prog.go:23:11: cannot use Person literal (type Person) as type Human in assignment:
      Person does not implement Human (growUp method has pointer receiver)

.. note:: 如果实现了接收者是值类型的方法，会隐含地也实现了接收者是指针类型的方法。如果方法的接收者是值类型，无论调用者是对象还是对象指针，修改的都是对象的副本，不影响调用者；如果方法的接收者是指针类型，则调用者修改的是指针指向的对象本身。


值类型&对象指针分别在何时使用
-----------------------------

* 如果方法的接收者是值类型，无论调用者是对象还是对象指针，修改的都是对象的副本，不影响调用者
* 如果方法的接收者是指针类型，则调用者修改的是指针指向的对象本身

.. note:: 使用指针作为方法的接收者的理由：1.方法能够修改接收者指向的值。2.避免在每次调用方法时复制该值，在值的类型为大型结构体时，这样做会更加高效。





匿名结构体&匿名接口
===================

sort包中有这么一个interface，实现了数组的大小比较::

    type Interface interface {
        Less(i, j int) bool
    }

    // Array 实现Interface接口
    type Array []int

    func (arr Array) Less(i, j int) bool {
        return arr[i] < arr[j]
    }

匿名结构体
----------

上面实现了比较大小，如果第i个元素比第j个元素小返回true，现在想实现反过来的功能，即当第i元素小于第j个元素时返回false，则::

    // 使用匿名struct
    type reverse struct {
        Array
    }

    // 重写Less方法
    func (r reverse) Less(i, j int) bool {
        return r.Array.Less(j, i)
    }

    // 构造reverse Interface
    func Reverse(data Array) Interface {
        return &reverse{data}
    }

使用::

    func main() {
        arr := Array{1, 2, 3}
        rarr := Reverse(arr)
        fmt.Println(arr.Less(0, 1))
        fmt.Println(rarr.Less(0, 1))
    }

匿名嵌入类型方法集提升的规则::

    1. 如果 S 包含一个匿名字段 T，S 和 *S 的方法集都包含接收器为 T 的方法提升
    2. 如果 S 包含一个匿名字段 T， *S 类型的方法集包含接收器为 *T 的方法提升
    3. 如果 S 包含一个匿名字段 *T，S 和 *S 的方法集都包含接收器为 T 或者 *T 的方法提升 





匿名接口
--------

上面是 ``匿名接口体`` 的实现，现在来看看使用 ``匿名接口`` 的实现::

    // 匿名接口(anonymous interface)
    type reverse struct {
        Interface
    }

    // 重写(override)
    func (r reverse) Less(i, j int) bool {
        return r.Interface.Less(j, i)
    }

    // 构造reverse Interface
    func Reverse(data Interface) Interface {
        return &reverse{data}
    }

使用::

    func main() {
        arr := Array{1, 2, 3}
        rarr := Reverse(arr)
        fmt.Println(arr.Less(0,1))
        fmt.Println(rarr.Less(0,1))
    }

总结
----

上面的2个实例看， ``匿名接口`` 与 ``匿名结构体`` 的实现非常相似。但是仔细对比一下你就会发现匿名接口的优点，匿名接口的方式不依赖具体实现，可以对任意实现了该接口的类型进行重写。这在写一些公共库时会非常有用，如果你经常看一些库的源码，匿名接口的写法应该会很眼熟。


对结构体添加一些约束
--------------------

再增加一个Array2类型::

    type Array2 []int

    func (arr Array2) Less(i, j int) bool {
        return arr[i] < arr[j]
    }

增加额外字段type::

    type Sortable struct {
        Interface
        // other field
        Type string
    }

    func NewSortable(i Interface) Sortable {
        t := reflect.TypeOf(i).String()

        return Sortable{
            Interface: i,
            Type:      t,
        }
    }

使用::

    func DoSomething(s Sortable) {
        fmt.Println(s.Type)         // 打印为Array或Array2
        fmt.Println(s.Less(0, 1))   // 等同于s.Interface.Less(0, 1)
    }

    func main() {
        arr1 := Array1{1, 2, 3}
        arr2 := Array2{3, 2, 1, 0}

        DoSomething(NewSortable(arr1))
        DoSomething(NewSortable(arr2))
    }

总结
----




参考
====

* https://segmentfault.com/a/1190000018865258
* https://wizardforcel.gitbooks.io/go42/content/content/42_18_struct.html
