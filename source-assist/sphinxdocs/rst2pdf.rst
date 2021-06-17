.. _rst2pdf:

rst2pdf的使用
##################

* 关联 [1]_
* github [2]_

.. note::
    pip3只能安装最高版本到0.93.x(不建议)
    pip2能安装到最高版本0.94.1(建议)

中文问题解决 [3]_

::

  1. 首先导出rst2pdf默认的stylesheet
    $> rst2pdf --print-stylesheet > ~/.rst2pdf/styles/chinese.style

  2. 打开这个文件,指定汉字字体(如仿宋Fangsong.ttf)
    embeddedFonts: [Fangsong.ttf]
    fontsAlias:
      stdFont: Fangsong
      ...
      字体都改成simhei
  3. 把字体拷贝到指定目录(如字体在/Library/Fonts等目录下,可以不用拷贝)
    $ cp /Library/Fonts/Microsoft/Fangsong.ttf ~/.rst2pdf/styles/
  4. 执行:
     $> rst2pdf -s ~/.rst2pdf/styles/chinese.style --font-path=~/.rst2pdf/styles/ file.rst
  5. 设定rst2pdf默认配置以便可以直接执行下面语句:
    $> rst2pdf file.rst

chiness.style [6]_

rst2pdf默认配置 [7]_,参考 [4]_

颜色 [5]_
::

    注: 这个只可用于rst2pdf生成pdf加颜色
      另外, sphinx生成html加颜色链接也有说明

    # 在配置文件chinese.style文件中增加
    bluetext:
      parent: bodytext
      textColor: blue

    # 在使用的地方调用
    .. role:: bluetext
    :redtext:`blue`

    .. role:: redtext
    :bluetext:`red`






.. [1] :ref:`sublime的rst插件自动生成pdf文件 <plugin_rst>`
.. [2] https://github.com/rst2pdf
.. [3] https://blog.csdn.net/yuyan21/article/details/9297629
.. [4] https://www.cnblogs.com/windtail/p/8260317.html
.. [5] https://stackoverflow.com/questions/3702865/sphinx-restructuredtext-set-color-for-a-single-word
.. [6] .. literalinclude:: /files/sphinxdocs/chinese.style
.. [7] .. literalinclude:: /files/sphinxdocs/rst.config