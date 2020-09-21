const Players = artifacts.require('Players');
const truffleAssert = require('truffle-assertions');

contract('Players', (accounts) => {

  var instance;
  var oneToken;

  before ('Set up instance', async () => {
    instance = await Players.new();
    oneToken = await web3.utils.toWei("1", 'ether');
  })

  it ('Should add a new player', async () => {
    await instance.addPlayer({from:accounts[0],value:oneToken});
    const Player = await instance.players(accounts[0]);
    assert.equal(Player.isPlayer,true,'player not initialized');
    assert.equal(Player.playerLevel,0,'player level should be 0');
  })

  it ('Should remove a player', async () => {
    await instance.removePlayer({from:accounts[0]});
    const Player = await instance.players(accounts[0]);
    assert.equal(Player.isPlayer,false,'player not removed');
  })

  it('Should make sure these txs fail', async () => {
    truffleAssert.fails(instance.addPlayer({from:accounts[0],value:oneToken/2}),"Register a new player costs 1 ether");
    truffleAssert.fails(instance.removePlayer({from:accounts[0]}),"No such player");
  })
})
