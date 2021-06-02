----
title: 从零开始创建专属自己的以太坊
date: 2018-05-22 11:46:32
categories:
- blockchain
tags:
- blockchain
- 以太坊
----


### 安装环境说明

```
>cat /etc/issue
Debian GNU/Linux 9 \n \l
```
注: debian基本版本也可用，其他linux系统可微调后使用

###Golang的安装:

1.打开go下载链接
https://golang.org/dl/
//以debian为例，安装当前最新版本1.10.2

```
>wget  https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz
>tar -C /usr/local -xzf go1.10.2.linux-amd64.tar.gz
```

<!--more-->


修改文件

```
>vi $HOME/.profile
or
>vi /etc/profile

export PATH=$PATH:/usr/local/go/bin
```
注：这儿默认的GOPATH目录为 $HOME/go
不懂golang的同学不用在意这个

在命令行执行
```
>go version
go version go1.10.2 linux/amd64
```
说明成功安装golang

### ethereum的安装

打开ethereum的github地址
https://github.com/ethereum/go-ethereum
执行:
```
>cd $HOME
>git clone https://github.com/ethereum/go-ethereum.git
```
注:需要先安装git
```
>apt-get install git-core
```
进入go-ethereum目录后，执行
```
>cd go-ethereum
>make geth
注:上面命令只安装以太坊的主要命令geth
如果想安装全部命令，使用
>make all
```
上面命令后，如果上面一切顺利的话，就能得到文件
```
$HOME/go-ethereum/build/bin/geth
```
修改PATH
```
export PATH=$PATH:/usr/local/go/bin:$HOME/go-ethereum/build/bin
```

### 创建并启动自己的ethereum
```
>mkdir $HOME/eth
>cd $HOME/eth
>touch init.json
>vi init.json
```
往init.json文件中增加如下内容
```
{
  "config": {   // 定义个人链的设置
    "chainId": 0,         // 你个人链的唯一标识
    "homesteadBlock": 0,  // 定义ethereum平台的version和protocol
    "eip155Block": 0,     // 用于支持non-backward-compatible协议的改变
    "eip158Block": 0      //
  },
  "alloc"      : {  // 给指定用户很多的币
    "dbdbdb2cbd23b783741e8d7fcf51e459b497e4a6": { 
        "balance": "1606938044258990275541962092341162602522202993782792835301376"
    },
    "e6716f9544a56c530d868e4bfbacb172315bdead": {
      "balance": "1606938044258990275541962092341162602522202993782792835301376"
    }
  },
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "0x2000",    // 挖矿难度
  "extraData"  : "",
  "gasLimit"   : "0x2fefd8",  // 燃料限制，越大限制越少
  "nonce"      : "0x0000000000000042",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp"  : "0x00"
}
```
执行命令
```
// 初始化自己的ethereum
>geth  --datadir "$HOME/eth" init init.json

INFO [05-17|14:16:43] Maximum peer count                       ETH=25 LES=0 total=25
INFO [05-17|14:16:43] Allocated cache and file handles         database=/home/user/blockchain/geth/chaindata cache=16 h
andles=16
INFO [05-17|14:16:43] Writing custom genesis block
INFO [05-17|14:16:43] Persisted trie from memory database      nodes=3 size=505.00B time=75.246µs gcnodes=0 gcsize=0.00
B gctime=0s livenodes=1 livesize=0.00B
INFO [05-17|14:16:43] Successfully wrote genesis state         database=chaindata                            hash=86c6b
a…345170
INFO [05-17|14:16:43] Allocated cache and file handles         database=/home/user/blockchain/geth/lightchaindata cache
=16 handles=16
INFO [05-17|14:16:43] Writing custom genesis block
INFO [05-17|14:16:43] Persisted trie from memory database      nodes=3 size=505.00B time=36.625µs gcnodes=0 gcsize=0.00
B gctime=0s livenodes=1 livesize=0.00B
INFO [05-17|14:16:43] Successfully wrote genesis state         database=lightchaindata                            hash=
86c6ba…345170
```

```
// 启动ethereum
>geth --datadir "$HOME/eth" console

INFO [05-17|14:16:59] Maximum peer count                       ETH=25 LES=0 total=25
INFO [05-17|14:16:59] Starting peer-to-peer node               instance=Geth/v1.8.8-unstable-d2fe83dc/linux-amd64/go1.1
0.2
INFO [05-17|14:16:59] Allocated cache and file handles         database=/home/user/blockchain/geth/chaindata cache=768
handles=1024
WARN [05-17|14:16:59] Upgrading database to use lookup entries
INFO [05-17|14:16:59] Initialised chain configuration          config="{ChainID: 0 Homestead: 0 DAO: <nil> DAOSupport:
false EIP150: <nil> EIP155: 0 EIP158: 0 Byzantium: <nil> Constantinople: <nil> Engine: unknown}"
INFO [05-17|14:16:59] Disk storage enabled for ethash caches   dir=/home/user/blockchain/geth/ethash count=3
INFO [05-17|14:16:59] Disk storage enabled for ethash DAGs     dir=/home/user/.ethash                count=2
INFO [05-17|14:16:59] Initialising Ethereum protocol           versions="[63 62]" network=1
INFO [05-17|14:16:59] Loaded most recent local header          number=0 hash=86c6ba…345170 td=512
INFO [05-17|14:16:59] Loaded most recent local full block      number=0 hash=86c6ba…345170 td=512
INFO [05-17|14:16:59] Loaded most recent local fast block      number=0 hash=86c6ba…345170 td=512
INFO [05-17|14:16:59] Regenerated local transaction journal    transactions=0 accounts=0
INFO [05-17|14:16:59] Starting P2P networking
INFO [05-17|14:16:59] Database deduplication successful        deduped=0
INFO [05-17|14:17:01] UDP listener up                          self=enode://89737c7e003fdd34383370931e2d035488fe561889a
990022f045fe079bbdf390f6788737613de98602798614bff218b4919cbf21dbde4f6674a2757f5ba5dbc@[::]:30303
INFO [05-17|14:17:01] IPC endpoint opened                      url=/home/user/blockchain/geth.ipc
INFO [05-17|14:17:01] RLPx listener up                         self=enode://89737c7e003fdd34383370931e2d035488fe561889a
990022f045fe079bbdf390f6788737613de98602798614bff218b4919cbf21dbde4f6674a2757f5ba5dbc@[::]:30303
Welcome to the Geth JavaScript console!
```
看到最后的
Welcome to the Geth JavaScript console!
说明启动成功




