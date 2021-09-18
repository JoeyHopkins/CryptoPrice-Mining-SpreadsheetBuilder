const Web3 = require('web3');

// public address of wallet
const PubKey = "<Insert wallet address here>";

// address of RPC
const web3 = new Web3('<Insert RPC address here>');

//return balance
async function returnBalance(pubKey){
        //get balances
        const balance = web3.utils.fromWei(await web3.eth.getBalance(pubKey), 'ether');
        console.log(balance);
     return balance
}

accountBalance = returnBalance(PubKey);



