.. _sphinx_img:

图片
####

说明::

    There are two image directives: image and figure.
    An image is a simple picture.
    A figure consists of 
        image data (including image options), 
        an optional caption (a single paragraph), 
        and an optional legend (arbitrary body elements). 

        For page-based output media, figures might float to a different position if this helps the page layout.

image
=====


Example for image usage::

    .. image:: picture.jpg
       :width: 200px
       :height: 100px
       :scale: 50 %
       :alt: alternate text
       :align: right

::

    .. image:: https://travis-ci.org/rtfd/sphinx_rtd_theme.svg?branch=master
       :target: https://travis-ci.org/rtfd/sphinx_rtd_theme
       :alt: Build Status
    .. image:: https://img.shields.io/pypi/l/sphinx_rtd_theme.svg
       :target: https://pypi.python.org/pypi/sphinx_rtd_theme/
       :alt: License
    .. image:: https://readthedocs.org/projects/sphinx-rtd-theme/badge/?version=latest
      :target: http://sphinx-rtd-theme.readthedocs.io/en/latest/?badge=latest
      :alt: Documentation Status



figure
======

.. note:: A figure is an image with a caption and/or a legend:



Example for figure usage::

    .. figure:: picture.png
       :scale: 50 %
       :alt: map to buried treasure

   This is the caption of the figure (a simple paragraph).



::

    .. figure:: image/photo.jpg
       :width: 20%, 12.0cm  % image宽度
       :figwidth:  % 图片宽度
       :scale: 50 %
       :alt: map to buried treasure
       :align : left, center, or right   % 指定「标题」位置

       『图片标题』



    width说明:
      +---------------------------+
      |        figure             |
      |                           |
      |<------ figwidth --------->|
      |                           |
      |  +---------------------+  |
      |  |     image           |  |
      |  |                     |  |
      |  |<--- width --------->|  |
      |  +---------------------+  |
      |                           |
      |The figure's caption should|
      |wrap at this width.        |
      +---------------------------+

    注释:
        .. -*- coding:utf-8 -*-


