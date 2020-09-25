import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity 0.6.2;

contract Players is ERC721 {

  using SafeMath for uint256;

  uint256 private tokenCounter;
  address [] public playersList;

  constructor ()
  ERC721("PlayerToken","PLT")
  public {
    tokenCounter = 0;
    _safeMint(address(this),tokenCounter);
    tokenCounter = tokenCounter.add(1);
  }

  struct Player {
    uint256 tokenId; // A unique ERC721 generated for the player
    uint256 playerLevel; // The level of the player
    mapping(address => address) instanceByLvl; // save the instance address for _lvl address
    mapping(address => bool) completeLevels; // if lvl is complete = true
  }

  mapping (address => Player) public players;

  modifier isPlayer () {
    require (players[msg.sender].tokenId != 0,'not a player');
    _;
  }

  function registerNewPlayer () public {
    _createNewToken (msg.sender);
  }

  function _createNewToken (address _player) private {
    require (players[_player].tokenId == 0,'player has already a token');
    players[_player].tokenId = tokenCounter;
    tokenCounter = tokenCounter.add(1);
    playersList.push(_player);
    _safeMint(_player,players[_player].tokenId);
  }

  function _increasePlayerLevel (address _player) internal {
    require(ownerOf(players[_player].tokenId) == _player);
    players[_player].playerLevel = players[_player].playerLevel.add(1);
  }

  function getPlayerLevel (address _player) public view returns (uint256) {
    return players[_player].playerLevel;
  }

  // testing

  function mock () public {
    _increasePlayerLevel(msg.sender);
  }

}
