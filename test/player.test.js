const Main = artifacts.require('Main');
const truffleAssert = require('truffle-assertions');

contract('Players', (accounts) => {

  var mainInstance;
  var oneToken;
  var player = accounts[0];

  before('Set up instance', async () => {
    mainInstance = await Main.new([]);
    oneToken = await web3.utils.toWei("1", 'ether');
  })

  it('Should add a new player', async () => {
    await mainInstance.registerNewPlayer();
    const Main = await mainInstance.players(player);
    assert(Main.tokenId > 0,'player not initialized');
    assert.equal(Main.playerLevel,0,'player level should be 0');
  })

  it('Should have got the ERC721 token', async () => {
    const Main = await mainInstance.players(player);
    let tokenIdPlayer = Main.tokenId;
    let ownerOf = await mainInstance.ownerOf(tokenIdPlayer);
    assert.equal(ownerOf,player,'tokenOwner mismatch');
  })

  it('Should level the player up', async () => {
    await mainInstance.mock();
    const Main = await mainInstance.players(player);
    assert.equal(Main.playerLevel,1,'player level should be 1');
  })

})
