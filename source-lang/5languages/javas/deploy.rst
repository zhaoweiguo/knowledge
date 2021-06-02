投产上线 [1]_
################

一种是打包成jar包直接执行
-------------------------
mvn打包命令::

    mvn clean package
    ## 或者执行下面的命令
    ## 排除测试代码后进行打包
    mvn clean package  -Dmaven.test.skip=true
    // 打包完成后jar包会生成到target目录下，命名一般是 项目名+版本号.jar

启动jar包命令::

    // 控制台运行
    java -jar  target/spring-boot-scheduler-1.0.0.jar
    // 后台运行
    nohup java -jar target/spring-boot-scheduler-1.0.0.jar &

    // 在启动的时候选择读取不同的配置文件
    java -jar app.jar --spring.profiles.active=dev

    // 在启动的时候设置jvm参数
    java -Xms10m -Xmx80m -jar app.jar &



打包成war包放到tomcat服务器下
---------------------------------
maven项目::

    修改pom包
    <packaging>war</packaging>

    打包时排除tomcat:
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-tomcat</artifactId>
      <scope>provided</scope>
    </dependency>
    // 将scope属性设置为provided

命令::

    mvn clean package  -Dmaven.test.skip=true

生产运维
-----------

查看JVM参数的值::

    // 来查看jar 启动后使用的是什么gc、新生代、老年代分批的内存都是多少
    jinfo -flags pid
    -XX:CICompilerCount=3 -XX:InitialHeapSize=234881024 -XX:MaxHeapSize=3743416320 -XX:MaxNewSize=1247805440 -XX:MinHeapDeltaBytes=524288 -XX:NewSize=78118912 -XX:OldSize=156762112 -XX:+UseCompressedClassPointers -XX:+UseCompressedOops -XX:+UseFastUnorderedTimeStamps -XX:+UseParallelGC

说明::

    -XX:CICompilerCount ：最大的并行编译数
    -XX:InitialHeapSize 和 -XX:MaxHeapSize ：指定JVM的初始和最大堆内存大小
    -XX:MaxNewSize ： JVM堆区域新生代内存的最大可分配大小
    …
    -XX:+UseParallelGC ：垃圾回收使用Parallel收集器






.. [1] http://www.ityouknow.com/springboot/2017/05/09/springboot-deploy.html






