import "@openzeppelin/contracts/math/SafeMath.sol";
import "./Bank.sol";

pragma solidity 0.6.2;

contract Players {

  using SafeMath for uint256;
  using SafeMath for uint16;

  struct Player {
    uint256 playerLevel;
    mapping(uint => bool) completeLevels;
    bool isPlayer;
  }

  mapping (address => Player) public players;

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


}
