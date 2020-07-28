import "./Easy/Entrance.sol";
import "./Easy/TheGreatHall.sol";
import "../Game_Controls/Players.sol";
import "../Game_Controls/Bank.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
* @dev Player must registere itself to play.
*      Player must call addPlayer().
*/


pragma solidity 0.6.2;

contract Main is Players, Entrance, TheGreatHall, Bank{

  using SafeMath for uint256;

  /**
  * @dev A mapping for completed lvl => address _player.
  *      Avoid multiple payements for each level.
  */
  mapping (address => uint256) public completedLevels;

  uint256 constant rewardAmount = 10 ** 18;

  constructor () Bank() public {}

  /**
  * @dev Contract can be found in Game > Easy.
  * @dev lvl = 0;
  */
  function play_ent0 (address _playerContractAddress) public onlyPlayer {
    ent_0(_playerContractAddress);
    canPay(0);

  }

  /**
  * @dev Contract can be found in Game > Easy.
  * @dev lvl = 1;
  */
  function play_tgh () public onlyPlayer {
    if (timer[msg.sender] >= now) {
      canPay(1);
    } else {
      reset (msg.sender);
    }
  }

  /**
  * @dev Verify that the _lvlN is not completed already.
  *      Each time a level is completed and the IRT token is mint,
  *      completedLevels get the _lvlN pushed.
  *      It avoids muiltiple minting for the same level.
  */
  function canPay (uint256 _lvlN) private {
    for (uint256 i=0;i<players[msg.sender].completeLevels.length;i++){
      if(players[msg.sender].completeLevels[i]==_lvlN){revert();}
    }
    players[msg.sender].completeLevels.push(_lvlN);
    _mint (msg.sender,rewardAmount);
  }

  /**
  * @dev Each IRT grants 1 level.
  * @param _amount Has to be 10 ** 18 or mutiple.
  * @notice _amount 1.2 IRT will result in 1 ERT burnt.
  */
  function levelUp (uint256 _amount) public onlyPlayer {
    require (_amount >= 10 ** 18);
    uint256 amountToBurn = isMultiple(_amount);
    require (burnIRT(amountToBurn));
    uint256 increase = amountToBurn / 10 ** 18;
    players[msg.sender].playerLevel.add(increase);
  }

  /**
  * @dev This function is called by levelUp.
  * @param _n The amount of token to burn.
  * @notice This function will round the result to a multiple of 10 ** 18.
  */
  function isMultiple (uint256 _n) internal view returns (uint256) {
    uint256 p = 10 ** 18;
    uint256 t = p;
    while(true) {
        if (_n >= t+p) {t= t +p; } else {return t;}
    }
  }
}
