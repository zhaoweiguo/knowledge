元素点 [1]_
###########

矩形 <rect>
===========

.. literalinclude:: ./files/item_rect.svg
.. image:: ./files/item_rect.svg
   :width: 30%

解析::

    x                 矩形左上角的x位置
    y                 矩形左上角的y位置
    rx                圆角的x方位的半径
    ry                圆角的y方位的半径
    width             矩形的宽度
    height            矩形的高度
    fill              设置对象内部的填充颜色
    fill-opacity      控制填充色的不透明度（范围：0 - 1）
    stroke            定义矩形边框的颜色
    stroke-opacity    控制描边的不透明度（范围：0 - 1）
    stroke-width      定义矩形边框的宽度


圆形 <circle>
=============


.. literalinclude:: ./files/item_circle.svg
.. image:: ./files/item_circle.svg

解析::

    r       圆的半径
    cx      圆点的x坐标
    cy      圆点的y坐标

椭圆 <ellipse>
==============

.. literalinclude:: ./files/item_ellipse.svg
.. image:: ./files/item_ellipse.svg
   :width: 30%

解析::

    cx      椭圆中心的x坐标
    cy      椭圆中心的y坐标
    rx      定义的水平半径
    ry      定义的垂直半径


线条 <line>
===========

.. literalinclude:: ./files/item_line.svg
.. image:: ./files/item_line.svg
   :width: 30%

解析::

    x1    起点的x位置
    y1    起点的y位置
    x2    终点的x位置
    y2    终点的y位置

折线 <polyline>
===============

.. literalinclude:: ./files/item_polyline.svg
.. image:: ./files/item_polyline.svg

解析::

    points:
    每个点必须包含2个数字，一个是x坐标，一个是y坐标。
    所以点列表 (0,0), (1,1) 和(2,2)可以写成这样：“0 0, 1 1, 2 2”

多边形 <polygon>
================

.. literalinclude:: ./files/item_polygon.svg
.. image:: ./files/item_polygon.svg
   :width: 40%

解析::

    points
    每个点必须包含2个数字，一个是x坐标，一个是y坐标。
    所以点列表 (0,0), (1,1) 和(2,2)可以写成这样：“0 0, 1 1, 2 2”
    路径绘制完后闭合图形，所以最终的直线将从位置(2,2)连接到位置(0,0)

.. note:: 和折线很像，它们都是由连接一组点集的直线构成。不同的是，<polygon> 的路径在最后一个点处自动回到第一个点

路径 <path>
===========

.. note:: path元素是SVG基本形状中最强大的一个，它不仅能创建其他基本形状，还能创建更多其他形状。你可以用path元素绘制矩形（直角矩形或者圆角矩形）、圆形、椭圆、折线形、多边形，以及一些其他的形状，例如贝塞尔曲线、2次曲线等曲线。path元素的形状是通过属性d来定义的，属性d的值是一个“命令+参数”的序列

svg的 <path>命令::

    大写表示绝对定位，小写表示相对定位
    M = moveto
    L = lineto
    H = horizontal lineto
    V = vertical lineto
    C = curveto(曲线；弯曲)
    S = smooth curveto(平滑曲线)
    Q = quadratic Bézier curve(二次方贝塞尔曲线)
    T = smooth quadratic Bézier curveto(平滑二次方贝塞尔曲线)
    A = elliptical Arc(椭圆弧)
    Z = closepath(从当前点画一条直线到路径的起点)

直线命令
--------

.. literalinclude:: ./files/item_path11.svg
.. image:: ./files/item_path11.svg


.. literalinclude:: ./files/item_path12.svg
.. image:: ./files/item_path12.svg


.. literalinclude:: ./files/item_path13.svg
.. image:: ./files/item_path13.svg

曲线命令
--------

三次贝塞尔曲线
--------------

.. literalinclude:: ./files/item_path21.svg
.. image:: ./files/item_path21.svg

.. literalinclude:: ./files/item_path22.svg
.. image:: ./files/item_path22.svg

.. literalinclude:: ./files/item_path23.svg
.. image:: ./files/item_path23.svg

二次贝塞尔曲线
--------------

.. literalinclude:: ./files/item_path31.svg
.. image:: ./files/item_path31.svg

.. literalinclude:: ./files/item_path32.svg
.. image:: ./files/item_path32.svg

弧形
----

A命令的参数::

    A rx ry x-axis-rotation large-arc-flag sweep-flag x y
    或者
    a rx ry x-axis-rotation large-arc-flag sweep-flag dx dy

    rx ry: 弧形命令A的前两个参数分别是x轴半径和y轴半径
    x-axis-rotation: 弧形命令A的第三个参数表示弧形的旋转情况
    large-arc-flag（角度大小） 和sweep-flag（弧线方向）
      large-arc-flag决定弧线是大于还是小于180度，0表示小角度弧，1表示大角度弧
      sweep-flag表示弧线的方向，0表示从起点到终点沿逆时针画弧，1表示从起点到终点沿顺时针画弧


.. literalinclude:: ./files/item_path41.svg
.. image:: ./files/item_path41.svg


.. literalinclude:: ./files/item_path42.svg
.. image:: ./files/item_path42.svg

文本
=====

.. literalinclude:: ./files/item_text1.svg
.. image:: ./files/item_text1.svg


.. literalinclude:: ./files/item_text2.svg
.. image:: ./files/item_text2.svg

.. literalinclude:: ./files/item_text3.svg
.. image:: ./files/item_text3.svg

.. literalinclude:: ./files/item_text4.svg
.. image:: ./files/item_text4.svg

.. literalinclude:: ./files/item_text5.svg
.. image:: ./files/item_text5.svg

标记元素marker
==============
可依附于<path> <line> <polyline> <polygon>元素上，写在<des></des>标签内部，常见的用法是为线段添加箭头。当然也可以为图形元素添加其他内容(如终点处添加圆形、矩形等)

.. literalinclude:: ./files/item_marker1.svg
.. image:: ./files/item_marker1.svg

参数说明::

    viewBox：坐标系区域
    refX refY：viewBox内的基准点，绘制时该点在线上
    makerUnits：标记大小的基准，取值有两个[ strokeWidth| userSpaceOnUse ]
      可以是以线的宽度为基准，也可选择以线前端的大小为基准。
      标记大小根据基准等比放大或者缩小
    markerWidth markerHeight：标记的大小
    orient：绘制方向，auto或者角度值
    id：标记ID


.. literalinclude:: ./files/item_marker2.svg
.. image:: ./files/item_marker2.svg


.. literalinclude:: ./files/item_marker3.svg
.. image:: ./files/item_marker3.svg



.. [1] https://www.jianshu.com/p/c819ae16d29b