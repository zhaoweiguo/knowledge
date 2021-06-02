.. _resource:

########
resource
########

7, Webmachine Resource:

    7.1 include_lib 文件::

        -include_lib("webmachine/include/webmachine.hrl").

    7.2 init/1 function
    这是个必备函数，返回值一般是{ok, Context},其中这个Context变量就是前面我们说的webmachine不会做任何操作，
    留给用户作扩展功能用的变量！这个变量是在这个fun init/1 中被初使化。
    另一种返回值是{{trace, Dir}, Context}，这种是用于调试用的，具体察看后面的调试模块介绍！
    7.3 格式
    如上面<3, 约定格式>说写
    7.4 Halting Resources::

        {error,Err::term()}:立即终止这次請求，返回500Internal Server Error, response body 里包含Err term.
        {halt,Code::integer()}:立即终止这次請求，返回請求代码Code，It is the responsibility of the resource to ensure that all necessary response header and body elements are filled in ReqData in order to make that response code valid.

    下面是对这些函数的具体描述！

8, Resource Functions
    8.1 





