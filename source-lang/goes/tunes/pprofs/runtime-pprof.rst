runtime/pprof(工具型应用)
#########################

cpu::

    使用: runtime/pprof
    具体做法就是用到pprof.StartCPUProfile和pprof.StopCPUProfile
    比如下面的例子:
      var cpuprofile = flag.String("cpuprofile", "", "write cpu profile to file")
      func main() {
          flag.Parse()
          if *cpuprofile != "" {
              f, err := os.Create(*cpuprofile)
              if err != nil {
                  log.Fatal(err)
              }
              pprof.StartCPUProfile(f)
              defer pprof.StopCPUProfile()
          }
          xxxx
          xxxx
      }

    运行程序的时候加一个--cpuprofile参数，比如:
    $ fabonacci --cpuprofile=cpu.prof   // 这样程序运行的时候的cpu信息就会记录到XXX.prof中了
    下一步就可以使用这个prof信息做出性能分析图了(需要安装graphviz)

堆内存::

    func main() {
        f, err := os.OpenFile("heap.prof", os.O_RDWR|os.O_CREATE, 0644)
        if err != nil {
            log.Fatal(err)
        }
        defer f.Close()

        time.Sleep(30 * time.Second)

        pprof.WriteHeapProfile(f)
        fmt.Println("Heap Profile generated")
    }

使用::

    $ go tool pprof <二进制文件> cpu.prof
    $ go tool pprof <二进制文件> heap.prof







