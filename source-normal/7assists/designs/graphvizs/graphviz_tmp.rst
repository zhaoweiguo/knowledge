graphviz临时
==================

基本命令::

  dot example1.dot –Tpng –o example1.png

基本的 DOT 文件::

    graph example1 {
      Server1 -- Server2   // -- 定义了节点之间的联系
      Server2 -- Server3
      Server3 -- Server1
    }

有向的 DOT 文件::

    digraph example2 {
        Server1 -> Server2
        Server2 -> Server3
        Server3 -> Server1
    }

具有额外属性的图表::

    digraph example3 {
       Server1 -> Server2
       Server2 -> Server3
       Server3 -> Server1

       Server1 [shape=box, label="Server1\nWeb Server", fillcolor="#ABACBA", style=filled]
       Server2 [shape=triangle, label="Server2\nApp Server", fillcolor="#DDBCBC", style=filled]
       Server3 [shape=circle, label="Server3\nDatabase Server", fillcolor="#FFAA22",style=filled]
    }




digraph: 画图类型
dot -Tpng first.dot -o first.png
dot表示使用的是dot布局，其他布局相应的修改即可
-T表示格式，即画成png格式
-o表示重命名为first.png








