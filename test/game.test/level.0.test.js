const Main = artifacts.require('Main');
const TakeOwneship = artifacts.require('TakeOwneship');
const TakeOwneshipDeployer = artifacts.require('TakeOwneshipDeployer');
const truffleAssert = require('truffle-assertions');

contract('TakeOwneship', (accounts) => {

  // The main instance
  var mainInstance;
  // The game instance
  var takeOwneshipInstance;
  // The deployer instance
  var takeOwneshipDeployerInstance;
  // The address of the newly created instance
  var instanceAddress;
  // The game instance
  var game;

  before ('Deploy', async () => {
    takeOwneshipInstance = await TakeOwneship.new();
    takeOwneshipDeployerInstance = await TakeOwneshipDeployer.new();
    mainInstance = await Main.new([takeOwneshipInstance.address]);
  })

  it('Should confirm that the game is active', async () => {
    let lvl = await mainInstance.activeLevel(takeOwneshipInstance.address);
    assert.equal(lvl,true, 'the game is not registered');
  })

  it('Should deploy an instance via main.sol', async () => {
    let result = await mainInstance.createNewInstance
    (
      takeOwneshipInstance.address,
      takeOwneshipDeployerInstance.address
    );

    instanceAddress = result.logs[0].args._instance;
    game = await TakeOwneship.at(instanceAddress);
  })

  it('Should play in the user instance', async () => {
    await game.deposit({value:10 ** 18});
    await game.claimOwnership();
  })

  it('Should complete the lvl', async () => {
    let result = await mainInstance.checkResult
    (
      takeOwneshipInstance.address,
      instanceAddress,
      takeOwneshipDeployerInstance.address
    );
    assert.equal(result.logs[1].args._result,true, 'level failed');
  })

})
