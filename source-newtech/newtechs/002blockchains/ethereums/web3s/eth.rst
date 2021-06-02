eth Namespace
#############

此ns是默认开放的2个ns之一

eth_call
========

+----------+----------+-------+----------+----------------------------------------------+
| Field    | Type     | Bytes | Optional | Description                                  |
+==========+==========+=======+==========+==============================================+
| from     | Address  | 20    | Yes      | Address to have been sent from.              |
+----------+----------+-------+----------+----------------------------------------------+
| to       | Address  | 20    | No       | Address the transaction is sent to.          |
+----------+----------+-------+----------+----------------------------------------------+
| gas      | Quantity | <8    | Yes      | Maximum gas allowance for the code           |
+----------+----------+-------+----------+----------------------------------------------+
| gasPrice | Quantity | <32   | Yes      | Number of wei to paying for each unit of gas |
+----------+----------+-------+----------+----------------------------------------------+
| value    | Quantity | <32   | Yes      | Amount of wei to sending                     |
+----------+----------+-------+----------+----------------------------------------------+
| data     | Binary   | any   | Yes      | Binary data to send to the target contract.  |
+----------+----------+-------+----------+----------------------------------------------+

实例::

    {
      "from": "0xd9c9cd5f6779558b6e0ed4e6acf6b1947e7fa1f3",
      "to":   "0xebe8efa441b9302a0d7eaecc277c09d20d684540",
      "gas":  "0x1bd7c",
      "data": "0xd459fc.......b0ca9ca983a22d86a70628",
    }




其他
====

转帐::

    > eth.sendTransaction({
        from: '0x08268e9540b8d21f0867ce436e792777737ecfb6', 
        to: '0x6eb4fe3bbcc30bb2f588996d9947398c77637ddb', 
        value: web3.toWei(1, "ether")
      })




