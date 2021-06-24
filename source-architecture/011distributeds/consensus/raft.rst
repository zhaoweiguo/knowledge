The Raft Consensus Algorithm [1]_
#################################


Raft 算法是Paxos 算法的一种简化实现。
包括三种角色：leader、candidate 和 follower，其基本过程为：
* Leader 选举：每个 candidate 随机经过一定时间都会提出选举方案，最近阶段中得票最多者被选为 leader；
* 同步 log：leader 会找到系统中 log 最新的记录，并强制所有的 follower 来刷新到这个记录；
注：此处 log 并非是指日志消息，而是各种事件的发生记录。




* http://thesecretlivesofdata.com/raft
* https://github.com/maemual/raft-zh_cn/blob/master/raft-zh_cn.md
* https://mp.weixin.qq.com/s/ohTXhFFywGHGDOkzO45aaQ


MIT6.824
========

* https://zhuanlan.zhihu.com/p/110168818
* https://www.zhihu.com/question/29597104
* https://github.com/chaozh/MIT-6.824
* https://blog.microdba.com/%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F/2020/02/26/mit-6.824-lecture-1-introduce/




MongoDB r3.2.0 以前选举协议是基于 Bully 算法，从 r3.2.0 开始默认使用基于 Raft 算法的选举策略




.. [1] https://raft.github.io/