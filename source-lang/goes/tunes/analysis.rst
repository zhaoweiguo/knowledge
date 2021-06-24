pprof 数据分析
##############

虽然 net/http/pprof提供的数据分析可以通过设置参数后直接在浏览器查看，但 pprof 采样数据主要是用于 pprof 工具的，特别针对 cpuprof, memprof, blockprof等来说，我们需要直观地得到整个调用关系链以及每次调用的详细信息，这是需要通过go tool pprof命令来分析::

    go tool pprof [binary] [binary.prof]
    # 如果使用的 net/http/pprof 可以直接接 URL
    go tool pprof http://localhost:6060/debug/pprof/profile

go pprof 采样数据是非常丰富的，大部分情况下我们只会用到 CPU 和 内存分析::

    cpu, heap, block 和 mutex 四种 pprof 数据分析




.. toctree::
   :maxdepth: 1

   analysis/cpuprofile
   analysis/memprofile
   analysis/blockprofile
   analysis/mutexprofile




