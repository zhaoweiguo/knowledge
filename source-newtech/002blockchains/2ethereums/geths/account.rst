geth account
############

格式::

    $ geth account <command> [options...] [arguments...]

    COMMANDS:
     list    Print summary of existing accounts
     new     Create a new account
     update  Update an existing account
     import  Import a private key into a new account


$ geth account list --help::

    list [command options] [arguments...]

    Print a short summary of all accounts

    OPTIONS:
      --datadir "/home/bas/.ethereum"  Data directory for the databases and keystore
      --keystore                       Directory for the keystore (default = inside the datadir)


.. warning:: DO NOT FORGET YOUR PASSWORD


Keys存储目录::

    账号创建在 ~/.ethereum/keystore 目录下
    Mac: ~/Library/Ethereum/keystore
    Linux: ~/.ethereum/keystore
    Windows: %APPDATA%/Ethereum/keystore

创建账号
========

geth命令(interactive use)::

    $ geth account new
    Your new account is locked with a password. Please give a password. Do not forget this password.
    Passphrase:
    Repeat Passphrase:
    Address: {168bc315a2ee09042d83d7c5811b533620531f67}

指定密码创建(Non-interactive use)::

    $ echo "abc123" > password 
    $ geth --password /path/to/password account new

    注意:
      this is meant to be used for testing only, it is a bad idea to 
          save your password to file or expose in any other way.

 
On the console::

    > personal.NewAccount()
    ... you will be prompted for a password ...

    or

    > personal.newAccount("passphrase")


Creating an account by importing a private key
==============================================

用法::

    // interactive mode
    $ geth account import <keyfile>

    // non-interactive mode
    $ geth account import --password <passwordfile> <keyfile>

实例::

    // Import private key into a node with a custom datadir
    $ geth account import --datadir /someOtherEthDataDir ./key.prv
    The new account will be encrypted with a passphrase.
    Please enter a passphrase now.
    Passphrase:
    Repeat Passphrase:
    Address: {7f444580bfef4b9bc7e14eb7fb2a029336b07c9d}


首先将私钥存储到文件中，然后导入，导入后需要输入密码::

    $ echo "f592b7bf06ca9fd7696ba95d6ed8e357de6a2379b6d5fe1ffd53c6b4b063cd4a" > privatekey
    $ geth account import ./privatekey

查看导入文件::

    $ ls .ethereum/keystore/*372fda02e8a1eca513f2ee5901dc55b8b5dd7411
    $ cat .ethereum/keystore/UTC--2018-04-27T09-25-48.189741023Z--372fda02e8a1eca513f2ee5901dc55b8b5dd7411


Non-interactive use::

    $ geth account import  --datadir /someOtherEthDataDir --password /path/to/anotherpassword ./key.prv




查看账号
========

::

    $ geth account list
    $ geth account list --keystore /tmp/mykeystore/
    Account #0: {5afdd78bdacb56ab1dad28741ea2a0e47fe41331} keystore:///tmp/mykeystore/UTC--2017-04-28T08-46-27.437847599Z--5afdd78bdacb56ab1dad28741ea2a0e47fe41331
    Account #1: {9acb9ff906641a434803efb474c96a837756287f} keystore:///tmp/mykeystore/UTC--2017-04-28T08-46-52.180688336Z--9acb9ff906641a434803efb474c96a837756287f

using the console::

    > eth.accounts
    ["0x5afdd78bdacb56ab1dad28741ea2a0e47fe41331", "0x9acb9ff906641a434803efb474c96a837756287f"]

via RPC::

    # Request
    $ curl -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1} http://127.0.0.1:8545'

    # Result
    {
      "id":1,
      "jsonrpc": "2.0",
      "result": ["0x5afdd78bdacb56ab1dad28741ea2a0e47fe41331", "0x9acb9ff906641a434803efb474c96a837756287f"]
    }

If you want to use an account non-interactively, you need to unlock it::

    $ geth account new --password <(echo this is not secret!) 
    $ geth --password <(echo this is not secret!) --unlock primary --rpccorsdomain localhost

    说明: 部分用accounts地址, 部分用索引(0,5)
    $ geth --unlock "0x407d73d8a49eeb85d32cf465507dd71d507100c1,0,5,e470b1a7d2c9c5c6f03bbaa8fa20db6d404a0c32"

    On the console(只解锁几秒钟):
    > personal.unlockAccount(address, "password", 300)

Checking account balances::

    > web3.fromWei(eth.getBalance(eth.coinbase), "ether")
    6.5

    js版:
    function checkAllBalances() {
        var totalBal = 0;
        for (var acctNum in eth.accounts) {
            var acct = eth.accounts[acctNum];
            var acctBal = web3.fromWei(eth.getBalance(acct), "ether");
            totalBal += parseFloat(acctBal);
            console.log("  eth.accounts[" + acctNum + "]: \t" + acct + " \tbalance: " + acctBal + " ether");
        }
        console.log("  Total balance: " + totalBal + " ether");
    };
    > checkAllBalances();
      eth.accounts[0]: 0xd1ade25ccd3d550a7eb532ac759cac7be09c2719   balance: 63.11848 ether
      eth.accounts[1]: 0xda65665fc30803cb1fb7e6d86691e20b1826dee0   balance: 0 ether
      eth.accounts[2]: 0xe470b1a7d2c9c5c6f03bbaa8fa20db6d404a0c32   balance: 1 ether
      eth.accounts[3]: 0xf4dd5c3794f1fd0cdc0327a83aa472609c806e99   balance: 6 ether
      Total balance: 70.11848 ether



Updating an existing account
============================

Account update::

    $ geth account update a94f5374fce5edbc8e2a8697c15331677e6ebf0b
    Unlocking account a94f5374fce5edbc8e2a8697c15331677e6ebf0b | Attempt 1/3
    Passphrase:                             注1: 输入老密码解锁
    0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b
    Account 'a94f5374fce5edbc8e2a8697c15331677e6ebf0b' unlocked.
    Please give a new password. Do not forget this password.
    Passphrase:                             注2: 输入新密码
    Repeat Passphrase:
    0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b

实例::

    $ geth account update 5afdd78bdacb56ab1dad28741ea2a0e47fe41331 9acb9ff906641a434803efb474c96a837756287f
    $ geth account update 0 1 2










