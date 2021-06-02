ACCOUNT OPTIONS
===============

--password: 配置自动解锁账号::

    $ cat ./password
    123456
    123456
    123456  
    $ geth --networkid 123456 --rpc --rpcaddr="0.0.0.0" --rpccorsdomain "*" --mine --minerthreads 1 --unlock 0 --password ./password


