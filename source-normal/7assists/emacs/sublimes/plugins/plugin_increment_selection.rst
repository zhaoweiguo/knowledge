插入多行递增数字
################

Increment selection 插件
========================

在 Sublime Text 中为每个选择添加一个数字，每个选择增加一次。

默认的快捷键是::

    ctrl alt i or cmd ctrl i.


插件地址: https://packagecontrol.io/packages/Increment%20Selection

Examples
--------

Tips: [] stands for a selection, | stands for a caret::

    [1] text [1] text [1] -> 1| text 2| text 3|
    [a] text [a] text [a] -> a| text b| text c|
    [A] text [A] text [A] -> A| text B| text C|
    [01] text [01] text [01] -> 01| text 02| text 03|
    [05,2] text [05,2] text [05,2] -> 05| text 07| text 09|
    [5,-1] text [5,-1] text [5,-1] -> 5| text 4| text 3|
    [a,3] text [a,3] text [a,3] -> a| text d| text g|
    
Increment follows the difference between the first and second element::

    [10] text [9] text [1] -> 10| text 9| text 8|   
    [a] text [c] text [a] -> a| text c| text e|

Generate line numbers(显示当前行)::

    [#] line -> 1| line
    [#] line -> 2| line
    [#] line -> 3| line
    [#] line -> 4| line
    [#] line -> 5| line

InsertNums 插件
===============

安装::

    Ctrl+Shift+P 调用 Package Control
    输入 pki，选择 Package Control：Install Package
    输入 InsertNums，选择 InsertNums 安装

快捷键::

     Ctrl+Alt+N
     or
     Cmd + Option + N

Emmet 插件
==========

安装::

    Ctrl+Shift+P 调用 Package Control
    输入 pki，选择 Package Control：Install Package
    输入 Emmet，选择 Emmet 安装

使用::

    直接在编辑器中输入，然后按 Tab 即可。（文件格式需要为 HTML）

    todo
    更多使用场景，用的时候再说









