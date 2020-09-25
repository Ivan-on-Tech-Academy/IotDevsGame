const Main = artifacts.require("Main");
const WelcomeDeployer = artifacts.require("WelcomeDeployer");
const TakeOwneshipDeployer = artifacts.require("TakeOwneshipDeployer");
const EntranceDeployer = artifacts.require("EntranceDeployer");
const TheGreatHallDeployer = artifacts.require("TheGreatHallDeployer");
const ThinkBigDeployer = artifacts.require("ThinkBigDeployer");
const FindTheOwnerDeployer = artifacts.require("FindTheOwnerDeployer");
const TestERC20Deployer = artifacts.require("TestERC20Deployer");

module.exports = async function(deployer) {

  await deployer.deploy(WelcomeDeployer);
  await deployer.deploy(TakeOwneshipDeployer);
  await deployer.deploy(EntranceDeployer);
  await deployer.deploy(TheGreatHallDeployer);
  await deployer.deploy(ThinkBigDeployer);
  await deployer.deploy(FindTheOwnerDeployer);
  await deployer.deploy(TestERC20Deployer);
  await deployer.deploy(
    Main,
    [
      WelcomeDeployer.address,
      TakeOwneshipDeployer.address,
      EntranceDeployer.address,
      TheGreatHallDeployer.address,
      ThinkBigDeployer.address,
      FindTheOwnerDeployer.address,
      TestERC20Deployer.address,
  ]
  );
};
