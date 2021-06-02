Dev mode
########

Starting geth in dev mode does the following::

    1. Initializes the data directory with a testing genesis block
    2. Sets max peers to 0
    3. Turns off discovery by other nodes
    4. Sets the gas price to 0
    5. Uses the Clique PoA consensus engine with which allows blocks to be mined as-needed 
        without excessive CPU and memory consumption
    6. Uses on-demand block generation, producing blocks when 
        there are transactions waiting to be mined

启动::

    $ mkdir test-chain-dir
    $ geth --dev --datadir test-chain-dir console
    注: 需要指定--datadir, 不然数据存储在内存






