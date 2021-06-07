历史
####

* 2007 年，MongoDB 公司的前身 10gen 正式成立，2009 年 2 月开源数据库 MongoDB 1.0 正式面世，以开源的方式进入市场接受考验。时至今日，MongoDB 已经从一个在数据库领域籍籍无名的 “小透明”，变成了话题度和热度都很高的 “流量” 数据库。
* 2009 年 2 月，MongoDB 数据库首次在数据库领域亮相，打破了关系型数据库一统天下的局面；
* 2014 年 12 月，MongoDB 收购了 Keith Bostic 和 Michael Cahil 的 WiredTiger 存储引擎团队，并将其集成到 3.0 版本中，成为一个新的存储引擎。WiredTiger 的引入是 MongoDB 走向一个成熟数据库的最重要的里程碑。在性能上，WiredTiger 较之老版本的 MongoDB 提升了 7-10 倍，有效地解决了之前 MMAP 在大量写入下的性能瓶颈。
* 2015 年 12 月，在发布的 3.2 版本中，在 MongoDB 的聚合框架（Aggregation）中增加了一个不起眼的操作符: $lookup。 这个看上去虽小，但是意义巨大的功能意味着第一次作为一个 NoSQL 数据库，MongoDB 终于开始支持了关系型数据库的核心功能：关联。从 3.2 开始，你可以一次同时查询多个 MongoDB 的集合（表），不用像以前那样，如果有多表查询需要在代码中发起多个数据库查询，然后在内存中进行手工关联。
* 2016 年，MongoDB 推出 Atlas，在 AWS、 Azure 和 GCP 上的 MongoDB 托管服务；Atlas 成为 MongoDB 发展最快的一个业务。
* 2017 年广为人知的 “MongoDB 赎金” 事件，因默认不需要用户名密码登录的设置，屡次发生的企业数据泄露事件。（58 同城 2 亿份简历事件）
* 2017 年 10 月，MongoDB 成功在纳斯达克敲钟，成为 26 年来第一家以数据库产品为主要业务的上市公司。
* 2018 年 6 月，MongoDB推出 4.0 版本，支持 ACID 事务支持，成为第一个支持强事务的 NoSQL 数据库。（按原计划本该发布 3.8 的，但是由于引入了千呼万唤始出来的多文档 ACID 强事务机制，MongoDB 决定版本改为 4.0）
* 2018 年 11 月，MongoDB 将其开源授权从 AGPL 到 SSPL；对于绝大绝大部分的开发者或企业，SSPL 和 AGPL 没有任何区别。只有那些在公有云上提供 MongoDB 托管服务 (MongoDB as a Service) 的公有云厂商会在 SSPL 协议下受到影响：要么和 MongoDB 达成商业合作采用商业协议，要么开源其所有云管理解决方案。（MongoDB 之前有 Redis，之后有 Kafka，都在类似的背景下作了开源协议修改。）



参考
====

* MongoDB 十年发展全纪录: https://www.infoq.cn/article/XBME_sTIRA5fA8NDCaGj


