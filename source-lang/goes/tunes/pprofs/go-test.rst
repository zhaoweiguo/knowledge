go test
#######

通常用net/http/pprof或runtime/pprof对应用进行整体分析，找出热点后，再用go test进行基准测试，进一步确定热点加以优化并对比测试::

    # 生成 test 二进制文件， pprof 工具需要用到
    ▶ go test -c -o tmp.test 
    # 执行基准测试 BenchAbc，并忽略任何单元测试，test flag前面需要加上'test.'前缀
    ▶ tmp.test -test.bench BenchAbc -test.run XXX test.cpuprofile cpu.prof     
    # 与上面两条命令等价，只不过没有保留 test 二进制文件
    ▶ go test -bench BenchAbc -run XXX -cpuprofile=cpu.prof .

go test可以直接加-cpuprofile -mutexprofilefraction等参数实现prof数据的采样和生成，更多相关参数参考 go test -h。




