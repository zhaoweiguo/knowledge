3. Hyperledger
##############

* Uneasy lies the head that wears a crown.
* GitHub: https://github.com/hyperledger

.. note:: Hyperledger 项目是首个面向企业的开放区块链技术的重要探索。在 Linux 基金会的支持下，吸引了包括 IBM、Intel、摩根等在内的众多科技和金融巨头的参与。




账本平台项目
============

1. Fabric::

    包括:
      Fabric
      Fabric CA
      Fabric SDK（包括 Node.Js、Python 和 Java 等语言）
      fabric-api
      fabric-sdk-node
      fabric-sdk-py
    目标是区块链的基础核心平台，支持 pbft 等新的 consensus 机制，支持权限管理
    最早由 IBM 和 DAH 发起

2. SawToothLake::

    包括 arcade、core、dev-tools、validator、mktplace 等
    是 Intel 主要发起和贡献的区块链平台，支持全新的基于硬件芯片的共识机制 Proof of Elapsed Time（PoET）

3. Iroha::

    账本平台项目，基于 C++ 实现，带有不少面向 Web 和 Mobile 的特性，主要由 Soramitsu 发起和贡献

4. Blockchain Explorer::

    提供 Web 操作界面，通过界面快速查看查询绑定区块链的状态（区块个数、交易历史）信息等

5. Cello::

    提供"Blockchain as a Service" 功能，
    使用 Cello，管理员可以轻松获取和管理多条区块链；应用开发者可以无需关心如何搭建和维护区块链

项目原则
========

项目约定共同遵守的 基本原则 为：
* 重视模块化设计，包括交易、合同、一致性、身份、存储等技术场景；
* 代码可读性，保障新功能和模块都可以很容易添加和扩展；
* 演化路线，随着需求的深入和更多的应用场景，不断增加和演化新的项目。

社区组织
========

社区目前主要是三驾马车领导的结构::

    * Technical Steering Committee (技术委员会):
        负责技术相关的工作，下设多个工作组，具体带动各个项目的发展
    * Governing Board (管理董事会):
        负责社区组织的整体决策，由 Hyperledger 会员中推选出代表
    * Linux Foundation (Linux 基金会):
        协助 Hyperledger 社区在 Linux 基金会的支持下发展

其他
====

* 类似的项目还包括:
  * 以太坊平台: https://ethereum.org/en/
  * R3 CEV 牵头的 Corda 项目: https://r3cev.com/blog/2016/4/4/introducing-r3-corda-a-distributed-ledger-designed-for-financial-services
  * 微软的 bletchley 项目: https://github.com/Azure/azure-blockchain-projects



源码分析
========

* Hyperledger 源码分析之 Fabric: https://github.com/yeasy/hyperledger_code_fabric




