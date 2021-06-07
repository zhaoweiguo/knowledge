java临时目录
=================
::

   java -Xmx1536m -Xms1536m -Xmn512m -XX:PermSize=128m -XX:MaxPermSize=256m -Xss1m -XX:+UseParallelGC -XX:ParallelGCThreads=20  -XX:+UseParallelOldGC -XX:+UseParallelOldGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+ScavengeBeforeFullGC -jar ip2city-finagle-jar-with-dependencies.jar  /data/online/ganji_services/ip2city/config.properties








   
