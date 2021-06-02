实战2-简单的例子 [1]_
#####################


.. literalinclude:: /files/dbs/graphs/cayleys/demo2.nq

查询一共有多少条数据
--------------------
命令::

    var n = g.V().Count();
    g.Emit(n);

结果::

    {
        "result": [
            521
        ]
    }

查询全部电影
------------
命令::

    var movies = g.V('<Movie>').In('<ISA>').ToArray();
    g.Emit(movies);

结果::

    {
        "result": [
            [
                "<战狼2>",
                "<流浪地球>",
                "<红海行动>",
                "<唐人街探案2>",
                "<美人鱼>",
                "<我不是药神>",
                "<速度与激情8>",
                "<西虹市首富>",
                "<捉妖记>",
                "<速度与激情7>",
                "<复仇者联盟3：无限战争>",
                "<捉妖记2>",
                "<羞羞的铁拳>",
                "<海王>",
                "<变形金刚4：绝迹重生>",
                "<前任3：再见前任>",
                "<疯狂的外星人>",
                "<毒液：致命守护者>",
                "<功夫瑜伽>",
                "<侏罗纪世界2>"
            ]
        ]
    }

查询电影《流浪地球》的所有属性值
-------------------------------------------

命令::

    var movie = "<流浪地球>";
    var attrs = g.V(movie).OutPredicates().ToArray(); //类型为object，即字典

    values = new Array();
    for (i in attrs) {
        var value = g.V(movie).Out(attrs[i]).ToValue();
        values[i] = value;
    }

    key_val_json = new Object();

    for (i in attrs) {
      key_val_json[attrs[i]]= values[i];
    }

    g.Emit(key_val_json)

结果::

     {
        "result": [
            {
                "<ISA>": "<Movie>",
                "<avg_people>": "50",
                "<avg_price>": "46",
                "<begin_date>": "2019.02.05",
                "<box_office>": "40.83亿",
                "<rank>": "2",
                "<src>": "/item/%E6%B5%81%E6%B5%AA%E5%9C%B0%E7%90%83"
            }
        ]
    }

查询沈腾主演的电影
------------------
命令::

    var movies = g.V('<沈腾>').Out('<ACT_IN>').ToArray();
    g.Emit(movies);

结果::

    {
        "result": [
            [
                "<西虹市首富>",
                "<羞羞的铁拳>",
                "<疯狂的外星人>"
            ]
        ]
    }

查询<捉妖记>与<捉妖记2>的共同演员
----------------------------------------
命令::

    var actors1 = g.V('<捉妖记>').In('<ACT_IN>');
    var actors2 = g.V('<捉妖记2>').In('<ACT_IN>');
    var common_actor = actors2.Intersect(actors1).ToArray();//集合交集
    g.Emit(common_actor);

结果::

    {
        "result": [
            [
                "<白百何>",
                "<井柏然>",
                "<曾志伟>",
                "<吴君如>"
            ]
        ]
    }


Cayley图数据库的可视化(Visualize)
-------------------------------------
Gizmo请求::

    g.V('<流浪地球>').Tag("source").Out().Tag("target").All();

.. image:: /images/dbs/graphs/cayleys/demo2.png
   :width: 70%


说明::

    // 若想实现查询结果的可视化，则需要使用Tag()函数
    // 并形成返回值有source和target的json
    [
      {
        "source": "node1",
        "target": "node2"
      },
      {
        "source": "node1",
        "target": "node3"
      },
    ]

查看某个实体的所有属性及属性值
------------------------------

命令::

    var eq = "<流浪地球>";
    var attrs = g.V(eq).OutPredicates().ToArray(); 

    values = new Array();
    for (i in attrs) {
        var value = g.V(eq).Out(attrs[i]).ToValue();
        values[i] = value;
    }

    var s = new Array();
    for (i in attrs) {
      var key_val_json = new Object();
      key_val_json["id"] = values[i];
      key_val_json["source"] = eq;
      key_val_json["target"]= attrs[i]+":"+values[i];
      s[i] = key_val_json;
    }

    for (i =0; i< s.length; i++) {
        g.Emit(s[i]);
    }

.. image:: /images/dbs/graphs/cayleys/demo3.png
   :width: 70%


显示属性及属性值关系
--------------------

命令::

    var eq = "<流浪地球>";
    var attrs = g.V(eq).OutPredicates().ToArray(); 

    values = new Array();
    for (i in attrs) {
        var value = g.V(eq).Out(attrs[i]).ToValue();
        values[i] = value;
    }

    var s = new Array();

    for (i in attrs) {
      var key_val_json = new Object();
      key_val_json["source"] = eq;
      key_val_json["rela"] = attrs[i];
      key_val_json["target"] = values[i];
      key_val_json["type"] = "resolved";
      s[i] = key_val_json;
    }

    for (i =0; i< s.length; i++) {
        g.Emit(s[i]);
    }

结果::

    {
        "result": [
            {
                "rela": "<ISA>",
                "source": "<流浪地球>",
                "target": "<Movie>",
                "type": "resolved"
            },
            {
                "rela": "<rank>",
                "source": "<流浪地球>",
                "target": "2",
                "type": "resolved"
            },
            {
                "rela": "<src>",
                "source": "<流浪地球>",
                "target": "/item/%E6%B5%81%E6%B5%AA%E5%9C%B0%E7%90%83",
                "type": "resolved"
            },
            {
                "rela": "<box_office>",
                "source": "<流浪地球>",
                "target": "40.83亿",
                "type": "resolved"
            },
            {
                "rela": "<avg_price>",
                "source": "<流浪地球>",
                "target": "46",
                "type": "resolved"
            },
            {
                "rela": "<avg_people>",
                "source": "<流浪地球>",
                "target": "50",
                "type": "resolved"
            },
            {
                "rela": "<begin_date>",
                "source": "<流浪地球>",
                "target": "2019.02.05",
                "type": "resolved"
            }
        ]
    }

原始数据
--------

.. literalinclude:: /files/dbs/graphs/cayleys/demo3.nq


.. [1] https://www.jianshu.com/p/7856bc4b63b4
