Apache Airflow
##############

* http://airflow.apache.org/

* airflow是airbnb家的基于DAG(有向无环图)的任务管理系统, 最简单的理解就是一个高级版的crontab。它解决了crontab无法解决的任务依赖问题。
* 不过 Airflow 有个主要问题 : " 太依赖于 Python 编程 , 需要做大量的 Python 扩展 , 任务的依赖编排都要通过写 Python 实现 "





类似产品比较
============

* `Apache Oozie <Apache_Oozie>`_
* Linkedin Azkaban:  web界面尤其很赞, 使用java properties文件维护任务依赖关系, 任务资源文件需要打包成zip, 部署不是很方便.
* airflow 具有自己的web任务管理界面，dag任务创建通过python代码，可以保证其灵活性和适应性




