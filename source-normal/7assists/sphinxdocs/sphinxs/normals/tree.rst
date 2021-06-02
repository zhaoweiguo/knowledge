树显示
######


toc树相关
=========

常用标签::

  :numbered:
  :titlesonly:
  :glob:
  :hidden:

::

    // 普通树
   .. toctree::
       :caption: 此目录树的标题
       :name: mastertoc
       :numbered:   % 树显示1.2.3.4列表数
       :titlesonly: % 只展示主标题,里面的子标题不展示
       :glob:       % 主要用于生成sitemap

       foo

    // 递归
    .. toctree::
        :glob:
        :reversed:

        recipe/*

    // 隐藏树
    .. toctree::
       :hidden:
       :maxdepth: 2

       hiddens/simple

    // 内置树
    .. contents::
       :depth: 1
       :local:
       :backlinks: none

sidebar
=======

::

    // 普通使用
    .. sidebar:: Sidebar标题

       siderbar 内容
        
       * **内容1**: `链接1 <http://zhaoweiguo.com/>`_
       * **内容2**: `链接2 <https://zhaoweiguo.com/>`_
       * **github**: ` <https://github.com/zhaoweiguo>`


    // 接合页内目录使用
    .. sidebar:: 本地目录

    .. contents::
       :depth: 1
       :local:
       :backlinks: none







