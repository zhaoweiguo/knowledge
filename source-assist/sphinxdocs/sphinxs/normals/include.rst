文件包含
########



::

    1.包含另一个reStructuredText文件:
    .. include:: path/to/file.rst

    2.包含代码文件:
    实例一:

       .. literalinclude:: /path/to/file.erl
           :language: erlang
           :emphasize-lines: 12,15-18  //亮显
           :linenos: //显示行号
           :encoding: latin-1
           :pyobject: Timer.start
           :lines: 1,3,5-10,20-    % 显示指定行
           :dedent: 4


        language选项:
            erlang
            php
            matlab
            sh
            ruby
            bash

        emphasize-lines（加亮行）::
            12, 13, 14
            12-14
            12-

        encoding::
            latin-1



