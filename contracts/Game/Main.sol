import "./Easy/Entrance.sol";
import "./Easy/TheGreatHall.sol";

import "../Game_Controls/Players.sol";
import "../Game_Controls/Bank.sol";

/**
* @dev Player must registere itself to play.
* @dev Player must call addPlayer().
*/


pragma solidity 0.6.2;

contract Main is Players, Entrance, TheGreatHall, Bank{

  uint256 constant rewardAmount = 10 ** 18;

  constructor () Bank() public {}

  /**
  * @dev Contract can be found in Game > Easy.
  */
  function play_ent0 (address _playerContractAddress) public onlyPlayer {
    bool control;
    control = ent_0(msg.sender,_playerContractAddress);
    require (control == true,"ent_0 failed");
    _mint (msg.sender,rewardAmount);
  }

  /**
  * @dev Contract can be found in Game > Easy.
  */
  function play_tgh () public onlyPlayer {
    if (timer[msg.sender] >= now) {
      _mint (msg.sender,rewardAmount);
    } else {
      reset (msg.sender);
    }
  }
}
