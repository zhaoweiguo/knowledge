Benchmarks
##########


::

    func BenchmarkXxx(*testing.B)

实例::

    func BenchmarkHello(b *testing.B) {
        for i := 0; i < b.N; i++ {
            fmt.Sprintf("hello")
        }
    }

If a benchmark needs some expensive setup before running, the timer may be reset::

    func BenchmarkBigLen(b *testing.B) {
        big := NewBig()
        b.ResetTimer()
        for i := 0; i < b.N; i++ {
            big.Len()
        }
    }

If a benchmark needs to test performance in a parallel setting::

    func BenchmarkTemplateParallel(b *testing.B) {
        templ := template.Must(template.New("test").Parse("Hello, {{.}}!"))
        b.RunParallel(func(pb *testing.PB) {
            var buf bytes.Buffer
            for pb.Next() {
                buf.Reset()
                templ.Execute(&buf, "World")
            }
        })
    }


运行::

    $ go test -bench=. -run=none

    // 测试时间默认是1秒，如果想让测试运行的时间更长，可以通过-benchtime指定，比如3秒
    $ go test -bench=. -benchtime=3s -run=none

    // -benchmem可以提供每次操作分配内存的次数，以及每次操作分配的字节数
    go test -bench=. -benchmem -run=none


性能测试实例:

.. literalinclude:: /files/golangs/benchmark_test.go
   :language: go
   :linenos:









