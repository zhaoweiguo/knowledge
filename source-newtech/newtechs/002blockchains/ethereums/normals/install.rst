安装
####

Install from a package manager
==============================

Install on macOS via Homebrew::

    $ brew tap ethereum/ethereum
    $ brew install ethereum

    // 安装master开发分支
    $ brew install ethereum --devel

    注: 以下命令会被保存在/usr/local/bin/目录中:
    abigen, bootnode, checkpoint-admin, clef, devp2p, ethkey, evm, 
    faucet, geth, p2psim, puppeth, rlpdump, and wnode 

Install on Ubuntu via PPAs::

    1. To enable our launchpad repository run:
    $ sudo add-apt-repository -y ppa:ethereum/ethereum
    
    2. Then install the stable version of go-ethereum:
    $ sudo apt-get update
    $ sudo apt-get install ethereum

    Or the develop version via:
    $ sudo apt-get update
    $ sudo apt-get install ethereum-unstable


Download standalone bundle [1]_
===============================

说明::

    主要有2个下载包:
    1. Geth 1.9.9: 只有geth命令
    2. Geth & Tools 1.9.9: 有geth命令和abigen, bootnode...等命令

Run inside Docker container
===========================

Docker地址::

    1. 只有geth命令
    ethereum/client-go:latest is the latest development version of Geth (default)
    ethereum/client-go:stable is the latest stable version of Geth
    ethereum/client-go:{version} is the stable version of Geth at a specific version number
    ethereum/client-go:release-{version} is the latest stable version of Geth at a specific version family

    2. 全部相关命令
    ethereum/client-go:alltools-latest is the latest development version of the Ethereum tools
    ethereum/client-go:alltools-stable is the latest stable version of the Ethereum tools
    ethereum/client-go:alltools-{version} is the stable version of the Ethereum tools at a specific version number
    ethereum/client-go:alltools-release-{version} is the latest stable version of the Ethereum tools at a specific version family

使用::

    $ docker pull ethereum/client-go
    $ docker run -it -p 30303:30303 ethereum/client-go
    注: 应该挂载磁盘保证数据不丢失
    $ docker run -v /data/xxx:/root/.ethereum -it -p 30303:30303 ethereum/client-go


The image has the following ports automatically exposed::

    8545 TCP, used by the HTTP based JSON RPC API
    8546 TCP, used by the WebSocket based JSON RPC API
    8547 TCP, used by the GraphQL API
    30303 TCP and UDP, used by the P2P protocol running the network

Build go-ethereum from source code
==================================

Most Linux systems and macOS::

    $ go get -d github.com/ethereum/go-ethereum
    $ go install github.com/ethereum/go-ethereum/cmd/geth

Building without a Go workflow::

    git clone https://github.com/ethereum/go-ethereum.git
    cd go-ethereum
    make geth

    注: geth executable file in the go-ethereum/build/bin

Backup & Restore
================

Data Directory::

    // The default data directory locations are platform specific:
    Mac: ~/Library/Ethereum
    Linux: ~/.ethereum
    Windows: %APPDATA%\Ethereum

 `ethash dag <https://geth.ethereum.org/docs/interface/mining>`_ is stored at::

    ~/.ethash (Mac/Linux)
    %APPDATA%\Ethash (Windows) 

Cleanup::

    $ geth removedb

Blockchain Import/Export::

    $ geth export <filename>
    $ geth import <filename>

    指定起止block, 如:back up the first epoch
    $ geth export <filename> 0 29999










.. [1] https://geth.ethereum.org/downloads/