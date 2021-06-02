ETHEREUM OPTIONS
================

--syncmode value::

    1. Full: Downloads all blocks (including headers, transactions and receipts) 
        and generates the state of the blockchain incrementally by executing every block.
    2. Fast (Default): Downloads all blocks (including headers, transactions and receipts), 
        verifies all headers, and downloads the state and verifies it against the headers.
    4. Light: Downloads all block headers, block data, and verifies some randomly.

    实例:
    $ geth --syncmode "light"

    $ geth console --syncmode "light"


--networkid value [1]_ ::
  
    // create your own private testnet.
    Network identifier (integer, 1=Frontier, 2=Morden (disused), 3=Ropsten, 4=Rinkeby) (default: 1)

    value是大于0的整数
    1. 以太网主网(Ethereum Mainnet)
    2. Expanse Network
    3. Ethereum Testnet Ropsten
    4. Ethereum Testnet Rinkeby 


.. [1] 主要的networkid: https://chainid.network/