spec [1]_
#########

类型
====

常用类型::

    Boolean types
    String types
    Array types
    Slice types
    Struct types
    Pointer types
    Function types
    Interface types
    Map types
    Channel types
    Numeric types

Numeric types::

    uint8       the set of all unsigned  8-bit integers (0 to 255)
    uint16      the set of all unsigned 16-bit integers (0 to 65535)
    uint32      the set of all unsigned 32-bit integers (0 to 4294967295)
    uint64      the set of all unsigned 64-bit integers (0 to 18446744073709551615)

    int8        the set of all signed  8-bit integers (-128 to 127)
    int16       the set of all signed 16-bit integers (-32768 to 32767)
    int32       the set of all signed 32-bit integers (-2147483648 to 2147483647)
    int64       the set of all signed 64-bit integers (-9223372036854775808 to 9223372036854775807)

    float32     the set of all IEEE-754 32-bit floating-point numbers
    float64     the set of all IEEE-754 64-bit floating-point numbers

    complex64   the set of all complex numbers with float32 real and imaginary parts
    complex128  the set of all complex numbers with float64 real and imaginary parts

    byte        alias for uint8
    rune        alias for int32

    uint     either 32 or 64 bits
    int      same size as uint
    uintptr  an unsigned integer large enough to store the uninterpreted bits of a pointer value

算数相关::

    x     x / 4     x % 4     x >> 2     x & 3
     11      2         3         2          3
    -11     -2        -3        -3          1

运算操作::

    ==    equal
    !=    not equal
    <     less
    <=    less or equal
    >     greater
    >=    greater or equal


Iota::

    const (
      c0 = iota  // c0 == 0
      c1 = iota  // c1 == 1
      c2 = iota  // c2 == 2
    )

    const (
      a = 1 << iota  // a == 1  (iota == 0)
      b = 1 << iota  // b == 2  (iota == 1)
      c = 3          // c == 3  (iota == 2, unused)
      d = 1 << iota  // d == 8  (iota == 3)
    )

    const (
      u         = iota * 42  // u == 0     (untyped integer constant)
      v float64 = iota * 42  // v == 42.0  (float64 constant)
      w         = iota * 42  // w == 84    (untyped integer constant)
    )

    const x = iota  // x == 0
    const y = iota  // y == 0

    const (
      bit0, mask0 = 1 << iota, 1<<iota - 1  // bit0 == 1, mask0 == 0  (iota == 0)
      bit1, mask1                           // bit1 == 2, mask1 == 1  (iota == 1)
      _, _                                  //                        (iota == 2, unused)
      bit3, mask3                           // bit3 == 8, mask3 == 7  (iota == 3)
    )

类型转换
========

::

    *Point(p)        // same as *(Point(p))
    (*Point)(p)      // p is converted to *Point
    <-chan int(c)    // same as <-(chan int(c))
    (<-chan int)(c)  // c is converted to <-chan int
    func()(x)        // function signature func() x
    (func())(x)      // x is converted to func()
    (func() int)(x)  // x is converted to func() int
    func() int(x)    // x is converted to func() int (unambiguous)

常量转化会产生一个类型化的常量::

    uint(iota)               // iota value of type uint
    float32(2.718281828)     // 2.718281828 of type float32
    complex128(1)            // 1.0 + 0.0i of type complex128
    float32(0.49999999)      // 0.5 of type float32
    float64(-1e-1000)        // 0.0 of type float64
    string('x')              // "x" of type string
    string(0x266c)           // "♬" of type string
    MyString("foo" + "bar")  // "foobar" of type MyString
    string([]byte{'a'})      // not a constant: []byte{'a'} is not a constant
    (*int)(nil)              // not a constant: nil is not a constant, *int is not a boolean, numeric, or string type
    int(1.2)                 // illegal: 1.2 cannot be represented as an int
    string(65.0)             // illegal: 65.0 is not an integer constant

字符串相关转换::

    1. 有效unicode会转化成串, 无效unicode会转化为\uFFFD
    string('a')       // "a"
    string(-1)        // "\ufffd" == "\xef\xbf\xbd"
    string(0xf8)      // "\u00f8" == "ø" == "\xc3\xb8"
    type MyString string
    MyString(0x65e5)  // "\u65e5" == "日" == "\xe6\x97\xa5"

    2. []byte -> string
    string([]byte{'h', 'e', 'l', 'l', '\xc3', '\xb8'})   // "hellø"
    string([]byte{})                                     // ""
    string([]byte(nil))                                  // ""
    type MyBytes []byte
    string(MyBytes{'h', 'e', 'l', 'l', '\xc3', '\xb8'})  // "hellø"

    3. []runes -> string
    string([]rune{0x767d, 0x9d6c, 0x7fd4})   // "\u767d\u9d6c\u7fd4" == "白鵬翔"
    string([]rune{})                         // ""
    string([]rune(nil))                      // ""

    type MyRunes []rune
    string(MyRunes{0x767d, 0x9d6c, 0x7fd4})  // "\u767d\u9d6c\u7fd4" == "白鵬翔"

    4. string -> []byte
    []byte("hellø")   // []byte{'h', 'e', 'l', 'l', '\xc3', '\xb8'}
    []byte("")        // []byte{}
    MyBytes("hellø")  // []byte{'h', 'e', 'l', 'l', '\xc3', '\xb8'}

    5. string -> []runes
    []rune(MyString("白鵬翔"))  // []rune{0x767d, 0x9d6c, 0x7fd4}
    []rune("")                 // []rune{}
    MyRunes("白鵬翔")           // []rune{0x767d, 0x9d6c, 0x7fd4}

常数表达式(自动格式转换)::

    const a = 2 + 3.0          // a == 5.0   (untyped floating-point constant)
    const b = 15 / 4           // b == 3     (untyped integer constant)
    const c = 15 / 4.0         // c == 3.75  (untyped floating-point constant)
    const Θ float64 = 3/2      // Θ == 1.0   (type float64, 3/2 is integer division)
    const Π float64 = 3/2.     // Π == 1.5   (type float64, 3/2. is float division)
    const d = 1 << 3.0         // d == 8     (untyped integer constant)
    const e = 1.0 << 3         // e == 8     (untyped integer constant)
    const f = int32(1) << 33   // illegal    (constant 8589934592 overflows int32)
    const g = float64(2) >> 1  // illegal    (float64(2) is a typed floating-point constant)
    const h = "foo" > "bar"    // h == true  (untyped boolean constant)
    const j = true             // j == true  (untyped boolean constant)
    const k = 'w' + 1          // k == 'x'   (untyped rune constant)
    const l = "hi"             // l == "hi"  (untyped string constant)
    const m = string(k)        // m == "x"   (type string)
    const Σ = 1 - 0.707i       //            (untyped complex constant)
    const Δ = Σ + 2.0e-4       //            (untyped complex constant)
    const Φ = iota*1i - 1/1i   //            (untyped complex constant)

语句
====

Terminating statements::

    return
    goto
    panic
    以及正常结束

Empty statements::

    The empty statement does nothing.

Labeled statements::

    A labeled statement may be the target of a goto, break or continue statement.

Expression statements::

    h(x+y)
    f.Close()
    <-ch
    (<-ch)
    len("foo")  // illegal if len is the built-in function

Send statements::

    ch <- 3  // send value 3 to channel ch

IncDec statements::

    x++                 x += 1
    x--                 x -= 1

Assignments::

    x = 1
    *p = f()
    a[i] = 23
    (k) = <-ch  // same as: k = <-ch

If statements::

    if x > max {
      x = max
    }

Switch statements::

    1. Expression switches
    switch tag {
    default: s3()
    case 0, 1, 2, 3: s1()
    case 4, 5, 6, 7: s2()
    }


    2. Type switches
    switch i := x.(type) {
    case nil:
      printString("x is nil")                // type of i is type of x (interface{})
    case int:
      printInt(i)                            // type of i is int
    case float64:
      printFloat64(i)                        // type of i is float64
    case func(int) float64:
      printFunction(i)                       // type of i is func(int) float64
    case bool, string:
      printString("type is bool or string")  // type of i is type of x (interface{})
    default:
      printString("don't know the type")     // type of i is type of x (interface{})
    }

For statements::

    1. For statements with single condition
    for a < b {
      a *= 2
    }

    2. For statements with for clause
    for i := 0; i < 10; i++ {
      f(i)
    }

    3. For statements with range clause
    for i, _ := range testdata.a {
      f(i)
    }

Go statements::

    go Server()
    go func(ch chan<- bool) { for { sleep(10); ch <- true }} (c)

Select statements::

    select {
    case i1 = <-c1:
      print("received ", i1, " from c1\n")
    case c2 <- i2:
      print("sent ", i2, " to c2\n")
    }

    for {  // send random sequence of bits to c
      select {
      case c <- 0:  // note: no statement, no fallthrough, no folding of cases
      case c <- 1:
      }
    }

Return statements::

    func noResult() {
      return
    }

Break statements::

    OuterLoop:
      for i = 0; i < n; i++ {
        for j = 0; j < m; j++ {
          switch a[i][j] {
          case nil:
            state = Error
            break OuterLoop
          case item:
            state = Found
            break OuterLoop
          }
        }
      }

Continue statements::

    RowLoop:
      for y, row := range rows {
        for x, data := range row {
          if data == endOfRow {
            continue RowLoop
          }
          row[x] = data + bias(x, y)
        }
      }

Goto statements::

      goto L  // BAD(跳过了v的定义)
      v := 3
    L:
      xxx

Fallthrough statements::

    与switch接合用

Defer statements::

    lock(l)
    defer unlock(l)  // unlocking happens before surrounding function returns

    // prints 3 2 1 0 before surrounding function returns
    for i := 0; i <= 3; i++ {
      defer fmt.Print(i)
    }

    // f returns 42
    func f() (result int) {
      defer func() {
        // result is accessed after it was set to 6 by the return statement
        result *= 7
      }()
      return 6
    }

Built-in functions
==================

Close::

    var c chan
    close(c)

Length and capacity::

    len(s)    string type      string length in bytes
              [n]T, *[n]T      array length (== n)
              []T              slice length
              map[K]T          map length (number of defined keys)
              chan T           number of elements queued in channel buffer

    cap(s)    [n]T, *[n]T      array length (== n)
              []T              slice capacity
              chan T           channel buffer capacity

    0 <= len(s) <= cap(s)

Allocation::

    type S struct { a int; b float64 }
    new(S)

Making slices, maps and channels::

    make(T, n)       slice      slice of type T with length n and capacity n
    make(T, n, m)    slice      slice of type T with length n and capacity m

    make(T)          map        map of type T
    make(T, n)       map        map of type T with initial space for approximately n elements

    make(T)          channel    unbuffered channel of type T
    make(T, n)       channel    buffered channel of type T, buffer size n


    s := make([]int, 10, 100)       // slice with len(s) == 10, cap(s) == 100
    s := make([]int, 1e3)           // slice with len(s) == cap(s) == 1000
    s := make([]int, 1<<63)         // illegal: len(s) is not representable by a value of type int
    s := make([]int, 10, 0)         // illegal: len(s) > cap(s)
    c := make(chan int, 10)         // channel with a buffer size of 10
    m := make(map[string]int, 100)  // map with initial space for approximately 100 elements

append::

    append(s S, x ...T) S  // T is the element type of S

    s0 := []int{0, 0}
    // append a single element     s1 == []int{0, 0, 2}
    s1 := append(s0, 2)
    // append multiple elements    s2 == []int{0, 0, 2, 3, 5, 7}
    s2 := append(s1, 3, 5, 7)
    // append a slice              s3 == []int{0, 0, 2, 3, 5, 7, 0, 0}
    s3 := append(s2, s0...)
    // append overlapping slice    s4 == []int{3, 5, 7, 2, 3, 5, 7, 0, 0}
    s4 := append(s3[3:6], s3[2:]...)

    var t []interface{}
    t = append(t, 42, 3.1415, "foo")   //  t == []interface{}{42, 3.1415, "foo"}

    var b []byte
    b = append(b, "bar"...)        // append string contents      b == []byte{'b', 'a', 'r' }

copy::

    var a = [...]int{0, 1, 2, 3, 4, 5, 6, 7}
    var s = make([]int, 6)
    var b = make([]byte, 5)
    n1 := copy(s, a[0:])            // n1 == 6, s == []int{0, 1, 2, 3, 4, 5}
    n2 := copy(s, s[2:])            // n2 == 4, s == []int{2, 3, 4, 5, 4, 5}
    n3 := copy(b, "Hello, World!")  // n3 == 5, b == []byte("Hello")

Deletion of map elements::

    delete(m, k)  // remove element m[k] from map m


complex number::

    complex(realPart, imaginaryPart floatT) complexT
    real(complexT) floatT
    imag(complexT) floatT

panics::

    func panic(interface{})
    func recover() interface{}






.. [1] https://golang.org/ref/spec