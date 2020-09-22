const Main = artifacts.require('Main');
const truffleAssert = require('truffle-assertions');

contract('Main', (accounts) => {

  var instance;
  var oneToken;

  before ('Set up instance', async () => {
    instance = await Main.new();
    oneToken = await web3.utils.toWei("1", 'ether');
  })

  describe('IRT token verification', () => {

    it ('Should add a new player', async () => {
      await instance.addPlayer({from:accounts[0],value:oneToken});
      const Player = await instance.players(accounts[0]);
      assert.equal(Player.isPlayer,true,'player not initialized');
      assert.equal(Player.playerLevel,0,'player level should be 0');
    })

    it('Should have minted a token to deployer', async () => {
      let ercBalanceA0 =  await instance.balanceOf(accounts[0]);
      assert.equal(ercBalanceA0,oneToken,'ERC token not minted');

      let ercBalanceBank =  await instance.balanceOf(instance.address);
      assert.equal(ercBalanceBank,0,'ERC token minted to bank');
    })

    it('Should have set the total cap for IRT', async () => {
      let totalCap = await instance.getTotalCap();
      assert.equal(totalCap,100000000 * (10 ** 18),'total cap not set');
    })

    it('Should have set IvanRewardToken as token name', async () => {
      let tokenName = await instance.name();
      assert.equal(tokenName,'IvanRewardToken','token name not set');
    })

    it('Should have set IRT as token symbol', async () => {
      let tokenSymbol = await instance.symbol();
      assert.equal(tokenSymbol,'IRT','token symbol not set');
    })

  })

  describe('Staking verification', async() => {

    it('Should allow staking', async () => {
      let ercBalanceA0 =  await instance.balanceOf(accounts[0]);
      await instance.startStaking(ercBalanceA0,10);
    })

    it('Should verify staking', async () => {
      let ercBalanceA0 =  await instance.balanceOf(accounts[0]);
      assert.equal(ercBalanceA0,0,'ERC token not staked');

      let ercBalanceBank = await instance.balanceOf(instance.address);
      assert.equal(ercBalanceBank,oneToken,'ERC token not staked');

      const StakeIt = await instance.staking(accounts[0]);

      let date = Date.now();
      let tolerance = (StakeIt.startTime.toNumber() - date);
      assert(tolerance < 100,'error startTime stake');

      let amountStaked = (StakeIt.amountStaked);
      assert.equal(amountStaked,oneToken,'wrong amount staked');
    })

    it('Should end staking and return funds', async () => {
      await instance.testEndStaking(1, {from:accounts[0]});

      let ercBalanceA0 =  await instance.balanceOf(accounts[0]);
      assert(ercBalanceA0 > oneToken,'ERC token not returned or 0 interest');

      let ercBalanceBank = await instance.balanceOf(instance.address);
      assert.equal(ercBalanceBank,0,'ERC token not returned');
    })

    it('Should level up accounts[0]', async () => {
      let ercBalanceA0 =  await instance.balanceOf(accounts[0]);

      await instance.levelUp(ercBalanceA0);

      const Player = await instance.players(accounts[0]);

      assert.equal(Player.playerLevel,1,'player level should be 1');

      let newErcBalanceA0 =  await instance.balanceOf(accounts[0]);

      assert(newErcBalanceA0.toNumber() >= ercBalanceA0-oneToken,'mismatch in burning function'); // >= to avoid rounding from JS //
    })

    it('Should have decreased the total cap when user lvl up', async() =>{
      let totalCap = await instance.getTotalCap();
      assert(totalCap < 100000000 * (10 ** 18), 'total cap not decreased');
    })

    it('Should not overflow the total cap', async () => {
      truffleAssert.fails(instance.mintLotsOfTokens(),"Cap overlow, mint reversed");
    })
  })
})
