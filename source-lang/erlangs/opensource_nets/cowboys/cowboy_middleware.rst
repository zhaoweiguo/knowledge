cowboy_middleware
######################



Usage::

  % 中间件只需要实现execute/2函数
  -behavior(cowboy_middleware).

  中间件返回以下3种返回值
  {ok, Req, Env} to continue the request processing
  {suspend, Module, Function, Args} to hibernate
  {stop, Req} to stop processing and move on to the next request








