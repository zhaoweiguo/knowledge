eth相关函数
###########

.. function:: web3.eth.sendTransaction

格式::

     web3.eth.sendTransaction(transactionObject [, callback])

参数::

    1. Object - The transaction object to send:
        from: String ->
            发送帐号,默认为 web3.eth.defaultAccount property
        to: String -> (optional)
            消息的目的地址, 智能合约的话,值为undefined
        value: Number|String|BigNumber -> (optional) 
            交易价值,单位是Wei
        gas: Number|String|BigNumber - (optional, default: To-Be-Determined) 
            用于交易的gas数量(unused gas is refunded).
        gasPrice: Number|String|BigNumber - (optional, default: To-Be-Determined) 
            交易的gas价值,单位wei, 默认是平均network gas price.
        data: String - (optional) 
            Either a byte string containing the associated data of the message, or in the case of a contract-creation transaction, the initialisation code.
        nonce: Number - (optional) 
            Integer of a nonce. This allows to overwrite your own pending transactions that use the same nonce.
    2. Function - (optional) 
        If you pass a callback the HTTP request is made asynchronous. See this note for details.

实例::

    var code = "0x999f1e5ee3ce7a58400b2f6c559cfd9e5a71aa39fbfe663492edf9305df69ecf";
    web3.eth.sendTransaction({data: code}, function(err, transactionHash) {
     if (!err)
       console.log(transactionHash); // "0x7f9fade1c0d57a7af66ab4ead7c2eb7b11a91385"
    });

