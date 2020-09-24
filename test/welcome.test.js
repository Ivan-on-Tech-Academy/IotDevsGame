const Main = artifacts.require('Main');
const Welcome = artifacts.require('Welcome');
const WelcomeDeployer = artifacts.require('WelcomeDeployer');
const truffleAssert = require('truffle-assertions');

contract('Welcome', (accounts) => {

  // The main instance
  var mainInstance;
  // The game instance
  var welcomeInstance;
  // The deployer instance
  var welcomeDeployerInstance;
  // The address of the newly created instance
  var instanceAddress;
  // The game instance
  var game;

  before ('Deploy', async () => {
    welcomeInstance = await Welcome.new();
    welcomeDeployerInstance = await WelcomeDeployer.new();
    mainInstance = await Main.new([welcomeInstance.address]);
  })

  it('Should confirm that the game is active', async () => {
    let lvl = await mainInstance.activeLevel(welcomeInstance.address);
    assert.equal(lvl,true, 'the game is not registered');
  })

  it('Should deploy an instance via main.sol', async () => {
    let result = await mainInstance.createNewInstance
    (
      welcomeInstance.address,
      welcomeDeployerInstance.address
    );

    instanceAddress = result.logs[0].args._instance;
    game = await Welcome.at(instanceAddress);
  })

  it('Should play in the user instance', async () => {
    await game.setPassword();
    let pw = await game.getPassword();
    await game.setOwnership(pw);
  })

  it('Should complete the lvl', async () => {
    let result = await mainInstance.checkResult
    (
      welcomeInstance.address,
      instanceAddress,
      welcomeDeployerInstance.address
    );
    assert.equal(result.logs[1].args._result,true, 'level failed');
  })

})
