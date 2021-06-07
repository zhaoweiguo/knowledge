cowboy2.x改变
###############

2.0 => 2.1::

  增加2.0版本临时移除feature
  bug fix

2.1 => 2.2::

  增加gRPC服务所需要的features
  为核心HTTP RFCs增加test suites,并修改相关bug

2.2 => 2.3::

  让项目符合OTP原则
  此版本是个好的里程碑，建议用户升级

2.3 => 2.4::

  force on改变HTTP/2实现,增加了HTTP/2上对WebSocket的支持
  增加了多个选项以control SETTINGS and related behavior
  所有存在的RFC7540 and the h2spec test suite都通过

2.4 => 2.5::

  force on  test suites通过
  增加新features,fix bug
  Update Ranch to 1.6.2
  Update Cowlib to 2.6.0