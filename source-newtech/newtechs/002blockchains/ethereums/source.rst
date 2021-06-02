源码学习
########

Testing
=======

Testing a package::

    $ go test -v ./eth

Running an individual test::

    $ go test -v ./eth -run TestMethod

Running benchmarks, eg.::

    $ go test -v -bench . -run BenchmarkJoin


devp2p
======

安装::

    $ go get -u github.com/ethereum/go-ethereum/cmd/devp2p
    $ go get -u github.com/ethereum/go-ethereum/cmd/ethkey


使用::

    $ devp2p discv4 crawl -timeout 30m all-nodes.json

    $ devp2p nodeset filter all-nodes.json -eth-network mainnet > mainnet.nodes.example.org/nodes.json

The following filter flags are available::

    -eth-network ( mainnet | ropsten | rinkeby | goerli ) selects an Ethereum network.
    -les-server selects LES server nodes.
    -ip <mask> restricts nodes to the given IP range.
    -min-age <duration> restricts the result to nodes which have been live for the given duration.

Creating DNS trees::

    $ ethkey generate dnskey.json
    $ devp2p dns sign mainnet.nodes.example.org dnskey.json

Publishing DNS trees::

    $ devp2p dns to-cloudflare mainnet.nodes.example.org









