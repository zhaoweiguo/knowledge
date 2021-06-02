debug Namespace
###############

debug_traceTransaction
======================

+---------+--------------------------------------------------------------------------------------------+
| Client  | Method invocation                                                                          |
+=========+============================================================================================+
| Go      | debug.TraceTransaction(txHash common.Hash, logger vm.LogConfig) (ExecutionResurt, error)   |
+---------+--------------------------------------------------------------------------------------------+
| Console | debug.traceTransaction(txHash, [options])                                                  |
+---------+--------------------------------------------------------------------------------------------+
| RPC     | {"method": "debug_traceTransaction", "params": [txHash, {}]}                               |
+---------+--------------------------------------------------------------------------------------------+

::

    > debug.traceTransaction("0x2059dd53ecac9827faad14d364f9e04b1d5fe5b506e3acc886eff7a6f88a696a")
    {
      gas: 85301,
      returnValue: "",
      structLogs: [{
          depth: 1,
          error: "",
          gas: 162106,
          gasCost: 3,
          memory: null,
          op: "PUSH1",
          pc: 0,
          stack: [],
          storage: {}
      },...]
    }


    $ curl -H "Content-Type: application/json" -d '{
        "id": 1, 
        "method": "debug_traceTransaction", 
        "params": ["0xfc9359e49278b7ba99f59edac0e3de49956e46e530a53c15aa71226b7aa92c6f"]
      }' localhost:8545

    txhash="0xfc9359e49278b7ba99f59edac0e3de49956e46e530a53c15aa71226b7aa92c6f"
    > debug.traceTransaction(txhash, 
          {disableStack: true, disableMemory: true, disableStorage: true})

    > debug.traceTransaction(txhash, {tracer: '{
        data: [], 
        fault: function(log) {}, 
        step: function(log) { if(log.op.toString() == "CALL") this.data.push(log.stack.peek(0)); }, 
        result: function() { return this.data; }
    }'});

    $ curl -H "Content-Type: application/json" -d '{
        "id": 1, "method": 
        "debug_traceTransaction", 
        "params": [
            "0xfc9359e49278b7ba99f59edac0e3de49956e46e530a53c15aa71226b7aa92c6f", 
            {"disableStack": true, "disableMemory": true, "disableStorage": true}
        ]
      }' localhost:8545







