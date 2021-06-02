引用,链接,图片
##############


引用，链接::


    链接:
        `链接显示名 <http://blog.programfan.info/>`_

    另一形式:
    Test hyperlink: SO_
    .. _SO: http://stackoverflow.com/


站内链接::

        :ref:`链接显示，右面是文件开头的索引 <header_1>`

        这是链接的另一形式,链接到ablog.rst
        :doc:`ablog`

    引用:
        使用: xxxxx [1]_
        展示: .. [1]  xxxxx

    // 章节引用
    .. _my-reference-label:

    Section to cross-reference
    --------------------------

    This is the text of the section.
    It refers to the section itself, see :ref:`my-reference-label`.

下载专用::

    :download:`图片/文件下载 <image/photo.jpg>`

    会呈现出点击后下载文件的效果。
    注意这种引用方式在生成 pdf 文件时链接会无效


图片引用(:ref:`参考 <sphinx_img>`)::

    .. _my-figure:

    .. figure:: whatever

       Figure caption


