package main

import (
    "fmt"
    "os"
    "runtime"
    "runtime/pprof"
    "sync"
    "time"
)

var mutex sync.Mutex
func main() {
    // rate = 1 时, 统计所有的 block event,
    // rate <=0 时，则关闭block profiling
    // rate > 1 时，为 ns 数，阻塞时间t>rate的event 一定会被统计，小于rate则有t/rate 的几率被统计
    // 参考 https://github.com/golang/go/blob/release-branch.go1.9/src/runtime/mprof.go#L397
    runtime.SetBlockProfileRate(1 * 1000 * 1000)
    var wg sync.WaitGroup
    wg.Add(1)
    mutex.Lock()
    go worker(&wg)
    time.Sleep(2*time.Millisecond)
    mutex.Unlock()
    wg.Wait()
    writeProfTo("block", "block.bprof")
}

func worker(wg *sync.WaitGroup) {
    defer wg.Done()
    mutex.Lock()
    time.Sleep(1*time.Millisecond)
    mutex.Unlock()
}

func writeProfTo(name, fn string) {
    p := pprof.Lookup(name)
    if p == nil {
      fmt.Errorf("%s prof not found", name)
      return
    }
    f, err := os.Create(fn)
    if err != nil {
      fmt.Errorf("%v", err.Error())
      return
    }
    defer f.Close()
    err = p.WriteTo(f, 0)
    if err != nil {
      fmt.Errorf("%v", err.Error())
      return
    }
}

