Paxos算法
#########

.. note:: There is only one consensus protocol, and that's “Paxos” — all other approaches are just broken versions of Paxos.世界上只有一种共识协议，就是 Paxos，其他所有共识算法都是 Paxos 的退化版本。—— Mike Burrows，Inventor of Google Chubby

Paxos 算法将分布式系统中的节点分为三类节点::

    提案节点: Proposer
    决策节点: Acceptor
    记录节点: Learner


.. note:: Paxos 是典型的基于 ``操作转移模型`` 而非 ``状态转移模型`` 来设计的算法，所以这里的 “设置值” 不要类比成程序中变量的赋值操作，而应该类比成日志记录操作。因此，我在后面介绍 Raft 算法时，就索性直接把 “提案” 叫做 “日志” 了。


两个因素的共同影响::

    系统内部各个节点间的通讯是不可靠的。
      它们发出、收到的信息可能延迟送达、也可能会丢失，但不去考虑消息有传递错误的情况。
    系统外部各个用户访问是可并发的。
      如果请求对系统进行串行访问，那单纯地应用 Quorum 机制，少数节点服从多数节点，就已经足以保证值被正确地读写了。

Paxos 算法是怎么解决并发操作带来的竞争的::

    Paxos 算法包括 “准备（Prepare）” 和 “批准（Accept）” 两个阶段。

1. “准备”（Prepare）就相当于抢占锁的过程::

     如果某个提案节点准备发起提案，必须先向所有的决策节点广播一个许可申请（称为 Prepare 请求）。
     提案节点的 Prepare 请求中会附带一个全局唯一的数字 n 作为提案 ID，决策节点收到后，会给提案节点两个承诺和一个应答。

     两个承诺是指:
      承诺不会再接受提案 ID 小于或等于 n 的 Prepare 请求；
      承诺不会再接受提案 ID 小于 n 的 Accept 请求。

    一个应答是指:
      在不违背以前作出的承诺的前提下，回复已经批准过的提案中 ID 最大的那个提案所设定的值和提案 ID
      如果该值从来没有被任何提案设定过，则返回空值。

      如果违反此前做出的承诺，即收到的提案 ID 并不是决策节点收到过的最大的
      那就可以直接不理会这个 Prepare 请求。

2. 当提案节点收到了多数派决策节点的应答（称为 Promise 应答）后，可以开始第二阶段 “批准”（Accept）过程::

    todo






* Paxos Made Simple: https://lamport.azurewebsites.net/pubs/paxos-simple.pdf


