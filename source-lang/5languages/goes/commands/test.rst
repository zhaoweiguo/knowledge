.. _go_test:

go test命令
#################


usage::

    go get [-d] [-f] [-t] [-u] [-v] [-fix] [-insecure] [build flags] [packages]
    go help test

要求::

    1. 写有单元测试的文件名，必须以_test.go结尾。
    2. 测试文件要包含若干个测试函数。
    3. 这些测试函数要以Test为前缀，还要接收一个*testing.T类型的参数。


实例见  :ref:`go_testing`





