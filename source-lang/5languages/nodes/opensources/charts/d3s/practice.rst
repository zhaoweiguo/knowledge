实例 [1]_
###########


选择元素
=========
::

    d3.select() 
    d3.selectAll()     

实例:

    var body = d3.select("body");//选择文档中的body元素
    var svg = body.select("svg");//选择body中的svg元素
    var p = body.selectAll("p");//选择body中所有的p元素
    var p1 = body.select("p");//选择body中第一个p元素

绑定数据data,datum
====================

::

    data()：讲一个数组绑定到选择集上，数组各项和选择集各元素绑定，也就是一一对应的关系
    datum()：将一个数据绑定到所有选择集上

datum()的使用::

    <body>
      <p>dog</p>
      <p>cat</p>
      <p>pig</p>
      
      <script>
        var str = "is an animal";//新建一个字符串
        var p = d3.select("body")
          .selectAll("p");
          
        p.datum(str)//绑定
          .text(function(d,i){
            return "第"+i+"个元素"+d;
          });
      </script>
    </body>

输出::

    第0个元素is an animal
    第1个元素is an animal
    第2个元素is an animal


data()的使用::

    <body>
      <p>dog</p>
      <p>cat</p>
      <p>pig</p>
      
      <script>
        var dataset = ["so cute","cute","fat"];
        var p = d3.select("body")
          .selectAll("p");
          
        p.data(dataset)
          .text(function(d,i){
            return "第"+i+"个动物"+d;
          });
      </script>
    </body>

输出::

    第0个动物so cute
    第1个动物cute
    第2个动物fat

Update、Enter、Exit
=========================

.. image:: /images/charts/common_force_directed2.png


Update与Enter的使用::

    <body>
      <p>dog</p>
      <p>cat</p>
      <p>pig</p>
      
      <script>
        var dataset = [3,6,9,12,15];
        var p = d3.select("body")
          .selectAll("p");
        var update = p.data(dataset)//绑定数据,并得到update部分
        var enter = update.enter();//得到enter部分
        //下面检验是否真的得到
        //对于update的处理
        update.text(function(d,i){
          return "update: "+d+",index: "+i;
        })
        //对于enter的处理
        //注意，这里需要先添加足够多的<p>，然后在添加文本
        var pEnter = enter.append("p")//添加足够多的<p>
        pEnter.text(function(d,i){
          return "enter: "+d+",index: "+i;
        })
      </script>
    </body>

结果::

    update: 3, index 0
    update: 6, index 1
    update: 9, index 2
    enter: 12, index 3
    enter: 15, index 4

Update与Exit的使用::

    <body>
      <p>dog</p>
      <p>cat</p>
      <p>pig</p>
      <p>rat</p>
      
      <script>
        var dataset = [3,6];
        var p = d3.select("body")
          .selectAll("p");
        var update = p.data(dataset)//绑定数据,并得到update部分
        var exit = update.exit();//得到exit部分
        //下面检验是否真的得到
        //对于update的处理
        update.text(function(d,i){
          return "update: "+d+",index: "+i;
        })
        //对于exit的处理通常是删除 ，但在这里我并没有这么做     
        exit.text(function(d,i){
          return "exit";
        })
      </script>
    </body>

结果::

    update: 3, index 0
    update: 6, index 1
    exit
    exit

选择元素select,selectAll
========================

实例::

    <p>dog</p>
    <p>cat</p>
    <p>pig</p>
    <p>rat</p>

    // 选择第一个元素<p>
    var p = d3.select("body")
      .select("p");
    p.style("color","red");

    // 选择全部元素
    var p = d3.select("body")
        .selectAll("p");
    p.style("color","red");

选择任意元素::

    <p>dog</p>
    <p class="myP2">cat</p>
    <p id="myP3">pig</p>
    <p>rat</p>

    var p = d3.select("body")
          .selectAll(".myP2");
    p.style("color","red");

选择任意元素（扩展）::

    var dataset = [3,6,9,12];
    var p = d3.select("body")
      .selectAll("p")
      .data(dataset)
      .text(function(d,i){
        if(i==3){
          d3.select(this).style("color","red");
        }
        return d;
      })

插入元素append,insert
=====================

说明::

    append()：在选择集尾部插入元素
    insert()：在选择集前面插入元素    

实例::

    var p = d3.select("body")
        .append("p")
        .text("another animal")
        .style("color","red");

删除元素remove
==============

实例::

    var p = d3.select("body")
        .select("#myP3")
        .remove();


svg画布入门
===========


* svg画布：svg绘制的是矢量图（还有canvas画布，这个是JavaScript用来绘制2D图像的，是位图）
* rect元素：是d3中在svg中绘制矩形的元素
* g元素：分组的时候使用


`svg画布入门 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp06_1.html>`_

比例尺
======

两种比例尺:

* `线性比例尺:d3.scaleLinear() <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp07_1.html>`_
* `序数比例尺:d3.scaleOrdinal() <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp07_2.html>`_
* 第3种比例尺d3.scaleBand()

使用比例尺完成svg画面:

`比例尺画布 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp07_3.html>`_

坐标轴
======

定义一个坐标轴:

* 朝下: axisBottom
* 朝上: axisTop
* 朝左: axisLeft
* 朝右: axisRight

调用:call()


`坐标轴 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp08_1.html>`_

d3.range(dataset.length)，这里返回的是一个等差数列

让图表动起来
============

* .attr(xxx).transition()表示添加过渡，也就是从前一个属性过渡到后一个属性
* .duration(2000)，表示过渡时间持续2秒
* .delay(500)，表示延迟0.4秒后再进行过渡
* .ease(d3.easeElasticInOut)表示过渡方式，注意这里和v3版本的区别

`让图表动起来 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp10_1.html>`_

交互式操作
==========

* on("eventName",function)；该函数是添加一个监听事件，它的第一个参数是事件类型，第二个参数是响应事件的内容
* d3.select(this),选择当前元素

常见的事件类型::

    click：鼠标单击某元素时触发，相当于mousedown和mouseup的组合
    mouseover：鼠标放在某元素上触发
    mouseout：鼠标移出某元素时触发
    mousemove：鼠标移动时触发
    mousedown：鼠标按钮被按下时触发
    mouseup：鼠标按钮被松开时触发
    dblclick：鼠标双击时触发

查看监听事件::

    .on("click",function(){
        console.log(d3.event);
    })

为柱状图添加监听事件::

    .on("mouseover",function(){
      var rect = d3.select(this)
        .transition()
        .duration(1500)//当鼠标放在矩形上时，矩形变成黄色
        .attr("fill","yellow");
    })
    .on("mouseout",function(){
      var rect = d3.select(this)
        .transition()
        .delay(1500)
        .duration(1500)//当鼠标移出时，矩形变成蓝色
        .attr("fill","blue");
    })

`交互式操作 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp12_1.html>`_

饼状图
========

* d3.arc( {} ),弧形生成器，用以绘制弧形，需要传入一些用以绘制弧形基本的数据的对象
* d3.pie()，饼状图生成器，用于生成饼图
* d3.arc().centroid()
* d3.schemeCategory10，一些离散的色彩数组


`饼状图 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp13_1.html>`_

力导向图
========

* d3.forceSimulation() ，新建一个力导向图，
* d3.forceSimulation().force(),添加或者移除一个力
* d3.forceSimulation().nodes()，输入是一个数组，然后将这个输入的数组进行一定的数据转换
* d3.forceLink.links()，这里输入的也是一个数组（边集），然后对输入的边集进行转换
* d3.drag(),是力导向图可以被拖动
* tick()，重要，力导向图是不断运动的，每一时刻都在发生更新，所以需要不断更新节点和连线的位置

`力导向图 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp14_1.html>`_

树状图
======

* d3.hierarchy()，层级布局，需要和tree生成器一起使用，来得到绘制树所需要的节点数据和边数据
* d3.hierarchy().sum() ,后序遍历
* d3.tree()，创建一个树状图生成器
* d3.tree().size()，定义树的大小
* d3.tree().separation(),定义邻居节点的距离
* node.descendants()得到所有的节点，已经经过转换的数据
* node.links()，得到所有的边，已经经过转换的数据
* d3.linkHorizontal()，创建一个水平贝塞尔生成曲线生成器
* d3.linkVertical()，垂直的贝塞尔生成曲线生成器

`树状图 <https://github.com/zhaoweiguo/demo-node/tree/master/charts/d3/v5/chp15_1.html>`_






.. [1] https://blog.csdn.net/qq_34414916/article/details/80026180