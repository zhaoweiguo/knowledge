Graphviz基本
###################

几种布局引擎::

  dot ： 默认布局方式，主要用于有向图
  neato ： 主要用于无向图
  twopi ： 主要用于径向布局
  circo ： 圆环布局
  fdp ： 主要用于无向图
  sfdp ： 主要绘制较大的无向图
  patchwork ： 主要用于树哈希图（tree map）

输出图片格式::

  pdf ：
  gif
  png ：
  jpeg ： 一种有损压缩图片格式
  bmp ： 一种位图格式
  svg ： 矢量图，一般用与Web，，可以用浏览器打开
  ps ： 矢量线图，多用于打印
  更多的输出格式:http://www.graphviz.org/content/output-formats

fontname::

  fontname="Microsoft YaHei"
  edge [fontname="Microsoft YaHei"];
  node [fontname="Microsoft YaHei"];
  % 中文
  黑体：SimHei 
  宋体：SimSun 
  新宋体：NSimSun 
  仿宋：FangSong 
  楷体：KaiTi 
  新细明体：PMingLiU
  细明体：MingLiU
  标楷体：DFKai-SB
  微软正黑体：Microsoft JhengHei
  微软雅黑体：Microsoft YaHei



颜色说明:

.. figure:: /images/tools_graphviz_color.jpg
   :width: 80%

形状:

.. figure:: /images/tools_graphviz_shape.png
   :width: 80%

箭头:


.. figure:: /images/tools_graphviz_arrow.png
   :width: 80%






