下划线的用法
############

用在 import
===========

实例::

    import (
      "database/sql"
      "fmt"
      _ "github.com/go-sql-driver/mysql"
      _ "net/http/pprof"
    )

.. note:: pprof 和 MySQL 是常见用法。它会引入包，会先调用包中的 init() 函数，这种使用方式仅让导入的包做初始化，而不使用包中其他函数。


用在返回值
==========

实例::

    for _,v := range Slice{} // 表示丢弃索引值。


用在变量(接口实现检查)
======================

实例-gin源码::

    type responseWriter struct {
      http.ResponseWriter
      size   int
      status int
    }

    var _ ResponseWriter = &responseWriter{}













