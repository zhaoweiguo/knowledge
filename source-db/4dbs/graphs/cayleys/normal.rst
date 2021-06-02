常用
#######



* Cayley在GitHub上放在Google名下，但它却不是Google官方项目，只是得到了Google的许可，由其员工创建并维护，类似的项目也有很多，比如Protocol Buffers、AngularJS。
* Cayley是受Freebase和Google的Knowledge Graph背后的图数据库graphd所启发，由Google工程师Barak Michener开发的一款开源图数据库。


运行::

    $ docker run -p 64210:64210 cayleygraph/cayley

    // 加载数据
    $ cayley http --load 30kmoviedata.nq.gz


脚本::

    // To select all vertices in the graph call, limit to 5 first results
    // g and V are synonyms for graph and Vertex
    $ g.V().getLimit(5);

    // Match a property of a vertex
    g.V()
      .has("<name>", "Humphrey Bogart")
      .all();

    // Match a complex path
    // Get the list of actors in the film
    g.V()
      .has("<name>", "Casablanca")
      .out("</film/film/starring>")
      .out("</film/performance/actor>")
      .out("<name>")
      .all();

    // Match
    var filmToActor = g
      .Morphism()
      .out("</film/film/starring>")
      .out("</film/performance/actor>");

    g.V()
      .has("<name>", "Casablanca")
      .follow(filmToActor)
      .out("<name>")
      .all();





3种query languages::

    Gizmo: query language inspired by Gremlin
    GraphQL-inspired query language
    MQL: simplified version for Freebase fans

Cayley数据库支持三元组文件导入，所谓三元组，指的是主语subject，谓语predicate 以及宾语object，每个三元组为一行
Cayley数据库支持的三元组文件以nq为后缀，每个三元组为一行，主语、谓语、宾语中间用空格分开，同时还需要注意一下事项

.. note:: 空格，逗号，引号都是关键词



