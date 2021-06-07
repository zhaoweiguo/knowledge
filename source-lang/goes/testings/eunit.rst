单元测试
########

::

    文件命名规则: <file>_test.go
    import "testing"

    // 单元测试
    函数命名规则: Test<fun>(t *testing.T) {}
    命令: go test <package>

    级联单元测试命令:
    go test <package>/...
    or 
    go test <folder>/...

    import "github.com/bmizerany/assert"

    assert.Equal(t, <yourData>, <testData>)

    Error, Errorf, FailNow, Fatal, FatalIf方法可以指定此单元测试未通过
    // 性能测试
    函数命名规则: Benchmark<fun>(b *testing.B) {}
    命令: go test -test.bench <file>.go
    go test -test.bench=".*"   // 表示测试全部的压力测试函数

使用这个框架，需要遵循如下几点规则::

    1. 含有单元测试代码的go文件必须以_test.go结尾，Go语言测试工具只认符合这个规则的文件
    2. 单元测试文件名_test.go前面的部分最好是被测试的方法所在go文件的文件名，比如:
        例子中是main_test.go对应main.go
    3. 单元测试的函数名必须以Test开头，是可导出公开的函数
    4. 测试函数的签名必须接收一个指向testing.T类型的指针，并且不能返回任何值
    5. 函数名最好是Test+要测试的方法函数名，比如:
        例子中是TestAdd，表示测试的是Add这个这个函数


综述
========

::

    import "testing"
    func TestXxx(*testing.T)

实例::

    func TestAbs(t *testing.T) {
        got := Abs(-1)
        if got != 1 {
            t.Errorf("Abs(-1) = %d; want 1", got)
        }
    }



Subtests
========

::

    func TestFoo(t *testing.T) {
        // <setup code>
        t.Run("A=1", func(t *testing.T) { ... })
        t.Run("A=2", func(t *testing.T) { ... })
        t.Run("B=1", func(t *testing.T) { ... })
        // <tear-down code>
    }

命令::

    go test -run ''      # Run all tests.
    go test -run Foo     # Run top-level tests matching "Foo", such as "TestFooBar".
    go test -run Foo/A=  # For top-level tests matching "Foo", run subtests matching "A=".
    go test -run /A=1    # For all top-level tests, run subtests matching "A=1".

实例
========
demo1::

    package main

    import "testing"

    func TestAdd(t *testing.T) {
        if Add(1,2) == 3 {
            t.Log("1+2=3")
        }

        if Add(1,1) == 3 {
            t.Error("1+1=3")
        }
    }

表组测试
========

有好几个输入，同时对应的也有好几个输出，这种一次性测试很多个输入输出场景的测试，就是表组测试。

例::

    func TestAdd(t *testing.T) {
        sum := Add(1,2)
        if sum == 3 {
            t.Log("the result is ok")
        } else {
            t.Fatal("the result is wrong")
        }
        
        sum=Add(3,4)
        if sum == 7 {
            t.Log("the result is ok")
        } else {
            t.Fatal("the result is wrong")
        }
    }






