java配置文件说明
==============================

JVM参数的含义::

  -Xms    初始堆大小
      物理内存的1/64(<1GB)默认(MinHeapFreeRatio参数可以调整)空余堆内存小于40%时，JVM就会增大堆直到-Xmx的最大限制.
  -Xmx    最大堆大小
      物理内存的1/4(<1GB)默认(MaxHeapFreeRatio参数可以调整)空余堆内存大于70%时，JVM会减少堆直到 -Xms的最小限制
  -Xmn    年轻代大小(1.4or lator)
      整个堆大小=年轻代大小 + 年老代大小 + 持久代大小. 增大年轻代后,将会减小年老代大小.此值对系统性能影响较大,Sun官方推荐配置为整个堆的3/8
  -XX:NewSize设置年轻代大小(for 1.3/1.4)  
  -XX:MaxNewSize年轻代最大值(for 1.3/1.4)  
  -XX:PermSize设置持久代(perm gen)初始值物理内存的1/64 
  -XX:MaxPermSize设置持久代最大值物理内存的1/4 
  -Xss每个线程的堆栈大小


from:  http://www.cnblogs.com/redcreen/archive/2011/05/04/2037057.html
