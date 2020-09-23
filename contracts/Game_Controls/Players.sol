import "@openzeppelin/contracts/math/SafeMath.sol";

pragma solidity 0.6.2;

contract Players {

  using SafeMath for uint256;
  using SafeMath for uint16;

  struct Player {
    uint256 playerLevel;
    bool isPlayer;
    mapping(address => address) instanceByLvl; // save the instance address for _lvl address
    mapping(address => bool) completeLevels; // if lvl is complete = true
  }

  mapping (address => Player) public players;

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
  function removePlayer () public   {
    delete(players[msg.sender]);
  }


}
