package main

import (
  "log"
  "os"
  "runtime/pprof"
)

func main() {
  f, err := os.Create(".cpu.prof")
  if err != nil {
    log.Fatal(err)
  }
  defer f.Close()
  pprof.StartCPUProfile(f)
  defer pprof.StopCPUProfile()

  for i := 0; i < 42; i++ {
    go fibonacci(i)
  }

  for i := 0; i < 40; i++ {
    fibonacci2(i)
  }

  for i := 0; i < 40; i++ {
    fibonacci4(i)
  }

  for i := 0; i < 40; i++ {
    go fibonacci5(i)
    fibonacci3(i)
  }

  for i := 0; i < 40; i++ {
    go fibonacci6(i)
  }

  log.Println("========")

  mem, err := os.Create(".mem.prof")
  if err != nil {
    log.Fatalln(err.Error())
  }
  defer mem.Close()
  pprof.WriteHeapProfile(mem)
}

func fibonacci(num int) int {
  if num < 2 {
    return 1
  }
  return fibonacci(num-1) + fibonacci(num-2)
}

func fibonacci2(num int) int {
  if num < 2 {
    return 1
  }
  return fibonacci2(num-1) + fibonacci2(num-2)
}

func fibonacci3(num int) int {
  if num < 2 {
    return 1
  }
  return fibonacci3(num-1) + fibonacci3(num-2)
}

func fibonacci4(num int) int {
  if num < 2 {
    return 1
  }
  return fibonacci3(num-1) + fibonacci3(num-2)
}

func fibonacci5(num int) int {
  if num < 2 {
    return 1
  }
  return fibonacci4(num-1) + fibonacci4(num-2)
}

func fibonacci6(num int) int {
  if num < 2 {
    return 1
  }
  return fibonacci6(num-1) + fibonacci6(num-2)
}
