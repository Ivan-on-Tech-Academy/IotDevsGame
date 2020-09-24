const Main = artifacts.require("Main");
const WelcomeDeployer = artifacts.require("WelcomeDeployer");
const TakeOwneshipDeployer = artifacts.require("TakeOwneshipDeployer");
const EntranceDeployer = artifacts.require("EntranceDeployer");
const TheGreatHallDeployer = artifacts.require("TheGreatHallDeployer");
const ThinkBigDeployer = artifacts.require("ThinkBigDeployer");
const FindTheOwnerDeployer = artifacts.require("FindTheOwnerDeployer");
const TestERC20Deployer = artifacts.require("TestERC20Deployer");

module.exports = function(deployer) {

  deployer.deploy(WelcomeDeployer);
  deployer.deploy(TakeOwneshipDeployer);
  deployer.deploy(EntranceDeployer);
  deployer.deploy(TheGreatHallDeployer);
  deployer.deploy(ThinkBigDeployer);
  deployer.deploy(FindTheOwnerDeployer);
  deployer.deploy(TestERC20Deployer);
  deployer.deploy(
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
