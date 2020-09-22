var web3 = new Web3(Web3.givenProvider);

$(document).ready( function () {
  connect();
})

function connect () {
  window.ethereum.enable().then(function(accounts){
    game = new web3.eth.Contract(abi, "0x793ac9EA22E00Ae999d8AF2284B82c504807B817", {from: accounts[0]});
    $("#connectButton").hide();
  });
  setTimeout(console.clear,1500);
  return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
