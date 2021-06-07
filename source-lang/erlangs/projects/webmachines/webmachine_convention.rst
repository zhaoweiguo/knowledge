.. _convertion:

########
约定格式
########

约定格式:
    在具体的介绍前先确定下格式, ``webmachine`` 类型的模块所有 ``function`` 都是如下格式( ``init/1`` 函数除外): ::

        f(ReqData, Context) -> {Result, ReqData, Context}

    参数说明：
        * ReqData: 它是http請求的对象，里面存放着所有http請求的数据！(它实际上应该是webmachine对mochiweb中的Reqest和Response实例化对象(就这样理解吧，用OOA)的封装)！
        * Context: webmachine留给你用的， 为方便你进行扩展功能！webmachine不对它进行处理，如果你不对它进行处理，它进来什么样，出去就是什么样！
        * Result: 这个就是你返回的結果了！

类型声明:
    再确定下变量的基本类型，主要有下面几种(其他常用的就不说了)
    * ``string()``: 字符串类型
    * ``rd()``: ``opaque record`` 的简称！实质就是ReqData，即前面说的webmachine的請求对象！
    * ``streambody()``: 
    * ``mochiwebheaders()``:

