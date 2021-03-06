var web3 = new Web3(Web3.givenProvider);
var gameInstance;
var player = {};
var playerHelp = function ()
{
  console.log('%cHere a list of command for you:', 'color:yellow; font-weight: bold;');
  console.log('To display the ABI type:' + ' ' + '%cgame.methods' ,'color:red; font-weight: bold;');
  console.log('To send a tx type:' + ' ' + '%cgame.methods.functionName(@params).send({value:})' ,'color:red; font-weight: bold;');
  console.log('To call a view function and see the returned values type:' + ' ' + '%cawait game.methods.functionName.call()' ,'color:red; font-weight: bold;');
}

$(document).ready( function () {
  connect();

  function connect () {
    window.ethereum.enable().then(function(accounts){
      game = new web3.eth.Contract(mainAbi, "0x5fB831Cf44b64e6c05B3D0e77Ff8A8Cf0e8c49Db", {from: accounts[0]});
    });

    console.log(
      '%cWelcome! ' + '%cClick ' + '%cthe ' + '%cbutton ' + '%cGet ' + '%cNew ' + '%cInstance ' + '%cto ' + '%cstart ' + '%ca ' + '%cnew ' + '%cgame ',
      "color:red; font-size: 20px","color:blue; font-size: 20px","color:red; font-size: 20px","color:blue; font-size: 20px","color:red; font-size: 20px","color:blue; font-size: 20px",
      "color:red; font-size: 20px","color:blue; font-size: 20px","color:red; font-size: 20px","color:blue; font-size: 20px","color:red; font-size: 20px","color:blue; font-size: 20px"
    );

    $(".pageId").click(function(){
      gameId = this.id;
      logic_createNewInstance(gameId);
    });

    $('#checkResultButton').click(function(){
      logic_checkInstance();
    })

  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function logic_createNewInstance (_gameId) {
    console.clear();

    let account;
    web3.eth.getAccounts((error,result) => {
      account = result[0];
    })

    game.methods.createNewInstance(_gameId).send();

    game.once('instanceCreated',{
      filter: {_player:account},
      fromBlock: 'latest'
    }, function(error, result){
      if(!error){
        console.log('%cNew instance created','color:yellow;');
        console.log('%cInstance address' + ' ' + result.returnValues._instance ,'color:red;');
        console.log('%cPlayer address' + ' ' + result.returnValues._player ,'color:green;');
        gameInstance = new web3.eth.Contract(welcomeAbi, result.returnValues._instance,{from:account});
        player = {player:result.returnValues._player,deployer:result.returnValues._deployer,instance:result.returnValues._instance};
      } else {
        console.log('failed loading new instance');
      }
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  function logic_checkInstance () {

    let account;
    web3.eth.getAccounts((error,result) => {
      account = result[0];
    })

    if(player.deployer != undefined) {
      game.methods.checkResult(player.deployer).send();
    } else {
      console.log('instance not deployed');
    }

    game.once('instanceCompleted',{
      filter: {
        _player:account,
        _deployer:player.deployer,
        _instance:player.instance
      }, fromBlock: 'latest'

    }, function(error, result){
      console.log(result);
      if(!error){
        if(result.returnValues._result == true) {
          console.log(
            '%cY' + '%co' + '%cu' + '%cw' + '%co' + '%cn',
            "color:red; font-size: 20px","color:blue; font-size: 20px","color:red; font-size: 20px","color:blue; font-size: 20px",
            "color:red; font-size: 20px","color:blue; font-size: 20px"
          );
          let playerLevel = game.methods.getPlayerLevel.call(account);
          console.log('You are now level' + ' ' + playerLevel);
        } else {
          console.log('Try again');
        }
      }
    })
  }

})
