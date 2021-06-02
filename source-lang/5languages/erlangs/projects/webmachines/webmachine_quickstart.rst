.. _quickstart:

快速学习
=========

.. _quickstart_hello:

建立简单框架
-------------

* 下载webmachine::

    git clone git://github.com/basho/webmachine

* 快速搭建应用框架::

    ./scripts/new_webmachine.sh APPNAME DIR //APPNAME and DIR can be indicated!
    cd DIR/APPNAME
    make
    ./start.sh

* 访问"http://127.0.0.1:8000"

.. _quickstart_detail:

简单细节
--------


    like plain otp, it begins with (use the appName: test)::

        test.erl ---> test.app ---> test_app.erl ---> test_sup.erl

    in test_sup.erl, it started [webmachine_mochiweb] server(not a normal server).
    here, we don't care about what has happen in detail. We should just know that it will return
    to find "priv/dispatch.conf" file(it can be changed in file "test_sup.erl", 
    you can change to what you want by modifying "{dispatch, Dispatch}"). 

    Now, we'll see the content of the file "dispatch.conf"::

        %%-*- mode: erlang -*-
        {["test1", '*'], test_demo1, []}.
        {["test2", '*'], test_demo2, [{root, "/tmp/fs"}]}.

the detail can be found in the files "test_demo1.erl" and "test_demo2.erl"

注意：
    如果启动两个webmachine的项目时，会遇到一系列的问题：

    * 两个Webmachine applications不能同时启动！
    *


