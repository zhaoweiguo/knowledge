初始化创建
##########

Clique Example
==============

.. literalinclude:: /files/blockchains/ethereums/config_init_clique.json

Clique: Running A Signer::

    $ geth <other-flags> --unlock 0x7df9a875a174b3bc565e6424a0050ebc1b2d1d82 --mine



Ethash Example
==============

.. literalinclude:: /files/blockchains/ethereums/config_init_ethash.json

Ethash: Running A Miner::

    $ geth <other-flags> --mine --minerthreads=1 --etherbase=0x0000000000000000000000000000000000000000



初始化创建步骤
==============

新增配置文件:genesis.json::

  {
    "config": {   // 定义个人链的设置
          "chainId": 0,         // 你个人链的唯一标识
          "homesteadBlock": 0,  // 定义ethereum平台的version和protocol
          "eip155Block": 0,     // 用于支持non-backward-compatible协议的改变
          "eip158Block": 0      // 
      },
    "alloc"      : {},
    "coinbase"   : "0x0000000000000000000000000000000000000000",
    "difficulty" : "0x2000",    // 挖矿难度
    "extraData"  : "",
    "gasLimit"   : "0x2fefd8",  // 燃料限制，越大限制越少
    "nonce"      : "0x0000000000000042",
    "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
    "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
    "timestamp"  : "0x00"
  }
  // 注:
  // 1. 不想让别人连接你的话，修改nonce的值
  // 2. 可以修改alloc的值来预先给帐户钱
  "alloc": {
    "0x0000000000000000000000000000000000000001": {"balance": "111111111"},
    "0x0000000000000000000000000000000000000002": {"balance": "222222222"}
  }

Initializing the Geth Database::

  $ geth  --datadir "/data/chain" init genesis.json

初始创建后，就可用以下命令启动::

  $ geth --datadir "/data/chain" --networkid 15 console

启动后可以用以下命令连接::

  $ geth attach /data/chain/geth.ipc


Scheduling Hard Forks(安排硬分叉)
=================================

说明::

    升级以太坊时用到

指定硬分叉的Block::

    // assume your network is running and its current block number is 35421
    {
      "config": {
        ...
        "istanbulBlock": 40000,
        ...
      },
      ...
    }

关闭所有结点并执行::

    $ geth init --datadir data genesis.json







