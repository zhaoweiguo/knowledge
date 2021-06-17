.. _graphite:

graphite相关 [1]_
#######################


简介
--------------

* 官网: http://graphite.wikidot.com/
* 新官网: http://graphiteapp.org/
* 文档地址: http://graphite.readthedocs.org/en/latest/overview.html
* github: https://github.com/graphite-project/graphite-web.git

常见网址:

http://www.jsxubar.info/graphite-introduction.html/


::

   pip install django tagging parse_lookup django-tagging


Graphite由三个软件组件组成:

* carbon - 一个Twisted守护进程，监听时间序列数据
* whisper [2]_ – 一个简单的数据库库，用来存储时间序列数据，在设计上类似于RRD
* graphite webapp[1]_ – Django webapp，使用 Cairo来根据需要呈现图形

架构图如下：

.. figure:: /images/monitors/graphites/graphite_architecture.png
   :width: 50%


Browser Web效果图:

.. figure:: /images/monitors/graphites/graphite_ui1.png

   浏览器效果图


Command-Line效果图:

.. figure:: /images/monitors/graphites/graphite_ui2.png

   浏览器效果图






.. [1] https://github.com/graphite-project/graphite-web
.. [2] https://github.com/graphite-project/whisper




