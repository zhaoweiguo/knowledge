常用类
##########


CommandLineRunner::

    可用@Order指定顺序
    Spring Beans初始化之后执行
    run(String... strings)  % 参数一般不用

ThreadPoolTaskExecutor::

    需要实现并发、异步等操作时用
    提交任务:
      无返回值的任务使用execute(Runnable)
      有返回值的任务使用submit(Runnable)







