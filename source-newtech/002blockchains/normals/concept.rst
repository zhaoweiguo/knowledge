定义
####

* 密码朋克
* 比特水龙头
* 加文-安德烈森
* 影子链（shadow chain）


侧链(side chain)
================

::

    允许资产在比特币区块链和其它链之间互转。降低核心的区块链上发生交易的次数。


概念术语
========

* Auditability（审计性）：在一定权限和许可下，可以对链上的交易进行审计和检查。
* Block（区块）：代表一批得到确认的交易信息的整体，准备被共识加入到区块链中。
* Blockchain（区块链）：由多个区块链接而成的链表结构，除了首个区块，每个区块都包括前继区块内容的 hash 值。
* Certificate Authority（CA）：负责身份权限管理，又叫 Member Service 或 Identity Service。
* Chaincode（链上代码或链码）：区块链上的应用代码，扩展自“智能合约”概念，支持 golang、nodejs 等，运行在隔离的容器环境中。
* Committer（提交节点）：1.0 架构中一种 peer 节点角色，负责对 orderer 排序后的交易进行检查，选择合法的交易执行并写入存储。
* Confidentiality（保密）：只有交易相关方可以看到交易内容，其它人未经授权则无法看到。
* Endorser（背书节点）：1.0 架构中一种 peer 节点角色，负责检验某个交易是否合法，是否愿意为之背书、签名。
* Enrollment Certificate Authority（ECA，注册 CA）：负责成员身份相关证书管理的 CA。
* Ledger（账本）：包括区块链结构（带有所有的可验证交易信息，但只有最终成功的交易会改变世界观）和当前的世界观（world state）。Ledger 仅存在于 Peer 节点。
* MSP（Member Service Provider，成员服务提供者）：成员服务的抽象访问接口，实现对不同成员服务的可拔插支持。
* Non-validating Peer（非验证节点）：不参与账本维护，仅作为交易代理响应客户端的 REST 请求，并对交易进行一些基本的有效性检查，之后转发给验证节点。
* Orderer（排序节点）：1.0 架构中的共识服务角色，负责排序看到的交易，提供全局确认的顺序。
* Permissioned Ledger（带权限的账本）：网络中所有节点必须是经过许可的，非许可过的节点则无法加入网络。
* Privacy（隐私保护）：交易员可以隐藏交易的身份，其它成员在无特殊权限的情况下，只能对交易进行验证，而无法获知身份信息。
* Transaction（交易）：执行账本上的某个函数调用。具体函数在 chaincode 中实现。
* Transactor（交易者）：发起交易调用的客户端。
* Transaction Certificate Authority（TCA，交易 CA）：负责维护交易相关证书管理的 CA。
* Validating Peer（验证节点）：维护账本的核心节点，参与一致性维护、对交易的验证和执行。
* World State（世界观）：是一个键值数据库，chaincode 用它来存储交易相关的状态。











