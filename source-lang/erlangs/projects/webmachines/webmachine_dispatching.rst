.. _dispatching:

Dispatching
###############

简介
=========
* dispatch map data(从文件 ``priv/dispatch.conf`` 中读取) 是3元或4元的tuple格式::

    {pathspec, resource, args}
     or 
    {pathspec, guard, resource, args}

*  dispatch map data的数据会默认从 ``priv/dispatch.conf`` 文件里读取, 然后用 ``file:consult`` 得到这个文件里的内容！这块可以通过修改根sup文件里面的内容来修改这个文件对应目录！


具体说明
================

* ``pathspec`` :是一列表，格式 ``[string, atom, star]`` ，三种元素组成, 其中 ``star`` 格式为'*':
  請求后webmachine会把 ``<url>`` 根据 ``"/"`` 进行分隔, 然后进行匹配:

    * string: 需要完全匹配
    * atom: 型匹配任一个
    * star('*'): 匹配任意个

* ``guard``:是一个一个参数的函数，格式为fun my_guard/1或者{module, my_fun}(注：fun module:my_fun/1)
* ``resource``:是原子类型，指定哪个模块来进行处理！
* ``args``:参数列表，list类型。它会被作为参数，传入到上面 ``resource`` 指定的模块的 ``init/1`` 函数中！


举例说明
==============


例一
--------
* 参数:

    * Url: http://HostName:Port/web
    * dispatch: {["web"], test_web, []}

* 分析::

    pathspec ==> ["web"]
    resource ==> test_web
    args ==>[]

* 如上面确定Url和dispatch后，系统会自动调用::

    test_web:init([]).  (这儿参数为空！)

* 方法：::

    wrq:disp_path ==> ""
    wrq:path: ==> "/a"
    wrq:path_info: ==> []
    wrq:path_tokens: ==> []

例二
----------
* 参数:

    * Url: "http://HostName:Port/web/gordon/b/c/d"
    * dispatch: {["web", name, '*'], test_web, []}

* 方法::

    wrq:disp_path: "b/c/d"
    wrq:path: "/web/gordon/b/c/d"
    wrq:path_info: [{name, "gordon"}]
    wrq:path_tokens: ["b", "c", "d"]



例三
-----------------
* 参数:

    * Url: http://127.0.0.1:8000/test/a/b/c/d?e=3&f=4&g=5
    * dispatch: {["test", name, '*'], test_name, []}.

* 方法::

    wrq:disp_path/1: ==> "b/c/d"
    wrq:path/1: ==> "/test/a/b/c/d"
    wrq:path_info/1 ==> {dict,1,16,16,8,80,48,
       {[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]},
       {{[],[],[],[],[],[[name,97]],[],[],[],[],[],[],[],[],[],[]}}}
    wrq:path_tokens/1 ==> ["b","c","d"]
    wrq:req_body ==> <<>>
    wrq:req_body ==> <<>>


