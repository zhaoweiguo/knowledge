常见问题
===============

连接不成功的常见问题::

  1.本地时钟问题:
  原因:快12秒就可能导致无连接
  解决:sudo ntpdate -s time.nist.gov

  2.防火墙问题
  原因:以太坊连接其他结点的本质是通过udp协议，有些防火墙会阻止UDP的传输
  解决:
    a.使用static nodes
    b.使用方法admin.addPeer()增加结点


编译错误::

  wei64@myserver:~/go-ethereum$ make
  build/env.sh go run build/ci.go install ./cmd/geth# runtime/usr/local/go/src/runtime/mstkbar.go:151:10: debug.gcstackbarrieroff undefined (type struct { allocfreetrace int32; cgocheck int32; efence int32; gccheckmark int32; gcpacertrace int32; gcshrinkstackoff int32; gcrescanstacks int32; gcstoptheworld int32; gctrace int32; invalidptr int32; sbrk int32; scavenge int32; scheddetail int32; schedtrace int32 } has no field or method gcstackbarrieroff)
  /usr/local/go/src/runtime/mstkbar.go:162:24: division by zero
  /usr/local/go/src/runtime/mstkbar.go:162:44: undefined: stkbar
  /usr/local/go/src/runtime/mstkbar.go:183:23: undefined: cgocallback_gofuncPC
  /usr/local/go/src/runtime/mstkbar.go:212:4: gp.stkbar undefined (type *g has no field or method stkbar)
  /usr/local/go/src/runtime/mstkbar.go:213:15: gp.stkbar undefined (type *g has no field or method stkbar)
  /usr/local/go/src/runtime/mstkbar.go:216:23: undefined: stackBarrierPC
  /usr/local/go/src/runtime/mstkbar.go:226:28: gp.stkbarPos undefined (type *g has no field or method stkbarPos)
  /usr/local/go/src/runtime/mstkbar.go:227:19: gp.stkbarPos undefined (type *g has no field or method stkbarPos)
  /usr/local/go/src/runtime/mstkbar.go:248:41: undefined: stkbar
  /usr/local/go/src/runtime/mstkbar.go:227:19: too many errors
  Makefile:15: recipe for target 'geth' failed
  make: *** [geth] Error 2

  原因:未知
  解决方案:从别的电脑上编译成功后，把生成的二进制文件copy到这儿来

web3.eth.sendTransaction写入失败
-----------------------------------
失败原因::

    > var code = "603d80600c6000396000f303";
    undefined
    > eth.sendTransaction({from: eth.accounts[0], data : code});
    Error: invalid argument 0: json: cannot unmarshal hex string without 0x prefix into Go struct field SendTxArgs.data of type hexutil.Bytes
        at web3.js:3143:20
        at web3.js:6347:15
        at web3.js:5081:36
        at <anonymous>:1:1

原因::

    字节码前面需要添加0x
    这儿是把code的值修改为:
    > var code = "0x603d80600c6000396000f303";

personal.unlockAccount执行失败
-----------------------------------

失败原因::

  (node:28148) UnhandledPromiseRejectionWarning: Unhandled promise rejection (rejection id: 1): Error: Node error: {"code":-32601,"message":"the method personal_unlockAccount does not exist/is not available"}
  (node:28148) [DEP0018] DeprecationWarning: Unhandled promise rejections are deprecated. In the future, promise rejections that are not handled will terminate the Node.js process with a non-zero exit code.

原因::

    使用rpc方式连接，但启动时没有加 4010497
    使用geth.ipc文件连接没有问题，但使用tcp，http，web连接必须用rpcapi指定personal
    如:
    $> geth --datadir="~/ethereum/data4" --networkid 123456 --port 30304 --rpc --rpcaddr="0.0.0.0" --rpccorsdomain "*" -rpcport 8544 --rpcapi web3,db,eth,net,personal

另::

    web3.eth.personal.unlockAccount(address, password, unlockDuraction [, callback])
    是3参数函数,2参数的函数已经过时，如:
    web3.eth.personal.unlockAccount(
      "0x11f4d0A3c12e86B4b5F39B213F7E19D048276DAe", 
      "password", 
      600).then(console.log('Account unlocked!'));


设置的交易Gas不足.
---------------------

失败现象::

    Error: gas required exceeds allowance or always failing transaction

解决方案::

    提交交易前, 将Tranasctor.GasLimit设置为一个较大的值. 
    但该值又"不能大于"配置文件gensis.json中的gasLimit字段的值.














