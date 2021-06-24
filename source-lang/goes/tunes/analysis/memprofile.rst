memprofile
##########

操作::

    $ go build -o havlak3 havlak3.go 
    $ ./havlak3 --memprofile=havlak3.mprof
    $ go tool pprof havlak3 havlak3.mprof
    File: havlak3
    Type: inuse_space
    Time: Apr 3, 2018 at 3:44pm (CST)
    Entering interactive mode (type "help" for commands, "o" for options)
    (pprof) 


查看内存 消耗 top5::

    (pprof)top
    Showing nodes accounting for 57.39MB, 100% of 57.39MB total
        flat  flat%   sum%        cum   cum%
     39.60MB 69.00% 69.00%    39.60MB 69.00%  main.FindLoops /Code/goprof/havlak/havlak3.go
     11.29MB 19.67% 88.67%    11.29MB 19.67%  main.(*CFG).CreateNode /Code/goprof/havlak/havlak3.go
      6.50MB 11.33%   100%    17.79MB 31.00%  main.NewBasicBlockEdge /Code/goprof/havlak/havlak3.go
           0     0%   100%    39.60MB 69.00%  main.FindHavlakLoops /Code/goprof/havlak/havlak3.go
           0     0%   100%    17.79MB 31.00%  main.buildBaseLoop /Code/goprof/havlak/havlak3.go

memprofile 也就是 heap 采样数据，go tool pprof 默认显示的是使用的内存的大小，如果想要显示使用的堆对象的个数，则通过::

    go tool pprof --inuse_objects havlak3 havlak3.mprof

其它参数还有 ``--alloc_objects`` 和 ``--alloc_space`` ，分别是分配的堆内存大小和对象个数。在本例中，FindLoops 函数分配了39.60M 堆内存，占到69%，同样，接下来是通过list FindLoops对函数代码进行 review，找出关键数据结构，进行优化。










