import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Bank.sol";

pragma solidity 0.6.2;

contract Players {

  using SafeMath for uint256;

  struct P {
    bool isPlayer;
    uint256 playerLevel;
    uint256 [] completeLevels;
  }

  mapping (address => P) public players;

  /**
  * @dev Require player is registered.
  */
  modifier onlyPlayer () {
    require (players[msg.sender].isPlayer == true,"No such player");
    _;
  }

  /**
  * @dev Enable a new player.
  * @notice Registration cost is 1 ether.
  */
  function addPlayer () public payable {
    require (msg.value == 1 ether,"Register a new player costs 1 ether");
    players[msg.sender].isPlayer = true;
  }

  /**
  * @dev A player can disable itself.
  */
  function removePlayer () public onlyPlayer {
    delete(players[msg.sender].isPlayer);
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
