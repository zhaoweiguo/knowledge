context
#######


作用::

    1. 控制goroute
    2. 超时处理
    3. 传参数

    用来设置截止日期、同步信号，传递请求相关值的结构体

::

    type Context interface {
      Deadline() (deadline time.Time, ok bool)
      Done() <-chan struct{}
      Err() error
      Value(key interface{}) interface{}
    }

::

    context.Background
    context.TODO
    context.WithDeadline
    context.WithValue


比较常见的使用场景是::

    传递请求对应用户的认证令牌
    以及用于进行分布式追踪的请求 ID






