import "../Game_Controls/Players.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


interface DeploymentInterface {
  function newInstance() external returns (address);
  function check (address _instance, address _player) external returns (bool);
}

pragma solidity 0.6.2;

contract Main is Players, Ownable {

  using SafeMath for uint256;

  /**
  * instanceCreated is emitted when a new instance is created.
  * instanceCompleted is emitted when an instance is completed.
  */
  event instanceCreated (address _player,address _deployer,address _instance);
  event instanceCompleted (address _player,address _deployer,address _instance, bool _result);

  /**
  * @dev Returns true if the game is registered.
  * @dev Only registered levels can deploy instances.
  */
  mapping (address => bool) public activeLevel;

  constructor (address [] memory _deployer) public {
    addLevel(_deployer);
  }

  /**
  * @dev Owner can add levels.
  * @param _deployer is the address of the deployer contract.
  */
  function addLevel (address [] memory _deployer) public onlyOwner {
    for (uint i = 0; i < _deployer.length; i++){
      activeLevel[_deployer[i]] = true;
    }
  }


  /**
  * @dev Creates a new game instance.
  * @param _deployer is the address of the deployer contract.
  */
  function createNewInstance (address _deployer) public isPlayer returns (address) {

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

  /**
  * @dev Check the result of an instance.
  * @param _deployer is the address of the deployer contract.
  */
  function checkResult (address _deployer) public {

    DeploymentInterface implementation = DeploymentInterface(_deployer);

    address instance = players[msg.sender].instanceByLvl[_deployer];

    bool result = implementation.check(instance,msg.sender);

    if(result) {
      players[msg.sender].completeLevels[_deployer] = true;
      _increasePlayerLevel(msg.sender);
    }
    emit instanceCompleted (msg.sender,_deployer,instance,result);
  }

}
