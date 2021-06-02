常用 [1]_
#########

SVG (Scalable Vector Graphics 可伸缩矢量图形)::

    SVG 意为可缩放矢量图形（Scalable Vector Graphics）。
    SVG 是使用 XML 来描述二维图形和绘图程序的语言。
    SVG 图像在放大或改变尺寸的情况下其图形质量不会有所损失。
    SVG 是万维网联盟的标准。



在HTML文件中直接嵌入svg内容，也可以直接引入后缀名为.svg的文件 如::

    /* svg标签，这里的rect为矩形，在后面的图形元素中会详细说明  */
    <svg width="200" height="200">
      <rect width="20" height="20" fill="red"></rect>
    </svg>

    /* 引入后缀名为.svg的文件 */
    <img src="demo.svg" alt="测试svg图片">

SVG中的坐标系::

    y轴向下
    顺时针方向的角度为正值

颜色 RGB和HSL::

    RGB: 三个分量：红色、绿色、蓝色，每个分量的取值范围[0, 255]，优点是显示器更容易解析
    HSL: 三个分量：颜色h、饱和度s%、亮度l%，每个分量的取值范围分别是[0, 359], [0, 100%], [0, 100%],，其中，h=0表示红色， h=0表示120绿色，h=0表示240 蓝色
    基于HSL的配色方案http://paletton.com/

在w3c的定义如下::

    SVG 指可伸缩矢量图形 (Scalable Vector Graphics)
    SVG 用来定义用于网络的基于矢量的图形
    SVG 使用 XML 格式定义图形
    SVG 图像在放大或改变尺寸的情况下其图形质量不会有所损失
    SVG 是万维网联盟的标准
    SVG 与诸如 DOM 和 XSL 之类的 W3C 标准是一个整体

SVG时我们通常也是使用类库来提升效率。这里的类库主要有三种::

    highcharts.JS, 在现代浏览器中使用SVG绘图，在IE6，7，8中用VML绘图。包含一堆预定义的图表和样式。唯一的问题是，这货收费。只对非商业用途免费。
    raphael.js，以著名画家拉斐尔之名命名的绘图JS库，跟highcharts类似，也是SVG + VML兼容性方案(支持跨浏览器)。但它是开源的，应用也比较广泛。使用它的时候有必要再下一个gRaphael图表库作为参考。
    D3.js，D3js是应用在web开发上的开源JS组件库，是一个数据可视化工具。D3应用的最为广泛，不过只支持SVG，我会重点讲述

SVG标签的属性
=============

viewBox
-------

定义用户视野的位置以及大小，即定义用来观察SVG视图一个矩形区域，如：viewBox ='20 20 100 100'，前两个参数表示viewBox视野相对svg视图的x y坐标，后两个参数表示viewBox的大小。如图所示，用户可以看到的部分是蓝色的星星，而星星的另一侧是看不到的。

.. image:: /images/languages/h5s/svg-viewbox1.png

preserveaspectRatio
-------------------
作用于viewBox，取值：[参数值 | none]有两个参数，第一个参数用来控制viewBox的对齐方式，第二个参数控制viewBox的缩放方式。另外：none 表示变形以充分适应svg

第一个参数有两个值组成，第一个值控制x轴的对齐方式，第二个轴控制y的对齐方式，如::

    xMinYMin 参数说明：
    xMin：与x轴左边对齐
    xMid：与x轴中心对齐
    xMax：与x轴右边对齐
    YMin：与y轴上边缘对齐
    YMid：与y轴中心对齐
    YMax：与y轴下边缘对齐

第二个参数取值::

    meet：保持横纵比缩放
    slice：保持横纵比缩放的同时以比例小的方向为准放大填满svg区域



优点
=====

* D3最大的优点在于其资料丰富，案例非常多。这是真的是一个极大的优点。
* SVG矢量图形的特点是无损缩放，这个优势在显示2D图形式会有非常好的效果，并且兼容各种分辨率。
* SVG图形的节点可以像dom元素一样控制，这就让自主创作图形变得更容易。相对于canvas这也是非常大的优势。

与其他图像格式相比（比如 JPEG 和 GIF），使用 SVG 的优势在于::

    SVG 图像可通过文本编辑器来创建和修改；
    SVG 图像可被搜索、索引、脚本化或压缩；
    SVG 是可伸缩的；
    SVG 图像可在任何的分辨率下被高质量地打印；
    SVG 可在图像质量不下降的情况下被放大；


缺点
=====

* SVG是2D矢量图，不能画3D图形。（用2D矢量可以画很多带透视效果的伪3D图，那并不是真正的3D图！）
* d3.不支持IE6，7，8
* SVG的节点都是对象，非常占用内存
    例如论坛里一个朋友使用d3绘制超过12000个节点的图，直接导致每个试图打开它的浏览器都崩溃了
    这个时候如果不愿意做简化那么应该试试canvas绘图。

使用方式
========

（1）使用 <embed> 标签::

    优势：所有主要浏览器都支持，并允许使用脚本
    缺点：不推荐在HTML4和XHTML中使用（但在HTML5允许）

    <embed width="300px" height="300px" src="img/demo.svg" type="image/svg+xml" />

（2）使用 <object> 标签::

    优势：所有主要浏览器都支持，并支持HTML4，XHTML和HTML5标准
    缺点：不允许使用脚本。

    <object width="300px" height="300px" data="img/demo.svg" type="image/svg+xml"></object>

（3）使用 <iframe> 标签::

    优势：所有主要浏览器都支持，并允许使用脚本
    缺点：不推荐在HTML4和XHTML中使用（但在HTML5允许）

    <iframe width="300px" height="300px" src="img/demo.svg"></iframe>

（4）直接在HTML嵌入SVG代码::

    <svg width="500px" height="500px" style="margin:50px;" version="1.1" xmlns="http://www.w3.org/2000/svg">
        <rect x="20" y="20" rx="10" ry="10" width="300" height="300" style="fill:rgb(0,0,255);stroke-width:1;stroke:rgb(0,0,0);fill-opacity:0.1;stroke-opacity:0.9;opacity:0.9;"/> 
    </svg>

（5）使用<img>标签::

    <img src="img/demo.svg" width="300px" height="300px"/>

（6）链接到svg文件::

    <a href="img/demo.svg">查看svg</a>

（7）在css中使用::

    .container{
      background: white url(img/demo.svg) repeat;
    }



.. [1] https://www.runoob.com/svg/svg-tutorial.html