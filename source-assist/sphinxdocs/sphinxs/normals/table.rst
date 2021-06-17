表格相关
########


::

    格式1:
    +------------------------+------------+----------+----------+
    | Header row, column 1   | Header 2   | Header 3 | Header 4 |
    | (header rows optional) |            |          |          |
    +========================+============+==========+==========+
    | body row 1, column 1   | column 2   | column 3 | column 4 |
    +------------------------+------------+----------+----------+
    | body row 2             | ...        | ...      |          |
    +------------------------+------------+----------+----------+

    格式2:
    .. table:: Truth table for "not"
       :widths: auto

        =====  =====  =======
        A      B      A and B
        =====  =====  =======
        False  False  False
        True   False  False
        False  True   False
        True   True   True
        =====  =====  =======

    格式3:
    .. csv-table:: 表3  应用目录下的子目录
        :widths: 10 90
        :header: 目录, 描述

            doc,     用于存放文档
            ebin,    用于存放编译后的代码（.beam文件）
            include, 用于存放公共头文件

    格式4:
    .. list-table:: 表4 list-table 表
       :widths: 15 10 30
       :header-rows: 1

       * - Treat
         - Quantity
         - Description
       * - Albatross
         - 2.99
         - On a stick!
       * - Crunchy Frog
         - 1.49
         - If we took the bones out, it wouldn't be
           crunchy, now would it?
       * - Gannet Ripple
         - 1.99
         - On a stick!

