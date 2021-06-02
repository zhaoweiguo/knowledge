
func main() {
  f, err := os.Create(".cpu.prof")
  if err != nil {
    log.Fatal(err)
  }
  defer f.Close()
  pprof.StartCPUProfile(f)
  defer pprof.StopCPUProfile()

  do_something()

  mem, err := os.Create(".mem.prof")
  if err != nil {
    log.Fatalln(err.Error())
  }
  defer mem.Close()
  pprof.WriteHeapProfile(mem)
}