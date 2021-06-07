基本
####


单位::

    // Ether币最小的单位是Wei
    kwei (1000 Wei)
    mwei (1000 KWei)
    gwei (1000 mwei)
    szabo (1000 gwei)
    finney (1000 szabo)
    ether (1000 finney)

单位转换::

    > web3.fromWei(10000000000000000,"ether")
    > web3.fromWei(10000000000000000)

    > web3.toWei(1)
    > web3.toWei(1.3423423)



命令
----

::

    eth.accounts[0]
    eth.getBalance(eth.accounts[0])

    transaction = "0x1c3950f2e70c6d237cb39bb73bc529fdd1f0c7da5c95761f3c44aff7e5bc6734";
    eth.getTransaction(transaction);


    personal.unlockAccount(eth.accounts[0], "q1w2e3r4")

    var code = "603d80600c6000396000f3007c01000000000000000000000000000000000000000000000000000000006000350463c6888fa18114602d57005b6007600435028060005260206000f3";
    eth.sendTransaction({from: eth.accounts[0], data : code});

    web3.eth.sendTransaction({from: eth.accounts[0], data: code}, function(err, transactionHash) {
      if (!err)
        console.log(transactionHash);
    });









