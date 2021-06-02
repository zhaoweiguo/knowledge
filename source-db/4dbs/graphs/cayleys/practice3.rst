实践3
########

drone代码分析::

    var arrs = g.V().Tag("source").Out().Tag("target").tagArray();

    var s = new Array();
    for ( i in arrs) {
      var values = new Object();
      values["source"] = arrs[i]["source"];
      values["target"] = arrs[i]["target"];
      s[i] = values;
    }
    g.Emit(s)






