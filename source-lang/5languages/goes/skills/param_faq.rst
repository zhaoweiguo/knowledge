变量疑难杂症
############


惰性求值和闭包
==============

实例::

    a := []int{1,2,3}
    for _, i:= range a {
      go func() {
        fmt.Println(i)
      }()
    }
    time.Sleep(time.Second)
    // Output:
    // 3
    // 3
    // 3


检索关键字::

    glang faq loop closure
    闭包的特性
    可以通过 go vet命令来检查程序中类似的问题

两种解决方法。其中第一种方法很好理解，就是把变量v的值通过参数的形式传递给goroutine，因为go中func的参数传递都是值传递，所以就在goroutine启动时获得了当前v变量的值::

    for _, v := range values {
        go func(u string) {
            fmt.Println(u)
            done <- true
        }(v)
    }

第二种方法是更巧妙地通过一个赋值语句来解决的::

    for _, v := range values {
        v := v // create a new 'v'.
        go func() {
            fmt.Println(v)
        }()
    }

.. note:: In Go, the loop iterator variable is a single variable that takes different values in each loop iteration. This is very efficient, but might lead to unintended behavior when used incorrectly.


同样类似 ``loop iteration variable`` 的问题还有这种::

    // Using reference to loop iterator variable
    // Due to efficiency, the loop iterator variable is 
        // a single variable that takes different values in each loop iteration. 
    in := []int{1, 2, 3}

    var out []*int
    for  _, v := range in {
        out = append(out, &v)
    }

    fmt.Println("Values:", *out[0], *out[1], *out[2])
    fmt.Println("Addresses:", out[0], out[1], out[2])

    output:
    // Values: 3 3 3
    // Addresses: 0xc000014188 0xc000014188 0xc000014188

    原因:
        range 中的 value 使用相同的指针地址
    解决方法:
    for  _, v := range in {
        v = v // create a new 'v'.
        out = append(out, &v)
    }


.. note:: This behavior of the language, not defining a new variable for each iteration, may have been a mistake in retrospect. It may be addressed in a later version but, for compatibility, cannot change in Go version 1.

关于 ``single variable`` 的说明::

    a := 123
    fmt.Printf("%v\n", a)
    fmt.Printf("%v\n", &a)
    a = 456
    fmt.Printf("%v\n", a)
    fmt.Printf("%v\n", &a)

    // 打印:
    123
    0xc000018050
    456
    0xc000018050



* 扩展阅读:

  * https://github.com/golang/go/wiki/CommonMistakes
  * https://golang.org/doc/faq#closures_and_goroutines
  * https://github.com/talkgo/night/blob/master/content/discuss/2018-05-21-using-goroutines-on-loop-iterator-variables.md


指针与切片实例
==============

以下代码输出什么::

    s:="123"
    ps:=&s
    b:=[]byte(s)
    pb:=&b

    s+="4"
    *ps+="5"
    (*pb)[1] = 0
    (*pb)[2] = 4

    fmt.Printf("%+v\n",*ps)
    fmt.Printf("%+v\n",*pb)

答案::

    "12345"和[49,0,4]

关键在于::

    b:=[]byte(s)

说明::

    A string contains an array of bytes that, once created, is immutable. 
    By contrast, the elements of a byte slice can be freely modified.
    Strings can be converted to byte slices and back again:

    s := “abc”
    b := []byte(s)
    s2 := string(b)

    Conceptually, the []byte(s) conversion allocates a new byte array 
        holding a copy of the bytes of s, 
        and yields a slice that references the entirety of that array. 
    An optimizing compiler may be able to avoid the allocation and copying in some cases, 
        but in general copying is required to ensure that the bytes of s remain unchanged 
        even if those of b are subsequently modified. 
    The conversion from byte slice back to string with string(b) also makes a copy, 
        to ensure immutability of the resulting string s2.


* 扩展阅读:

    * https://github.com/talkgo/night/blob/master/content/discuss/2018-05-22-go-string-to-byte-slice.md
    * https://gocn.io/question/265
    * https://gocn.io/article/704
    * https://blog.golang.org/strings
    * https://sheepbao.github.io/post/golang_byte_slice_and_string/
    * http://nanxiao.me/golang-string-byte-slice-conversion/








