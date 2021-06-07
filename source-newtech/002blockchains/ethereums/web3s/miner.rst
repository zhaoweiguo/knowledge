miner Namespace
###############

miner_setEtherbase
==================

+---------+-------------------------------------------------------+
| Client  | Method invocation                                     |
+=========+=======================================================+
| Go      | miner.SetEtherbase(common.Address) bool               |
+---------+-------------------------------------------------------+
| Console | miner.setEtherbase(address)                           |
+---------+-------------------------------------------------------+
| RPC     | {"method": "miner_setEtherbase", "params": [address]} |
+---------+-------------------------------------------------------+

::

    // 设置默认矿工账号
    > miner.setEtherbase("0x83fda0ba7e6cfa8d7319d78fa0e6b753a2bcb5a6")

    // 实例:
    > eth.accounts
    > eth.coinbase
    > miner.setEtherbase("0xe8abf98484325fd6afc59b804ac15804b978e607")
    > eth.coinbase


  // 开始挖矿
  miner.start(1)
  // 停止挖矿
  miner.stop()
  // 说明：当出现“Mined block”这样的字眼时，说明成功挖矿




