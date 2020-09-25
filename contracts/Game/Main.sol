import "../Game_Controls/Bank.sol";
import "../Game_Controls/Players.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


interface DeploymentInterface {
  function newInstance() external returns (address);
  function check (address _instance, address _player) external returns (bool);
}

pragma solidity 0.6.2;

contract Main is Players, Ownable, Bank {

  using SafeMath for uint256;

  event instanceCreated (address _player,address _deployer,address _instance);
  event instanceCompleted (address _player,address _deployer,address _instance, bool _result);

  // Returns true if the game is registered.
  // Only registered levels can deploy instances.
  mapping (address => bool) public activeLevel;

  // Owner can add levels.
  function addLevel (address [] memory _deployer) public onlyOwner {
    for (uint i = 0; i < _deployer.length; i++){
      activeLevel[_deployer[i]] = true;
    }
  }

  uint256 constant rewardAmount = 10 ** 19; // 10 tokens

  constructor (address [] memory _deployer) Bank() public {
    addLevel(_deployer);
  }


  // Main function
  // Creates a new instance for game _level
  function createNewInstance (address _deployer) public returns (address) {

    // Require level is active
    require(activeLevel[_deployer], 'not an active level');

    // Make sure lvl not already won
    require(players[msg.sender].completeLevels[_deployer] == false);

    // Check if player has already an instance for the _level
    if(players[msg.sender].instanceByLvl[_deployer] != address(0)){
      delete(players[msg.sender].instanceByLvl[_deployer]);
    }

    // Deploy new instance of the _level
    DeploymentInterface implementation = DeploymentInterface(_deployer);
    address instance = implementation.newInstance();

    players[msg.sender].instanceByLvl[_deployer] = instance;

    emit instanceCreated(msg.sender,_deployer,instance);
  }

  function checkResult (address _deployer) public {

    DeploymentInterface implementation = DeploymentInterface(_deployer);

    address instance = players[msg.sender].instanceByLvl[_deployer];

    bool result = implementation.check(instance,msg.sender);

    if(result) {
      players[msg.sender].completeLevels[_deployer] = true;
      mintIRT (msg.sender,rewardAmount);
    }
    emit instanceCompleted (msg.sender,_deployer,instance,result);
  }

  /**
  * @dev Each IRT grants 1 level.
  * @param _amount Has to be 10 ** 18 or mutiple.
  * @notice _amount 1.2 IRT will result in 1 IRT burnt.
  */
  function levelUp (uint256 _amount) public   {
    require (_amount >= 10 ** 18);
    uint256 base = _amount.div(1 ether);
    uint256 toBurn = base * (10**18);
    burnIRT(toBurn);
    players[msg.sender].playerLevel = players[msg.sender].playerLevel.add(base);
  }

}
