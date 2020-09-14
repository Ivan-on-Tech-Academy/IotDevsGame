import "./utils/Imports.sol";
import "../Game_Controls/Players.sol";
import "../Game_Controls/Bank.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

/**
* @dev Player must registere itself to play.
*      Player must call addPlayer().
*/

pragma solidity 0.6.2;

contract Main is Players, Bank, Imports {

  using SafeMath for uint256;

  uint256 constant rewardAmount = 10 ** 19; // 10 tokens

  constructor () Bank() public {}

  /**
  * @dev Contract can be found in Game > Levels > Level_0.
  *      lvl = 0;
  */
  function playLevel0 (address _playerContractAddress) public onlyPlayer {
    ent_0(_playerContractAddress);
    canPay(0);
  }

  /**
  * @dev Contract can be found in Game > Levels > Level_1.
  *      lvl = 1;
  */
  function playLevel1 () public onlyPlayer {
    if (timer[msg.sender] >= now) {
      canPay(1);
    } else {
      reset (msg.sender);
    }
  }

  /**
  * @dev Contract can be found in Game > Levels > Level_2.
  *      lvl = 2;
  */
  function playLevel2 (uint256 _n) public onlyPlayer {
    bool check;
    check = go(_n);
    require (check);
    canPay(2);
  }

  /**
  * @dev Contract can be found in Game > Levels > Level_3.
  *      lvl = 3;
  */
  function playLevel3 (address _owner) public onlyPlayer {
    bool check;
    check = findIt(_owner);
    require (check);
    canPay(3);
  }

  /**
  * @dev Contract can be found in Game > Levels > Level_4.
  *      lvl = 4;
  */
  function playLevel4 (address _playerContractAddress) public onlyPlayer {
    bool check;
    check = playERC(_playerContractAddress);
    require (check);
    canPay(4);
  }

  /**
  * @dev Verify that the _lvlN is not completed already.
  *      Each time a level is completed and the IRT token is mint,
  *      completedLevels get the _lvlN pushed.
  *      It avoids muiltiple minting for the same level.
  * @notice verifyCapOverflow() makes sure that no token is minted if
  *         it overflows total token cap.
  */
  function canPay (uint256 _lvlN) private {
    verifyCapOverflow(rewardAmount);
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

}
