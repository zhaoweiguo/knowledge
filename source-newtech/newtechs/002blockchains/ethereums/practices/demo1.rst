简单实操
########

如何计算Gas手续费::

    > var estimateGas = eth.estimateGas({from:eth.accounts[1], to: eth.accounts[2], value: web3.toWei(1)})
    undefined

    > console.log(estimateGas)
    21000
    undefined

    > var cost = estimateGas * gasPrice
    undefined

    > console.log(cost)
    378000000000000
    undefined

    > web3.fromWei(cost)
    "0.000378"


转账过程::

    1. 解锁
    > personal.unlockAccount(eth.accounts[0], "q1w2e3r4");
    true
    2. 转账
    > eth.sendTransaction({from: eth.accounts[0], data : "0x0c"});
    "0x5f5b0227108511f91db89f0aae641183856c4f2987158fb75aed6bb2fc12b3cc"

    > trans = "0x5f5b0227108511f91db89f0aae641183856c4f2987158fb75aed6bb2fc12b3cc";

    3. 刚开始, blockHash为0,说明挖矿还未成功,交易还未生效
    > eth.getTransaction(trans);
    {
      blockHash: "0x0000000000000000000000000000000000000000000000000000000000000000",
      blockNumber: null,
      from: "0xfd13005f4d9415b1c5cacecbedeb7d8f94468750",
      gas: 90000,
      gasPrice: 1000000000,
      hash: "0x5f5b0227108511f91db89f0aae641183856c4f2987158fb75aed6bb2fc12b3cc",
      input: "0x0c",
      nonce: 10,
      r: "0x88985aed98d6a1835fcf071e40448e72b7b7038bd7f0ab1d2754d8855089f336",
      s: "0x428c137455a6b083045b4a218cf82cb7fa3902a609cdc71eb2cb67e4248ac395",
      to: null,
      transactionIndex: 0,
      v: "0x41",
      value: 0
    }
    
    4. 一段时间后, 交易生效
    > eth.getTransaction(trans);
    {
      blockHash: "0x1009e504e9088eb88342924aa383ac951ec0438bee58fa761dbd9f2def270e85",
      blockNumber: 3299,
      from: "0xfd13005f4d9415b1c5cacecbedeb7d8f94468750",
      gas: 90000,
      gasPrice: 1000000000,
      hash: "0x5f5b0227108511f91db89f0aae641183856c4f2987158fb75aed6bb2fc12b3cc",
      input: "0x0c",
      nonce: 10,
      r: "0x88985aed98d6a1835fcf071e40448e72b7b7038bd7f0ab1d2754d8855089f336",
      s: "0x428c137455a6b083045b4a218cf82cb7fa3902a609cdc71eb2cb67e4248ac395",
      to: null,
      transactionIndex: 0,
      v: "0x41",
      value: 0
    }




转出账号中所有 ETH，Ethereum Wallet 中的 Send everything 实现方法::

    > personal.unlockAccount(eth.accounts[3], "12345678")
    true

    > eth.sendTransaction({from: eth.accounts[3], to: eth.accounts[5], value: eth.getBalance(eth.accounts[3]) - cost, gas: estimateGas})
    "0x4e27a477e128b200239bc2ecd899077c6ae064da963a919fef41bcc7462aec8d"

    // 查看交易细节
    > web3.eth.getTransaction("0x4e27a477e128b200239bc2ecd899077c6ae064da963a919fef41bcc7462aec8d")
    {
      blockHash: "0x59a9905831e7ae3cb9e7c6f125cf48e2688ef4b39317838f6f6b6c8837d01404",
      blockNumber: 4367,
      from: "0x8efb99ec55bcfbe2cfe47918f2d9e55fa732111f",
      gas: 21000,
      gasPrice: 18000000000,
      hash: "0x4e27a477e128b200239bc2ecd899077c6ae064da963a919fef41bcc7462aec8d",
      input: "0x",
      nonce: 15,
      r: "0xa297401df3a1fb0298cbc1dd609deebe9ded319fadc55934ecef4d525198215",
      s: "0x780d8c46bc8d1bb89ae9d78055307d9d68a4f89ba699ef86d3f8ba88383139a6",
      to: "0xf0688330101d53bd0c6ede2ef04d33c2010e9a5d",
      transactionIndex: 0,
      v: "0x42",
      value: 999622000000000000
    }

    // 现在查看from账号，余额已经清零
    > eth.getBalance(eth.accounts[3])
    0





    // 返回交易信息
    > web3.eth.getTransaction("0xece08c46f872bc70406f67c7ce03ba9606532f3459fdaa8b8efeeb12ac8f1004")
    > eth.getBlock(213)
    // 返回交易收据
    > web3.eth.getTransactionReceipt("0x4e27a477e128b200239bc2ecd899077c6ae064da963a919fef41bcc7462aec8d")

    // 返回值说明
    Object - 交易的收据对象，如果找不到返回null 
    blockHash: String - 32字节，这个交易所在区块的哈希。
    blockNumber: Number - 交易所在区块的块号。
    transactionHash: String - 32字节，交易的哈希值。
    transactionIndex: Number - 交易在区块里面的序号，整数。
    from: String - 20字节，交易发送者的地址。
    to: String - 20字节，交易接收者的地址。如果是一个合约创建的交易，返回null。
    cumulativeGasUsed: Number - 当前交易执行后累计花费的gas总值10。
    gasUsed: Number - 执行当前这个交易单独花费的gas。
    contractAddress: String - 20字节，创建的合约地址。如果是一个合约创建交易，返回合约地址，其它情况返回null。
    logs: Array - 这个交易产生的日志对象数组。  

eth.syncing 同步状态::

    > eth.syncing
    // 显示百分比
    > console.log(parseInt(eth.syncing.currentBlock/eth.syncing.highestBlock*100,10)+'%')
    // 剩余块数
    eth.syncing.highestBlock - eth.syncing.currentBlock
    setInterval(function(){
      console.log(eth.syncing.highestBlock - eth.syncing.currentBlock)
    },5000);
    // 进度监控
    var lastPercentage = 0;var lastBlocksToGo = 0;var timeInterval = 10000;
    setInterval(function(){
        var percentage = eth.syncing.currentBlock/eth.syncing.highestBlock*100;
        var percentagePerTime = percentage - lastPercentage;
        var blocksToGo = eth.syncing.highestBlock - eth.syncing.currentBlock;
        var bps = (lastBlocksToGo - blocksToGo) / (timeInterval / 1000)
        var etas = 100 / percentagePerTime * (timeInterval / 1000)

        var etaM = parseInt(etas/60,10);
        console.log(parseInt(percentage,10)+'% ETA: '+etaM+' minutes @ '+bps+'bps');

        lastPercentage = percentage;lastBlocksToGo = blocksToGo;
    },timeInterval);







