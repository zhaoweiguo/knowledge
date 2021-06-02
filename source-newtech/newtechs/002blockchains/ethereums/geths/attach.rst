geth attach命令
###############


连接控制台::

    // 启动
    $ geth --networkid 123456 --rpc --rpcaddr="0.0.0.0" --rpccorsdomain "*" --nodiscover &  
    // 进入控制台
    $ geth attach

    // 指定 geth.ipc 文件位置
    $ geth --ipcpath ~/.ethereum/geth.ipc attach
    //IPC 方式连接
    $ geth attach ethereum/data1/geth.ipc 
    // TCP 连接控制台
    $ geth --exec 'eth.coinbase' attach http://172.16.0.10:8545
    // WebSocket 方式
    $ geth attach ws://191.168.1.1:8546

运行JS::

    $ geth --exec "eth.blockNumber" attach
    531
    $ geth --exec 'loadScript("/tmp/checkbalances.js")' attach http://123.123.123.123:8545
    $ geth --jspath "/tmp" --exec 'loadScript("checkbalances.js")' attach http://123.123.123.123:8545     




