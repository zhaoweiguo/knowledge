并发相关
##########


线程池ThreadPoolTaskExecutor::

    <bean id="taskExecutor" class="org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor">
      <!-- 核心线程数 -->
      <property name="corePoolSize" value="4000" />
      <!-- 最大线程数 -->
      <property name="maxPoolSize" value="20000" />
      <!-- 队列最大长度 -->
      <property name="queueCapacity" value="2000" />
      <!-- 线程池维护线程所允许的空闲时间 -->
      <property name="keepAliveSeconds" value="30" />
      <!-- 线程池对拒绝任务(无线程可用)的处理策略 -->
      <property name="rejectedExecutionHandler">
          <bean class="java.util.concurrent.ThreadPoolExecutor$DiscardPolicy" />
      </property>
  </bean>

常用的拒绝策略如下::

    AbortPolicy         它将抛出RejectedExecutionException
    CallerRunsPolicy    它直接在execute方法的调用线程中运行被拒绝的任务
    DiscardOldestPolicy 它放弃最旧的未处理请求，然后重试execute
    DiscardPolicy       默认情况下它将丢弃被拒绝的任务


.. figure:: /images/languages/javas/java_thread_pool.png
   :width: 80%










