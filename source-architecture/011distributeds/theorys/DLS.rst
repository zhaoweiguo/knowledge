DLS
######

1. 在部分同步（partially synchronous）的网路环境中::

    （即网路延迟有一定的上限，但我们无法事先知道上限是多少）
    协议可以容忍最多 1/3 的拜占庭故障（Byzantine fault）

2. 在异步（asynchronous）的网路环境中::
   
    具确定性质的协议无法容忍任何错误
    randomized algorithms 在这种情况可以容忍最多 1/3 的拜占庭故障

3. 在同步（synchronous）的网路环境中::
   
    （即网路延迟有上限且上限是已知的）
    协议可以容忍 100% 的拜占庭故障，但当超过 1/2 的节点为恶意节点时，会有一些限制条件











参考
====

* DLS 论文(Consensus in the Presence of Partial Synchrony): http://groups.csail.mit.edu/tds/papers/Lynch/jacm88.pdf
* 以太坊的官方 Wiki - Proof of Stake FAQ: https://github.com/ethereum/wiki/wiki/Proof-of-Stake-FAQ



