可能混淆的
##########

方法(method)&函数(function)
===========================

定义方法的一般格式::

    func (recv receiver_type) methodName(parameter_list) (return_value_list) { ... }

方法与函数之间最大的区别::

    方法只是比函数多了一个接收器（receiver）

指针方法和值方法最大的区别::

    如果想要方法改变接收器的数据，就在接收器的指针上定义该方法；
    否则，就在普通的值类型上定义方法。

::

    有类型T，方法的接收器为(t T)时我们称为值接收器，该方法称为值方法；
    方法的接收器为(t *T)时我们称为指针接收器，该方法称为指针方法。

数组切片
========

数组定义::

    1. 声明数组
    var variable_name [SIZE] variable_type
    实例:
    var balance [10] float32

    2. 初始化数组
    2.1 设置数组大小
    var balance = [5]float32{1000.0, 2.0, 3.4, 7.0, 50.0}
    2.2 默认数组大小
    var balance = [...]float32{1000.0, 2.0, 3.4, 7.0, 50.0}

    3. 访问数组元素
    var salary float32 = balance[9]
    balance[9] = 23.1

切片定义::

    切片是对数组的抽象
    数组的长度不可改变，在特定场景中这样的集合就不太适用，于是就需要切片（动态数组）
    与数组相比切片的长度是不固定的，可以追加元素，在追加时可能使切片的容量增大

    1. 定义切片
      var identifier []type
      or
      var slice1 []type = make([]type, len)
      or 简写成
      slice1 := make([]type, len)
      or 也可以指定容量
      slice1 := make([]T, length, capacity)  // capacity可选


    2. 切片初始化
      2.1 直接初始化切片
        s :=[] int {1,2,3 } 
      2.2 数组的引用
        s := arr[startIndex:endIndex] 

    3. len() 和 cap() 函数
    4. append() 和 copy() 函数
    5. 空(nil)切片
       var numbers []int
    6. 切片截取
      通过设置下限及上限来设置截取切片 [lower-bound:upper-bound]


切片&数组::

    1. 指向原生数组的指针
    2. 数组切片中元素个数
    3. 数组切片已分配的存储空间

    创建切片有2种方法:
    1. 基于数组创建切片
    2. 直接创建切片

    切片是基于数组实现的，它的底层是数组，它自己本身非常小，可以理解为对底层数组的抽象

    // 基于数组创建数组切片
    var mySlice1 int[] = myArray[:5]   // (前5个元素)
    var mySlice2 int[] = myArray[:]   // 基于所有元素创建数组

    // 直接创建数组切片
    var mySlice1 int[] = make([]int, 5)        // 初使元素个数为5, 初始值为0
    var mySlice2 int[] = make([]int, 5, 10)    // 初使元素个数为5, 初始值为10
    mySlice3 := []int{1, 2, 3, 4, 5}      // 创建并初使化包含5个元素的数组切片

    //基于数组切片创建数组切片
    oldSlice := []int{1, 2, 3, 4, 5}
    newSlice := oldSlice[:3]
    newSlice2 := oldSlice[:72]   // 超出部分置0(不能超出cap())

    // 内容复制
    slice1 := []int{1, 2, 3, 4, 5}
    slice2 := []int{1, 2, 3}

    copy(slice1, slice2)    // 只复制slice2的前3个元素到slice1
    copy(slice2, slice1)    // 只复制slice1的前3个元素到slice2的前三个位置










