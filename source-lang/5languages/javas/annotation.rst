Java注解
############

@SpringBootApplication::

    用来标注项目入口，以及完成一些基本的自动自动配置

@EnableScheduling::

    使@Schedule注解功能可用的注解


@Scheduled定时::

    @Scheduled(fixedRate = 6000) ：上一次开始执行时间点之后6秒再执行
    @Scheduled(fixedDelay = 6000) ：上一次执行完毕时间点之后6秒再执行
    @Scheduled(initialDelay=1000, fixedRate=6000) :第一次延迟1秒后执行，之后按fixedRate的规则每6秒执行一次

@Order::

    设定执行顺序，由小到大依次执行
    例: @Order(value=1)
    



Spring 注解配置 [1]_
-----------------------

.. function:: @Autowired


说明::

    自动装配:
    可以对类成员变量、方法及构造函数进行标注，完成自动装配的工作
    通过 @Autowired的使用来消除 set ，get方法
    在Spring 2.5 引入了 @Autowired 注释
    当Spring发现@Autowired注解时，将自动在代码上下文中找到和其匹配（默认是类型匹配）的Bean，并自动注入到相应的地方去  


.. function:: @Resource

说明::

  类似@Autowired
  @Autowired和@Resource两个注解的区别:
  1、@Autowired默认按照byType方式进行bean匹配, @Resource默认按照byName方式进行bean匹配
  2、@Autowired是Spring的注解，@Resource是J2EE的注解

实例::

    @Resource(name = "tiger")
    private Tiger tiger;
    
    @Resource(type = Monkey.class)
    private Monkey monkey;

.. function:: @Service

说明::

    @Service: 声明是个Service,声明是一个bean




.. function:: @Qualifier

说明::

    使用@Autowired时，如果指定类有2个实现，可使用@Qualifier("xxx")指定具体哪个实现类

.. function:: @Configuration

说明::

    用于定义配置类，可替换xml配置文件，被注解的类内部包含有一个或多个被@Bean注解的方法
    这些方法将会被扫描，并用于构建bean定义，初始化Spring容器

注意::

    1. @Configuration不可以是final类型
    2. @Configuration不可以是匿名类
    3. 嵌套的configuration必须是静态类



.. [1] https://www.cnblogs.com/szlbm/p/5512931.html



