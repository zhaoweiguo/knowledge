软件架构
########

并发
====

* 1978 年就被 :ref:`东尼・霍尔 <person_Tony-Hoare>` 提出CSP并发模型
* 1985年，FLP定理的论文由Fischer, Lynch and Patterson三位作者发表,之后该论文毫无疑问得获得了Dijkstra奖
* 1987年普林斯顿大学的赫克托・加西亚・莫利纳（Hector Garcia Molina）和肯尼斯・麦克米伦（Kenneth Salem）在 ACM 发表的一篇论文《SAGAS》
* 20世纪 90 年代，IBM Almaden 研究院总结了研发原型数据库系统 “IBM System R” 的经验，发表了 ARIES 理论中最主要的三篇论文
* 1991 年的时候 X/Open 组织（后来并入了 The Open Group）提出了一套叫做 X/Open XA（XA 是 eXtended Architecture 的缩写）的事务处理框架。
* 2000 年 7 月 加州大学伯克利分校的埃里克・布鲁尔（Eric Brewer）教授在“ACM 分布式计算原理研讨会（PODC）” 上提出的一个猜想—— :ref:`CAP <cap>` 理论又叫 Brewer 理论。
* 2002 年，麻省理工学院的赛斯・吉尔伯特（Seth Gilbert）和南希・林奇（Nancy Lynch）就以严谨的数学推理证明了这个 CAP 猜想。


架构
====

* 20 世纪 80 年代初，出现了一些大型软件系统，亟需一种统一的模式(也就是后来的架构)来解决设计这些庞大系统所面临的 一些常见问题。从那时开始，演化出了今天我们所熟知的“软件架构”的概念。
* 2014 年，微服务真正崛起， Martin Fowler 和 James Lewis 合写文章 “Microservices: a definition of this new architectural term”，定义了现代微服务的概念。



虚拟化&容器化
=============

* 2004-2007, Google大规模使用容器(cgroup)技术
* 2007 年，数据库专家帕特・赫兰德（Pat Helland）在撰写的论文《Life beyond Distributed Transactions: An Apostate’s Opinion》中提出：TCC（Try-Confirm-Cancel）是除可靠消息队列以外的另一种常见的分布式事务机制。
* 2008.01, cgroup合并到Linux主干
* 2008 年，eBay 的系统架构师丹・普利切特（Dan Pritchett）发表于 ACM 的论文 “Base: An Acid Alternative” 中提出『最终一致性』的概念
* 2012 年，在波兰克拉科夫举行的 “33rd Degree Conference” 大会上，Thoughtworks 首席咨询师 James Lewis 做了题为 《Microservices - Java, the Unix Way》 的主题演讲
* 2013.03, Docker正式发布
* 2014.06, Kubernetes正式发布
* 2015.07, CNCF成立(22个创始成员)
* 2015-2016, 容器编排三国争霸
* 2017.07, CNCF有14个项目, 170个成员, Kubernetes成为编排标准
* 2018.07, CNCF有19(+11)个项目,195个成员



