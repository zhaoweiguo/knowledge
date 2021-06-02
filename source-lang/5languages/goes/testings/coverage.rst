测试覆盖率
============

我们尽可能的模拟更多的场景来测试我们代码的不同情况，但是有时候的确也有忘记测试的代码，这时候我们就需要测试覆盖率作为参考了。

由单元测试的代码，触发运行到的被测试代码的代码行数占所有代码行数的比例，被称为测试覆盖率，代码覆盖率不一定完全精准，但是可以作为参考，可以帮我们测量和我们预计的覆盖率之间的差距，go test工具，就为我们提供了这么一个度量测试覆盖率的能力。

main.go::

    func Tag(tag int){
        switch tag {
        case 1:
            fmt.Println("Android")
        case 2:
            fmt.Println("Go")
        case 3:
            fmt.Println("Java")
        default:
            fmt.Println("C")

        }
    }

main_test.go::

    func TestTag(t *testing.T) {
        Tag(1)
        Tag(2)

    }




现在我们使用go test工具运行单元测试，和前几次不一样的是，我们要显示测试覆盖率，所以要多加一个参数-coverprofile,所以完整的命令为：go test -v -coverprofile=c.out，-coverprofile是指定生成的覆盖率文件，例子中是c.out，这个文件一会我们会用到。现在我们看终端输出，已经有了一个覆盖率。

结果::

    === RUN   TestTag
    Android
    Go
    --- PASS: TestTag (0.00s)
    PASS
    coverage: 60.0% of statements
    ok      flysnow.org/hello       0.005s

coverage: 60.0% of statements，60%的测试覆盖率，还没有到100%，那么我们看看还有那些代码没有被测试到。这就需要我们刚刚生成的测试覆盖率文件c.out生成测试覆盖率报告了。生成报告有go为我们提供的工具，使用go tool cover -html=c.out -o=tag.html，即可生成一个名字为tag.html的HTML格式的测试覆盖率报告，这里有详细的信息告诉我们哪一行代码测试到了，哪一行代码没有测试到。


.. figure:: /images/languages/golangs/testing_cover_report.png
   :width: 80%

从上图中可以看到，标记为绿色的代码行已经被测试了；标记为红色的还没有测试到，有2行的，现在我们根据没有测试到的代码逻辑，完善我的单元测试代码即可::

    func TestTag(t *testing.T) {
        Tag(1)
        Tag(2)
        Tag(3)
        Tag(6)

    }


单元测试完善为如上代码，再运行单元测试，就可以看到测试覆盖率已经是100%了，大功告成。

覆盖度
------

::

    go test -cover github.com/drone/go-scm/scm/...

