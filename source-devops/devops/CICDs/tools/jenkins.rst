Jenkins [1]_
################

* Jenkins是一款开源 CI&CD 软件，用于自动化各种任务，包括构建、测试和部署软件。
* Jenkins 支持各种运行方式，可通过系统包、Docker 或者通过一个独立的 Java 程序。
* github [2]_

简介::

    授权协议: MIT
    开发语言: Java



.. toctree::
   :maxdepth: 1


   jenkins/normal
   jenkins/Jenkinsfile

Jenkins是一款由Java编写的开源的持续集成工具。在与Oracle发生争执后，项目从Hudson项目复刻。

Jenkins提供了软件开发的持续集成服务。它运行在Servlet容器中（例如Apache Tomcat）。它支持软件配置管理（SCM）工具（包括AccuRev SCM、CVS、Subversion、Git、Perforce、Clearcase和RTC），可以执行基于Apache Ant和Apache Maven的项目，以及任意的Shell脚本和Windows批处理命令。Jenkins的主要开发者是川口耕介。[3]Jenkins是在MIT许可证下发布的自由软件。

可以通过各种手段触发构建。例如提交给版本控制系统时被触发，也可以通过类似Cron的机制调度，也可以在其他的构建已经完成时，还可以通过一个特定的URL进行请求。



.. [1] https://jenkins.io/
.. [2] https://github.com/jenkinsci/jenkins