高级
====

Initialize A Graph::

    $ ./cayley init ...
    // 使用参数
    $ ./cayley init --db=mongo --dbpath="mongo:27017"
    // 使用配置文件
    $ ./cayley init -c cayley_overview.yml

Load Data Into A Graph::

    // 初使化后截入数据
    $ ./cayley load -c cayley_overview.yml -i data/testdata.nq
    // 显示截入数据进度
    $ ./cayley load -c cayley_overview.yml -i data/testdata.nq --alsologtostderr=true
    // 当数据很大时,可以压缩成Cayley-specific的二进制
    $ ./cayley conv -i dataset.nq.gz -o dataset.pq.gz

Connect a REPL To Your Graph::
    
    交互式解释器 (REPL):读取(Read)-运算(Eval)-输出(Print)-循环(Loop)
    // 连接
    $ ./cayley repl -c cayley_overview.yml
    // 使用
    1. 新增
    cayley> :a subject predicate object label .
    2. 删除
    cayley> :d subject predicate object .

    3. 其他实例
    // Simple math
    cayley> 2 + 2

    // JavaScript syntax
    cayley> x = 2 * 8
    cayley> x

    // See all the entities in this small follow graph.
    cayley> graph.Vertex().All()

    // See only dani.
    cayley> graph.Vertex("<dani>").All()

    // See who dani follows.
    cayley> graph.Vertex("<dani>").Out("<follows>").All()

Serve Your Graph::

    // 默认监听64210端口(只能本地访问)
    $ ./cayley http -c cayley_overview.yml
    // 其他机器可访问
    $ ./cayley http --config=cayley.cfg.overview --host=0.0.0.0:64210

