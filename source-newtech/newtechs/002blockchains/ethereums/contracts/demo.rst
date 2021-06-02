实例
####

查看智能合约编译器 [1]_ ::

  > eth.compile


实例::

    pragma solidity ^0.4.18;

    contract Netkiller {
        string name;
        int num;
        function Netkiller() public{
            name = "default";
            num = 1;
        }
        function setName(string _name) public{
            name = _name;
        }
        function getName() public view returns(string){
            return name;
        }
        function setNum(int n) public{
            num = n;
        }
        function addNum(int m) public view returns(int res){
            res = m + num;
        }
    }

solc --bin --abi --optimize -o output Netkiller.sol::

    var abi = JSON.parse('[
        {
          "constant":true,
          "inputs":[],
          "name":"getName",
          "outputs":[{"name":"","type":"string"}],
          "payable":false,
          "stateMutability":"view",
          "type":"function"
        },{
          "constant":false,
          "inputs":[{"name":"n","type":"int256"}],
          "name":"setNum",
          "outputs":[],
          "payable":false,
          "stateMutability":"nonpayable",
          "type":"function"
        },{
          "constant":false,
          "inputs":[{"name":"_name","type":"string"}],
          "name":"setName",
          "outputs":[],
          "payable":false,
          "stateMutability":"nonpayable",
          "type":"function"
        },{
          "constant":true,
          "inputs":[{"name":"m","type":"int256"}],
          "name":"addNum",
          "outputs":[{"name":"res","type":"int256"}],
          "payable":false,
          "stateMutability":"view",
          "type":"function"
        },{
          "inputs":[],
          "payable":false,
          "stateMutability":"nonpayable",
          "type":"constructor"
        }]');
    
    var bytecode = "0x6060604052341561000f57600080fd5b6040805190810160405280600781526020017f64656661756c74000000000000000000000000000000000000000000000000008152506000908051906020019061005a929190610067565b506001808190555061010c565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a857805160ff19168380011785556100d6565b828001600101855582156100d6579182015b828111156100d55782518255916020019190600101906100ba565b5b5090506100e391906100e7565b5090565b61010991905b808211156101055760008160009055506001016100ed565b5090565b90565b61036b8061011b6000396000f300606060405260043610610062576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806317d7de7c146100675780636a5aa5ec146100f5578063c47f002714610118578063cc13962a14610175575b600080fd5b341561007257600080fd5b61007a6101ac565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100ba57808201518184015260208101905061009f565b50505050905090810190601f1680156100e75780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561010057600080fd5b6101166004808035906020019091905050610254565b005b341561012357600080fd5b610173600480803590602001908201803590602001908080601f0160208091040260200160405190810160405280939291908181526020018383808284378201915050505050509190505061025e565b005b341561018057600080fd5b6101966004808035906020019091905050610278565b6040518082815260200191505060405180910390f35b6101b4610286565b60008054600181600116156101000203166002900480601f01602080910402602001604051908101604052809291908181526020018280546001816001161561010002031660029004801561024a5780601f1061021f5761010080835404028352916020019161024a565b820191906000526020600020905b81548152906001019060200180831161022d57829003601f168201915b5050505050905090565b8060018190555050565b806000908051906020019061027492919061029a565b5050565b600060015482019050919050565b602060405190810160405280600081525090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102db57805160ff1916838001178555610309565b82800160010185558215610309579182015b828111156103085782518255916020019190600101906102ed565b5b509050610316919061031a565b5090565b61033c91905b80821115610338576000816000905550600101610320565b5090565b905600a165627a7a7230582002b42864089a104d4d80ba0190924e09e15f3c0d0aa107463f49e2689e159b480029";

    var gas = web3.eth.estimateGas({data: bytecode})
    var deploy = {from:eth.coinbase, data: bytecode, gas: gas};
    var address  = eth.coinbase;

    personal.unlockAccount(eth.accounts[0],"abc123")

    var mycontract = web3.eth.contract(abi)
 
    var instance = mycontract.new({from:eth.coinbase, data:bytecode, gas:300000}, 
      function(e, contract){
        if(!e) {
          if(!contract.address) {
            console.log("Contract transaction send: TransactionHash: " + contract.transactionHash + " waiting to be mined...");

          } else {
            console.log("Contract mined! Address: " + contract.address);
            console.log(contract);
          }

        }
    }); 

    var test = mycontract.at(eth.coinbase)
    test.addNum(567);




.. [1] http://www.netkiller.cn/blockchain/ethereum/web3/web3.js.js.contracts.html