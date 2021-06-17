API AND CONSOLE OPTIONS
=======================

http
====

api 相关参数::

    // rpcapi 启动后允许连接到系统的API协议
    geth --networkid 100000 --rpc --rpcapi "db,eth,net,web3" --rpccorsdomain "*" --datadir "/app/chain" --port "30303" console  
    // 系统默认监听 127.0.0.1 如果希望外部访问本机，需要通过--rpcaddr指定监听地址
    geth --networkid 123456 --rpc --rpcaddr="0.0.0.0" --rpccorsdomain "*" --nodiscover    

.. option:: rpcapi

    // --rpcapi 可以控制访问内容
    $ geth --rpc --rpcapi personal,db,eth,net,web3 --rinkeby  

.. option:: rpcaddr

    默认是 127.0.0.1
    HTTP endpoint closed: http://127.0.0.1:8545
    通过 --rpcaddr="0.0.0.0" 指定监听地址
    HTTP endpoint opened: http://0.0.0.0:8545


--ipcdisable::

    禁止ipc

--rpcport value::

    HTTP-RPC server listening port (default: 8545)

--rpccorsdomain value::

    Comma separated list of domains from which to accept cross origin requests (browser enforced)
    Use --rpccorsdomain '*' to enable access from any origin.
    $ geth --rpc --rpccorsdomain https://remix.ethereum.org

Websocket
=========

启动 Websocket 端口::

    geth --syncmode light --rpc --rpcaddr 0.0.0.0 --rpcapi web3,eth --ws --wsaddr 0.0.0.0 --wsapi web3,eth --wsorigins '*'

    安装 websocket 测试工具 wscat
    npm install -g wscat
    测试 Websocket
    wscat -c ws://127.0.0.1:8546

--wsapi value::

    API's offered over the WS-RPC interface
    $ geth --ws --wsport 3334 --wsapi eth,net,web3


--wsorigins value::

    Origins from which to accept websockets requests
    using --wsorigins '*' allows access from any origin
    $ geth --ws --wsorigins http://myapp.example.com




其他
####

.. option:: verbosity

    --verbosity 日志输出级别控制
    geth --verbosity 0 console

--preload value::

    Comma separated list of JavaScript files to preload into the console
    实例:
    $ geth console --preload "/my/scripts/folder/utils.js,/my/scripts/folder/contracts.js"

--exec value::

    Execute JavaScript statement


实例::

    $ geth --datadir="~/ethereum/data" --rpc=true --rpcport 8545 --rpccorsdomain "*" --rpcaddr="10.140.2.17" console


