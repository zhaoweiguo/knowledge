.. _ci_helpers:

CI Helper函数
===================

* Helper不是OO格式，只是些简单的过程函数
* 存放在 ``application/helpers`` 的 ``system/helpers`` 目录中
* 载入一个文件名为 ``url_helper.php`` 的Helper::

    $this->load->helper('url');

* 注意:Helper载入的函数并不返回值，因此不要想着把它赋值给一变量！它只能用于显示

* 载入成功之后你就可以像使用标准PHP函数一样使用它


