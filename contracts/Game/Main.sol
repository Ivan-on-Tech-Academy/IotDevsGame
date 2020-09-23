import "../Game_Controls/Bank.sol";
import "../Game_Controls/Players.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


interface DeploymentInterface {
  function newInstance() external view returns (address);
  function check (address _instance, address _player) external returns (bool);
}

pragma solidity 0.6.2;

contract Main is Players, Ownable, Bank {

  using SafeMath for uint256;

  // Returns true if the game is registered.
  // Only registered levels can deploy instances.
  mapping (address => bool) activeLevel;

  // Owner can add levels.
  function addLevel (address [] memory _levels) public onlyOwner {
    for (uint i = 0; i < _levels.length; i++){
      activeLevel[_levels[i]] = true;
    }
  }

  uint256 constant rewardAmount = 10 ** 19; // 10 tokens

  constructor (address [] memory _levels) Bank() public {
    addLevel(_levels);
  }


  // Main function
  // Creates a new instance for game _level
  function createNewInstance (address _level) public returns (address){

    // Require level is active
    require(activeLevel[_level]);

    // Check if player has already an instance for the _level
    if(players[msg.sender].instanceByLvl[_level] != address(0)){
      return players[msg.sender].instanceByLvl[_level];
    }

    // Deploy new instance of the _level
    DeploymentInterface implementation = DeploymentInterface(_level);
    address instance = implementation.newInstance();
    return instance;
  }

  function checkResult (address _level,address _instance) public returns (bool) {

    // Make sure lvl not already won
    require(players[msg.sender].completeLevels[_level] == false);

    DeploymentInterface implementation = DeploymentInterface(_instance);

    bool result = implementation.check(_instance,msg.sender);

    if(result) {
      players[msg.sender].completeLevels[_level] = true;
      mintIRT (msg.sender,rewardAmount);
    }
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
