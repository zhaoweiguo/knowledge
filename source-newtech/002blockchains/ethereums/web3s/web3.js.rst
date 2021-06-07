web3.js
#############

连接到以太坊客户端::

    1. http 方式
    var Web3 = require('web3');
    var web3 = new Web3('http://localhost:8545');

    2. WebSocket 方式
      
    var Web3 = require('web3');
    var web3 = new Web3(Web3.givenProvider || 'ws://remotenode.com:8546');

    3. IPC 方式
      
    // Using the IPC provider in node.js
    var net = require('net');
    var Web3 = require('web3');
    var web3 = new Web3('/Users/myuser/Library/Ethereum/geth.ipc', net); // mac os path

查看账号列表::

    var Web3 = require('web3');
    var web3 = new Web3('http://localhost:8545');
    web3.eth.getAccounts().then(console.log);

查询矿工账号::

    var Web3 = require('web3');
    var web3 = new Web3('http://localhost:8545');
    web3.eth.getCoinbase().then(console.log);

    // Callback 方式
    web3.eth.getCoinbase(
        function(error, result){ 
        if (error) {
            console.error(error);
        } else {
            console.log(result); 
        }
     })

获得余额::

    web3.eth.getBalance(req.query.address).then(function(balance){
          res.json({"status": true, "code":0, "data":{"account":req.query.address, "balance": web3.utils.fromWei(balance)}}); 
    });
    // Callback 方式
    web3.eth.getBalance(req.query.address, function (error, wei) {
        if (!error) {
            var balance = web3.utils.fromWei(wei, 'ether');
            res.json({"status": true, "code":0, "data":{"account":req.query.address, "balance": balance}});
        }else{
            console.log(error);
            res.json({"status": false, "code":1, "data":{"error":error.message}});
        }
    });
    // 捕捉错误
    router.get('/balance.json', function(req, res) {
      try {
        web3.eth.getBalance(req.query.address, function (error, wei) {
            if (!error) {
                var balance = web3.utils.fromWei(wei, 'ether');
                res.json({"status": true, "code":0, "data":{"account":req.query.address, "balance": balance}});
            }else{
                console.log(error);
                res.json({"status": false, "code":1, "data":{"error":error.message}})
             }
        });
      }
      catch(error){
        res.json({"status": false, "code":1, "data":{"error":error.message}});
      };

    });

web3.eth.sendTransaction()::

    web3.eth.sendTransaction({
          from: coinbase,
          to: '0x2C687bfF93677D69bd20808a36E4BC2999B4767C',
          value: web3.utils.toWei('2','ether')
      },
      function(error, result){
          if(!error) {
              console.log("#" + result + "#")
          } else {
              console.error(error);
          }
    });

    var code = "0x603d80600c6000396000f3007c01000000000000000000000000000000000000000000000000000000006000350463c6888fa18114602d57005b6007600435028060005260206000f3";

    web3.eth.sendTransaction({from: coinbase, data: code}, function(err, transactionHash) {
      if (!err)
        console.log(transactionHash); // "0x7f9fade1c0d57a7af66ab4ead7c2eb7b11a91385"
    });

    web3.eth.sendTransaction({from: coinbase, data: code}).then(function(receipt){
            console.log(receipt);
    });

web3.eth.sendSignedTransaction() 私钥签名转账::

    例子1:
    var account = web3.eth.accounts.privateKeyToAccount(privateKey);

    web3.eth.accounts.signTransaction({
        from: account.address,
        to: "0x0013a861865d74b13ba94713d4e84d97c57e7081",
        gas: "3000000",
        value: '100000000000000000',
        gasPrice: '0x09184e72a000',
        data: "0x00"
      }, account.privateKey)
    .then(function(result) {
      console.log("Results: ", result)

      web3.eth.sendSignedTransaction(result.rawTransaction)
        .on('receipt', console.log);
    })


.. literalinclude:: /files/blockchains/ethereums/transfer.js


web3.eth.getBlock() 获取区块::

    // 获取 pending 状态的区块
    web3.eth.getBlock(
        "pending",
    function (error, block) {
        if (error) {
            console.error(error);
        } else {
            console.log(block.transactions.length); 
        }
    });

账号管理::

    var coinbase = "0x5c18a33DF2cc41a1bedDC91133b8422e89f041B7";
    //console.log(coinbase)
    web3.eth.personal.unlockAccount(coinbase, "your password").then(console.log);




  // 查询默认帐户余额
  > web3.fromWei(eth.getBalance(eth.coinbase), "ether")
  // 查询第2个帐户余额
  web3.fromWei(eth.getBalance(eth.accounts[1]),"ether")






