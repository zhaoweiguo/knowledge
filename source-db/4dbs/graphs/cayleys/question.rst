常见问题
########

g.V().All()不能显示全部数据
===========================

如下命令在数据量大的时候, 不能显示全部数据, 只能显示部分数据::

    g.V().Tag("source").Out("-->").Tag("target").All()

解决::

    var arrs = g.V().Tag("source").Out("-->").Tag("target").tagArray();

    var s = new Array();
    for ( i in arrs) {
      var values = new Object();
      values["source"] = arrs[i]["source"];
      values["target"] = arrs[i]["target"];
      s[i] = values;
    }
    g.Emit(s)



