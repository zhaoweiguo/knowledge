fs = require('fs');
const Web3 = require('web3');
var Tx = require('ethereumjs-tx');
const web3 = new Web3('http://localhost:8545');
console.log(web3.version)

coinbase  = "0xaa96686a050e4916afbe9f6d8c5107062fa646dd";
address   = "0x372fda02e8a1eca513f2ee5901dc55b8b5dd7411"
contractAddress = "0x9ABcF16f6685fE1F79168534b1D30056c90B8A8A"

const main = async () => {
  var balance = await web3.eth.getBalance(coinbase);
  console.log(`Balance ETH: ${balance} \n`);

  const abi = fs.readFileSync('output/NetkillerToken.abi', 'utf-8');
  const contract = new web3.eth.Contract(JSON.parse(abi), contractAddress, { from: address});

  var balance = await contract.methods.balanceOf(address).call();
  console.log(`Balance before send: ${balance} \n`);

  var count = await web3.eth.getTransactionCount(coinbase);
  const gasPrice = await web3.eth.getGasPrice();
  console.log(`gasPrice: ${gasPrice}\n`)
      var gasLimit = 1000000;
  var transferAmount = 1000;
    // Chain ID of Ropsten Test Net is 3, replace it to 1 for Main Net
    var chainId = 1;

    var rawTransaction = {
        "from": coinbase,
        /* "nonce": "0x" + count.toString(16),*/
        "nonce":  web3.utils.toHex(count),
        "gasPrice": web3.utils.toHex(gasPrice),
        "gasLimit": web3.utils.toHex(gasLimit),
        "to": contractAddress,
        "value": "0x0",
        "data": contract.methods.transfer(address, transferAmount).encodeABI(),
        "chainId": web3.utils.toHex(chainId)
    };

    console.log(`Raw of Transaction: \n${JSON.stringify(rawTransaction, null, '\t')}\n`);

    // The private key for myAddress in .env
    var privateKey = new Buffer(process.env["PRIVATE_KEY"], 'hex');
    var tx = new Tx(rawTransaction);
    tx.sign(privateKey);
    var serializedTx = tx.serialize();

    // Comment out these four lines if you don't really want to send the TX right now
    console.log(`Attempting to send signed tx:  ${serializedTx.toString('hex')}\n`);

    var receipt = await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'));

    // The receipt info of transaction, Uncomment for debug
    console.log(`Receipt info: \n${JSON.stringify(receipt, null, '\t')}\n`);

    // The balance may not be updated yet, but let's check
  var balance = await contract.methods.balanceOf(address).call();
  console.log(`Balance after send: ${balance}`);
}

main();




